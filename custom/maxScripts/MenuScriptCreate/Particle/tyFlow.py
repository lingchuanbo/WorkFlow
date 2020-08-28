'''
    Demonstrates creating many different types of scene objects that are visible in the viewport.
    The scene objects are grouped by type. 
    The types created are Cameras, Lights, Geometric Objects, Shapes, Helpers, Modifiers and Materials.
'''
import MaxPlus

def Create_tyFlow():
    # 创建指定的对象 盒子
    mytyFlow = MaxPlus.Factory.CreateGeomObject(MaxPlus.ClassIds.tyFlow)
    # 创建节点
    boxNode = MaxPlus.Factory.CreateNode(mytyFlow,'FX_mytyFlow')

    # box属性
    # mytyFlow.ParameterBlock.iconSize.Value = 100
    # # box.ParameterBlock.Width.Value = 50
    # # box.ParameterBlock.Height.Value = 50

    # return mytyFlow


    # return box

p=Create_tyFlow()
