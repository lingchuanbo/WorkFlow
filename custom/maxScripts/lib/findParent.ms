fn findParent inputNode =
(
	if not isproperty inputNode "count" do inputNode = #(inputNode)
	outputArray = #()
	for m = inputNode do
	(
		if findItem (inputNode as array) m.parent == 0	do
		(
			append outputArray m
		)
	)
	outputArray
)