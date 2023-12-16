@tool
class_name Notes
extends EditorPlugin

const MAIN_PANEL = preload("res://addons/Notes/notes.tscn")
var main_panel_instance

func _enter_tree():
	main_panel_instance = MAIN_PANEL.instantiate()
	add_control_to_dock(EditorPlugin.DOCK_SLOT_RIGHT_BL, main_panel_instance)


func _exit_tree():
	remove_control_from_docks(main_panel_instance)
	main_panel_instance.free()


func _get_plugin_name():
	return "Notes"


func _get_plugin_icon():
	return get_editor_interface().get_base_control().get_theme_icon("Script", "EditorIcons")
