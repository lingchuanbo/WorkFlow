"""
    Provide a PySide2 dialog for the pyramid tool.
"""
from PySide2.QtWidgets import QWidget, QDialog, QLabel, QVBoxLayout, QPushButton
from pymxs import runtime as rt
from .graphics import make_pyramid_mesh

class PyMaxDialog(QDialog):
    """
    Custom dialog attached to the 3ds Max main window
    Message label and action push button to create a pyramid in the 3ds 
    Max scene graph
    """
    def __init__(self, parent=QWidget.find(rt.windows.getMAXHWND())):
        super(PyMaxDialog, self).__init__(parent)
        self.setWindowTitle('Pyside2 Qt Window')
        self.init_ui()

    def init_ui(self):
        """ Prepare Qt UI layout for custom dialog """
        main_layout = QVBoxLayout()
        label = QLabel("Click button to create a pyramid in the scene")
        main_layout.addWidget(label)

        btn = QPushButton("Pyramid")
        btn.clicked.connect(make_pyramid_mesh)
        main_layout.addWidget(btn)

        self.setLayout(main_layout)
        self.resize(250, 100)