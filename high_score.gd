extends Node


const SAVEFILE = "user://highscore.dat"


var high_score: int = 0


func save_score():
	var file = FileAccess.open(SAVEFILE, FileAccess.WRITE)
	file.store_32(high_score)
	file.close()
	
	
func load_score():
	if (FileAccess.file_exists(SAVEFILE)):
		var file = FileAccess.open(SAVEFILE, FileAccess.READ)
		high_score = file.get_32()
		file.close()


		
