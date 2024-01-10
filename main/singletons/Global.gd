extends Node

onready var root: Node = get_tree().root.get_node("Main")

onready var scene_paths: Dictionary = {
	"mainmenu":"res://src/MainMenu/MainMenu.tscn",
	"options":"res://src/Options/Options.tscn",
	"credits":"res://src/Credits/Credits.tscn",
	"level_select":"res://src/LevelSelect/LevelSelect.tscn",
	"game":"res://src/Game/Game.tscn",
}

onready var level:int = 1

onready var time: int = 0
onready var score: int = 0
onready var moves: int = 0
onready var pushes: int = 0

onready var music_vol: float = 50
onready var sfx_vol: float = 50

onready var button_click_sfx: AudioStreamPlayer
onready var menu_theme: AudioStreamPlayer
