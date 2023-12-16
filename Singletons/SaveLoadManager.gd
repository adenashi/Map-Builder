extends Node

## Handles Saving and Loading. Add as an AutoLoad.

#region Variables

const SAVE_DIR = "user://save/"
const SAVE_PATH = "user://BaseProject.save"

var saveData = SaveData.new()

# TODO: Allow for multiple saves 

#endregion

#region Life Cycle Functions

func _ready():
	verify_save_directory(SAVE_DIR)


func verify_save_directory(path : String):
	DirAccess.make_dir_absolute(path)

#endregion

#region Check for Saved Game

func FoundSavedGame() -> bool:
	return FileAccess.file_exists(SAVE_PATH)

#endregion

#region Create New Game

func CreateNewGame():
	print("Creating new game...")
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file == null:
		print(FileAccess.get_open_error())
		return
	SaveGame()
	LoadSavedGame()

#endregion

#region Save Game

func SaveGame():
	var file = FileAccess.open(SAVE_PATH, FileAccess.WRITE)
	if file == null:
		print(FileAccess.get_open_error())
		return
	
	Dispatch.SaveGame.emit(saveData)
	saveData.SaveDate = Time.get_datetime_dict_from_system()
	
	var data = {
		"SaveData":{
			"Last_Saved": saveData.SaveDate,
			"Saved_Maps": saveData.SavedMaps,
			# TODO: Add the data that needs to be saved.
		}
	}
	
	
	var json_string = JSON.stringify(data, "\t")
	file.store_string(json_string)
	file.close()

#endregion

#region Load Game

func LoadSavedGame():
	if !FileAccess.file_exists(SAVE_PATH):
		print("Save file not found.")
		return
	
	var file = FileAccess.open(SAVE_PATH, FileAccess.READ)
	if file == null:
		print(FileAccess.get_open_error())
		return
	
	var content = file.get_as_text()
	file.close()
	
	var data = JSON.parse_string(content)
	if data == null:
		print("Cannot parse save file")
		return
	
	saveData = SaveData.new()
	
	saveData.SaveDate = data.Last_Saved
	saveData.SavedMaps = data.Saved_Maps
	# TODO: Add data that needs to be loaded.
	
	Dispatch.LoadGame.emit(saveData)

#endregion
