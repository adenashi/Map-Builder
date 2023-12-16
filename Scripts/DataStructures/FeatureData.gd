class_name FeatureData
extends Resource

#region Variables

@export_group("Data")
@export var FeatureID : int
@export var FeatureName : String
@export_enum("Neighborhood", "Village", "City", "Region", "Island") var MapType : String
@export_enum("Flora", "Buildings", "Transit", "Landmark") var Category : String
@export var FeatureIcon : String

@export_group("Details")
@export var FeatureSprite : String

#endregion

#region Gameplay Functions


#endregion
