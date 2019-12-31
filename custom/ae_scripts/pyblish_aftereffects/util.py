import os
import socket


def send(cmd, port=None):

    host = '127.0.0.1'
    if not port:
        port = int(os.environ["PYBLISH_AFTEREFFECTS_PORT"])

    # we expect a result no matter if it errors, so we keep trying until we
    # get a reply. This is slow, but relyable.
    keep_trying = True
    result = ""
    while(keep_trying):
        conn = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        conn.connect((host, port))
        conn.send(cmd)
        try:
            result = conn.recv(4096)
            conn.close()
            if result:
                keep_trying = False
        except:
            pass

    # raise error
    if result.startswith("Error: "):
        msg = result.replace("Error: ", "")
        msg += "CMD: " + cmd
        raise ValueError(msg)

    # all replies comes in with a newline
    result = result.replace("\n", "")

    # more Pythonic return of nothing
    if result == "undefined":
        return None

    return result


def stop_server(port=None):
    send("keep_serving = false", port)


if __name__ == '__main__':
    send("return app.version", port=8728)
