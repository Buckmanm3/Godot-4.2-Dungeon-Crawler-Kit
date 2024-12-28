@tool
extends Node3D

@export var CellScenes:Array[Resource]
var cells:Array = []
@onready var map: TileMap = $Map

func _ready():
	if CellScenes.size() == 0: return
	var tiles: Array[Vector2i] = map.get_used_cells(0)
	for tile:Vector2i in tiles:
		var cell = CellScenes[map.get_cell_atlas_coords(0,tile).x].instantiate()
		add_child(cell)
		cell.transform.origin = Vector3(tile.x, 0, tile.y)
		cells.append(cell)
	for cell in cells:
		cell.updateFaces(tiles)
