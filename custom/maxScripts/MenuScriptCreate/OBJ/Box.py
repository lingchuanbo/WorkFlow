'''
    Demonstrates creating many different types of scene objects that are visible in the viewport.
    The scene objects are grouped by type. 
    The types created are Cameras, Lights, Geometric Objects, Shapes, Helpers, Modifiers and Materials.
'''
import MaxPlus

def CreateBox():
    # 创建指定的对象 盒子
    box = MaxPlus.Factory.CreateGeomObject(MaxPlus.ClassIds.Box)
    # 创建节点
    boxNode = MaxPlus.Factory.CreateNode(box,'FX_Object')

    # box属性
    # box.ParameterBlock.Length.Value = 50
    # box.ParameterBlock.Width.Value = 50
    # box.ParameterBlock.Height.Value = 50

    return box


    # return box

p=CreateBox()
