﻿#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
20200403
@author: BoBO
人生苦短我用Python,此文件为自动生成,可能会被还原!
"""
import os, re
import sys
import ctypes

from win32com.client import Dispatch, GetActiveObject, GetObject

try:
    app = GetActiveObject("Photoshop.Application")
    Path = app.activeDocument.path
    Name = app.activeDocument.name
except:
    ctypes.windll.user32.MessageBoxA(0,u"请先保存文件 !!! .^_ ^".encode('gb2312'),u' BoBO'.encode('gb2312'),0)
    print("文件没保存!")
else:
    command =r'"C:\\Program Files\\Adobe\\Adobe After Effects CC 2018\\Support Files\\AfterFX.exe"'+" "+ Path + Name
    os.system(command)