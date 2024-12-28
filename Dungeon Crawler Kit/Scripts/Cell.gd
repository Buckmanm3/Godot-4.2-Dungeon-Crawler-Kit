@tool
extends Node3D

@onready  var  roof: MeshInstance3D  = $Roof
@onready var front: MeshInstance3D = $Front
@onready var back: MeshInstance3D = $Back
@onready var left: MeshInstance3D = $Left
@onready var right: MeshInstance3D = $Right


func updateFaces(cells:Array[Vector2i]):
	@warning_ignore("narrowing_conversion")
	var gridpos = Vector2i(position.x, position.z)
	if cells.has(gridpos + Vector2i.LEFT):
		left.queue_free()
	if cells.has(gridpos + Vector2i.RIGHT):
		right.queue_free()
	if cells.has(gridpos + Vector2i.UP):
		front.queue_free()
	if cells.has(gridpos + Vector2i.DOWN):
		back.queue_free()
