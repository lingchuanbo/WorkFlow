ClearListener()

python.execute "
from mxs.lib.toolbox import toolbox
reload(toolbox)
"

-- We can aggregate the Python module to Maxscript by using the python.import method
::toolbox_lib = python.import "mxs.lib.toolbox.toolbox"


-- ::mxs.ReloadPythonModule toolbox_lib


::toolbox = ::toolbox_lib.run(layout_type="b")

