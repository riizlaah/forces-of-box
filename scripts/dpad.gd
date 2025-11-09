class_name DPad
extends Node2D

@onready var up: TouchScreenButton = $Up
@onready var down: TouchScreenButton = $Down
@onready var left: TouchScreenButton = $Left
@onready var right: TouchScreenButton = $Right

var can_jump := false:
	set(b):
		can_jump = b
		if up:
			if b and !up.visible: up.show()
			elif !b and up.visible: up.hide()
var can_hardland := false:
	set(b):
		can_hardland = b
		if down:
			if b and !down.visible: down.show()
			elif !b and down.visible: down.hide()
