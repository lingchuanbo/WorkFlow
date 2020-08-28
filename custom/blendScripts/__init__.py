# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTIBILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
# General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see <http://www.gnu.org/licenses/>.

bl_info = {
    "name" : "Blender",
    "author" : "Blender",
    "description" : "",
    "blender" : (2, 80, 0),
    "version" : (0, 0, 1),
    "location" : "",
    "warning" : "",
    "category" : "Generic"
}

def register():
    ...

def unregister():
    ...
import bpy
from random import randint

#随机创建300个cube，x/y/z范围限制（-30，30）
number = 300
for i in range(0,number):
    x = randint(-30,30)
    y = randint(-30,30)
    z = randint(-30,30)
    bpy.ops.mesh.primitive_cube_add(location=(x,y,z))