-- 背景设置为黑色
backgroundColor = color 0 0 0
-- 删除所有灯光
delete lights

-- Example taken from reference
-- 设置动画范围
-- Get the current animation range
-- animationRange
-- (interval 0f 100f)

-- -- Set range to frames 10 to 50
-- animationRange = interval 0 50
-- (interval 10f 50f)

-- -- Get the start frame of the range
-- animationRange.start
-- 10f

-- -- Get the end frame of the range
-- animationRange.end
-- 50f

-- -- To change the end frame of the interval only:
-- animationRange = interval animationRange.start 90f
-- (interval 10f 90f)