for obj in selection do
(
CenterPivot obj  --轴心归中心
obj.pivot.z = obj.min.z  --轴心的Z轴等于物体最底点

)