extends Label

var phuk = 0
func _process(delta):
	phuk += 1
	
	# This is literally just artificial lag
	if phuk % 32 == 0:
		text = "Biscuits: %d" % Globals.biscuits
