'''
    Demonstrates creating many different types of scene objects that are visible in the viewport.
    The scene objects are grouped by type. 
    The types created are Cameras, Lights, Geometric Objects, Shapes, Helpers, Modifiers and Materials.
'''
import MaxPlus
import os
import math

def GeneratePlugins(sid, cls):
    Conform_cid = MaxPlus.Class_ID(0x1ab13757, 0x12365b98) # Known bug
    for cd in MaxPlus.PluginManager.GetClassList().Classes:
        if cd.SuperClassId == sid and cd.ClassId != Conform_cid:
            o = MaxPlus.Factory.CreateAnimatable(sid, cd.ClassId, False)
            if o:
                r = cls._CastFrom(o)
                if r:
                    yield r

# =====================================================================
def CreateBox():
    box = MaxPlus.Factory.CreateGeomObject(MaxPlus.ClassIds.Box)
    box.ParameterBlock.Height.Value = 5.0
    box.ParameterBlock.Width.Value = 5.0
    box.ParameterBlock.Length.Value = 5.0
    return box
    
def CreateText(pos, message):
    tex = MaxPlus.Factory.CreateShapeObject(MaxPlus.ClassIds.text)
    tex.ParameterBlock.size.Value = 20.0
    tex.ParameterBlock.text.Value = message
    node = MaxPlus.Factory.CreateNode(tex)
    node.Position = MaxPlus.Point3(pos.X, pos.Y - 5, pos.Z)
    node.WireColor = MaxPlus.Color(1.0,0.5,1.0)
    
def CreateTeapot():
    box = MaxPlus.Factory.CreateGeomObject(MaxPlus.ClassIds.Teapot)
    box.ParameterBlock.Radius.Value = 5.0
    return box
    
def CreateBoxNode(x,y):
    b = CreateBox()
    node = MaxPlus.Factory.CreateNode(b)
    node.Position = MaxPlus.Point3(x,y,0)
    return node
# =====================================================================
def CreateCameras(y_position):
    CreateText(MaxPlus.Point3(-45,y_position,0), "Cameras" )
    x_position = 0.0
    for obj in GeneratePlugins(MaxPlus.SuperClassIds.Camera, MaxPlus.CameraObject):
        node = MaxPlus.Factory.CreateNode(obj)
        node.Position = MaxPlus.Point3(x_position,y_position,0)
        
        x_position += 10.0
        if ( (x_position % 260.0) < 0.001):
            x_position = 0.0
            y_position += 20
    return y_position

def CreateLights(y_position):
    CreateText(MaxPlus.Point3(-45,y_position,0), "Lights" )
    x_position = 0.0
    for obj in GeneratePlugins(MaxPlus.SuperClassIds.Light, MaxPlus.LightObject):
        node = MaxPlus.Factory.CreateNode(obj)
        node.Position = MaxPlus.Point3(x_position,y_position,0)
        
        x_position += 10.0
        if ( (x_position % 260.0) < 0.001):
            x_position = 0.0
            y_position += 20
    return y_position

def CreateObjects(y_position):
    CreateText(MaxPlus.Point3(-88,y_position,0), "Geometric objects" )
    x_position = 0.0
    for obj in GeneratePlugins(MaxPlus.SuperClassIds.GeomObject, MaxPlus.GeomObject):
        node = MaxPlus.Factory.CreateNode(obj)
        node.Position = MaxPlus.Point3(x_position,y_position,0)
        
        x_position += 10.0
        if ( (x_position % 260.0) < 0.001):
            x_position = 0.0
            y_position += 20
    return y_position

def CreateShapes(y_position):
    CreateText(MaxPlus.Point3(-45,y_position,0), "Shapes" )
    x_position = 0.0
    for obj in GeneratePlugins(MaxPlus.SuperClassIds.Shape, MaxPlus.ShapeObject):
        node = MaxPlus.Factory.CreateNode(obj)
        node.Position = MaxPlus.Point3(x_position,y_position,0)
        
        x_position += 10.0
        if ( (x_position % 260.0) < 0.001):
            x_position = 0.0
            y_position += 20
    return y_position

def CreateHelpers(y_position):
    CreateText(MaxPlus.Point3(-45,y_position,0), "Helpers" )
    x_position = 0.0
    for obj in GeneratePlugins(MaxPlus.SuperClassIds.Helper, MaxPlus.HelperObject):
        node = MaxPlus.Factory.CreateNode(obj)
        node.Position = MaxPlus.Point3(x_position,y_position,0)
        x_position += 10.0
        if ( (x_position % 260.0) < 0.001):
            x_position = 0.0
            y_position += 20
    return y_position

def CreateModifiers(y_position):
    CreateText(MaxPlus.Point3(-45,y_position,0), "Modifiers" )
    x_position = 0.0
    for m in GeneratePlugins(MaxPlus.SuperClassIds.Osm, MaxPlus.Modifier):
        b = CreateBox()
        node = MaxPlus.Factory.CreateNode(b)
        node.Position = MaxPlus.Point3(x_position,y_position,0)
        node.AddModifier(m)
        x_position += 10.0
        if ( (x_position % 260.0) < 0.001):
            x_position = 0.0
            y_position += 20
    return y_position

def CreateMaterials(y_position):
    CreateText(MaxPlus.Point3(-45,y_position,0), "Materials" )
    x_position = 0.0
    b = CreateTeapot()
    for m in GeneratePlugins(MaxPlus.SuperClassIds.Material, MaxPlus.Mtl):
        print m
        node = MaxPlus.Factory.CreateNode(b)
        node.Position = MaxPlus.Point3(x_position,y_position,0)
        node.Material = m
        x_position += 10.0

def CreateStuff():
    MaxPlus.FileManager.Reset(True)
    y = 0.0
    CreateMaterials(y)
    y = 20.0
    y = CreateModifiers(y)
    y += 40.0
    y = CreateHelpers(y)
    y += 40.0
    y = CreateShapes(y)
    y += 40.0
    y = CreateObjects(y)
    y += 40.0
    y = CreateLights(y)
    y += 40.0
    y = CreateCameras(y)

CreateStuff()