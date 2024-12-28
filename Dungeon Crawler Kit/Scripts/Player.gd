extends CharacterBody3D

@export var MoveSpeed:float = .1
@onready var FrontRay:RayCast3D = $Camera3D/FrontRay
@onready var BackRay:RayCast3D = $Camera3D/BackRay
@onready var Target:Vector3 = self.position
signal PlayerMoved
var Moving:bool = false


func _input(event):
	if !Moving:
		if event.is_action_released("Forward"):
			if FrontRay.is_colliding():
				return
			Target = global_transform.basis.z*-1
			Moving = true
		elif event.is_action_released("Backward"):
			if BackRay.is_colliding():
				return
			Target = global_transform.basis.z
			Moving = true
		elif event.is_action_released("Turn_Left"):
			Moving = true
			RotatePlayer(true)
			return
		elif event.is_action_released("Turn_Right"):
			Moving = true
			RotatePlayer(false)
			return
		elif event.is_action_released("Left"):
			Target = global_transform.basis.x * -1
			Moving = true
		if event.is_action_released("Right"):
			Target = global_transform.basis.x
			Moving = true
		if Moving:
			MovePlayer()

func MovePlayer():
	var tween = get_tree().create_tween()
	await tween.tween_property(self, "position", Target, MoveSpeed).as_relative().finished
	position = Vector3i(position.round())  # Set pos to whole num to avoid being off the grid
	Moving = false

	
func RotatePlayer(dir:bool):
	var tween = get_tree().create_tween()
	if dir:
		await tween.tween_property(self, "rotation:y", 1.571, MoveSpeed).as_relative().finished
	else:
		await tween.tween_property(self, "rotation:y", -1.571, MoveSpeed).as_relative().finished
	Moving = false
