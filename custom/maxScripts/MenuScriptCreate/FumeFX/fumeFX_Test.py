import MaxPlus

#Create your light
# obj = MaxPlus.Factory.CreateOmniLight()
node = MaxPlus.Factory.CreateNode(MaxPlus.Factory.CreateGeomObject(MaxPlus.ClassIds.Box)) 
# LightNode = MaxPlus.Factory.CreateNode(obj)

# def getfumefxgrids():
#     """Helper function that returns a list with all FumeFx Grids in the scene
#     """
#     nodes = []
#     for node in MaxPlus.Core.GetRootNode().Children:
#         if 'fumefx' in node.Object.GetClassName().lower():
#             nodes.append(node)

#     return nodes
#     print nodes

# def GenerateChildNodes(node):
#     for c in node.Children:
#     yield c
#     for d in GenerateChildNodes(c):
#     yield d

# for n in GenerateChildNodes(MaxPlus.Core.GetRootNode()):
#     if n.Object.GetSuperClassID() == MaxPlus.SuperClassIds.Camera:
#     print n.GetName()