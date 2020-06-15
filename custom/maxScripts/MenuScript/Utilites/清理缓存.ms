fn GarbageCollect_FN =
	(
		for i = 1 to 5 do GC()
	)
fn UTIL_CollectMissingFiles_FN arr:#()=
	(
		enumerateFiles get_names arr #missing
		clearListener()
		if arr.count != 0 then for i in arr do print i
		else messageBox "***** 没有丢失文件 *****"
		arr
	)
fn FreeSceneBitmaps_FN =
	(
		for i = 1 to 5 do FreeSceneBitmaps()
	)
fn Get_Names name a =
	(
		append a name
	)
	
	
format "***** Garbage Collection *****\n"
GarbageCollect_FN()
format "***** Collect Missing Files *****\n"
UTIL_collectMissingFiles_FN()
format "***** Free Scene Bitmaps *****\n"
FreeSceneBitmaps_FN()