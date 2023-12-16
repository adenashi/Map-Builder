extends CanvasLayer

#region Variables

@export_group("Visuals")
@export var Fader : ColorRect
@export var Text : Label

@export_group("Scenes")
@export var MainMenu : PackedScene
@export var GameScene : PackedScene
@export var GameOver : PackedScene

#endregion

#region Life Cycle Functions

func _ready():
	FadeIn()

#endregion

#region Load Scene

func GoToScene(scene : String, showLoading : bool):
	var sceneToLoad : PackedScene
	match scene:
		"MainMenu":
			sceneToLoad = MainMenu
		"GameScene":
			sceneToLoad = GameScene
		"GameOver":
			sceneToLoad = GameOver
	
	if sceneToLoad == null:
		return
	
	await FadeOut()
	
	if showLoading:
		Loading()
		get_tree().change_scene_to_packed(sceneToLoad)
	else:
		get_tree().change_scene_to_packed(sceneToLoad)
	
	await FadeIn()
	Dispatch.FinishedLoading.emit()

#endregion

#region Tweens

func FadeIn():
	var tween = create_tween()
	tween.tween_property(Fader, "modulate:a", 0, 1.0).set_trans(Tween.TRANS_CUBIC)
	tween.tween_callback(Fader.hide)


func Loading():
	Text.visible_characters = 0
	var charsVisible = 0
	while Text.visible_characters != 10:
		await get_tree().create_timer(0.1).timeout
		charsVisible += 1
		Text.visible_characters = charsVisible


func FadeOut():
	Fader.show()
	var tween = create_tween()
	tween.tween_property(Fader, "modulate:a", 1.0, 1.0).set_trans(Tween.TRANS_CUBIC)

#endregion
