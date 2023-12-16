@tool
extends Control


var notesPath = "res://Data/Notes.txt"
@export var NotesText : TextEdit
@export var ClearOnSave : CheckBox

func SaveNotes():
	var note = NotesText.text
	var file = FileAccess.open(notesPath, FileAccess.WRITE)
	file.store_string(note)
	file.close()
	if ClearOnSave.button_pressed:
		ClearNotes()


func ClearNotes():
	NotesText.text = ""


