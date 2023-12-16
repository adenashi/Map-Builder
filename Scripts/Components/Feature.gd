class_name Feature
extends Sprite2D


#region Variables

@export var ID : int
@export var Data : FeatureData
@export var Position : Vector2
@export var Rotation : float

var _dragging : bool = false
var _offset : Vector2 = Vector2(0.0,0.0)

#endregion

#region Life Cycle Functions

func Init(id : int, data : FeatureData):
	ID = id
	Data = data
	self.texture2D = load(Data.FeatureSprite) as Texture2D
	_dragging = true

#endregion

#region Input Functions

func _input(event : InputEvent):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				_dragging = true
				_offset = position - get_global_mouse_position()
			else:
				_dragging = false
				Position = self.position
		
		if event.button_index == MOUSE_BUTTON_RIGHT:
			if event.pressed:
				RotateFeature()
	
	if event is InputEventMouseMotion:
		if event.pressed && event.button_mask == MOUSE_BUTTON_LEFT:
			if _dragging:
				position = get_global_mouse_position() + _offset
		

#endregion


#region Gameplay Functions

func RotateFeature():
	self.rotation_degrees += 15
	Rotation = self.rotation_degrees

#endregion

func LoadFeature(id : int, data : FeatureData, pos : Vector2, rot : float):
	ID = id
	Data = data
	self.texture2D = load(Data.FeatureSprite) as Texture2D
	position = pos
	Position = pos
	rotation_degrees = rot
	Rotation = rot
