class_name MapManaager
extends Node2D


#region Variables

@export_group("Details")
@export var MapFeatures : Array[Feature] = []

@export_group("Prefabs")
@export var FeatureHolder : Node2D
@export var FeaturePrefab = preload("res://Scenes/Components/feature.tscn")

#endregion

#region Life Cycle Functions

func _ready():
	Dispatch.SaveGame.connect(SaveGame)
	Dispatch.LoadGame.connect(LoadGame)

#endregion

#region Gameplay Functions

func AddFeature(data : FeatureData):
	var feature : Feature = FeaturePrefab.instantiate() as Feature
	var id : int = MapFeatures.size()
	feature.Init(id, data)
	MapFeatures.append(feature)
	FeatureHolder.add_child(feature)


func RemoveFeature(feature : Feature):
	if MapFeatures.has(feature):
		MapFeatures.erase(feature)
		feature.queue_free()

#endregion

#region Save and Load

func SaveGame(data : SaveData):
	var features : Dictionary = {}
	var i : int = 0
	for feature : Feature in MapFeatures:
		var f : Dictionary = {}
		f["ID"] = feature.ID
		f["Path"] = feature.Data.MapType + "/" + feature.Data.Category + "/" + feature.Data.FeatureName
		f["Position"] = feature.Position
		f["Rotation"] = feature.Rotation
		features[i] = f
		i += 1
	data.MapFeatures = features
	data.MapThumbnail = GetMapThumbnail()


func GetMapThumbnail() -> String:
	var capture = get_viewport().get_texture().get_image()
	
	var time : Dictionary = Time.get_datetime_dict_from_system()
	var timestamp = "{month}-{day}-{year}-{hour}-{minute}-{second}".format({"month":time.month, "day":time.day, "year":time.year, "hour":time.hour, "minute":time.minute, "second":time.second})
	var filename = "user://" + "/Map{0}-{1}.png".format({"0": GameManager.MapID, "1":timestamp})
	
	var saveSS = capture.save_png(filename)
	if saveSS != 0:
		return ""
	else:
		return filename


func LoadGame(data : SaveData):
	for i in range(data.MapFeatures.size()):
		var feature : Feature = FeaturePrefab.instantiate() as Feature
		var path = "res://Data/Features/" + data.MapFeatures[i].Path
		var Data : FeatureData = load(path) as FeatureData
		var id : int = data.MapFeatures[i].ID
		FeatureHolder.add_child(feature)
		var pos : Vector2 = data.MapFeatures[i].Position
		var rot : float = data.MapFeatures[i].Rotation
		feature.LoadFeature(id, Data, pos, rot)
		MapFeatures.append(feature)

#endregion
