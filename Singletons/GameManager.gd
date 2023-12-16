extends Node

#region Variables

@export_group("Data")
@export var MapID : int
@export var MapName : String
@export_enum("Neighborhood", "Village", "City", "Region", "Island") var MapType : String

#endregion

#region Life Cycle Functions

func _ready():
	Dispatch.SaveGame.connect(SaveGame)
	Dispatch.LoadGame.connect(LoadGame)

#endregion

#region Gameplay Functions


#endregion

#region Game State

func TogglePause(IsPaused : bool):
	get_tree().paused = IsPaused

#endregion

#region Save and Load

func SaveGame(data : SaveData):
	data.MapID = MapID
	data.MapName = MapName
	data.MapType = MapType





func LoadGame(data : SaveData):
	MapID = data.MapID
	MapName = data.MapName
	MapType = data.MapType


func _notification(what):
	if what == NOTIFICATION_WM_CLOSE_REQUEST:
		ExitGame()


func ExitGame():
	SaveLoadManager.SaveGame()
	get_tree().quit()

#endregion
