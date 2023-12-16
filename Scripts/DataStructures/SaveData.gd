class_name SaveData
extends Resource

#region Variables

@export var SaveDate : String

@export_group("Data")
@export var MapID : int
@export var MapName : String
@export_enum("Neighborhood", "Village", "City", "Region", "Island") var MapType : String
@export var MapThumbnail : String

@export_group("Details")
@export var MapFeatures : Dictionary = {}

#endregion

