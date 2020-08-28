import bpy
from random import randint

#随机创建300个cube，x/y/z范围限制（-30，30）
number = 300
for i in range(0,number):
    x = randint(-30,30)
    y = randint(-30,30)
    z = randint(-30,30)
    bpy.ops.mesh.primitive_cube_add(location=(x,y,z))