extends Node2D

@export var item_name:Item
@export var color:colors.FilterColors

@onready var player: PlayerController = %player
@onready var camera: CameraController = %Camera2D
@onready var sprite = $Sprite2D

enum Item {
	DEFAULT,
	BEHOLDER,
	GEM,
	LASSO,
	TORCH,
}

var sprite_dict = {
	"DEFAULT":"res://icon.svg",
	"BEHOLDER":"res://assets/beholder/beholder_item.png",
	"GEM":"res://assets/beholder/gem_item.png",
	"LASSO":"res://assets/flower_daffodil.png",
	"TORCH":"res://assets/flower_daffodil.png",
}


func _ready() -> void:
	$Sprite2D.set_texture(load(sprite_dict.values()[item_name]))
	if item_name == 2:
		sprite.modulate = colors.getColorFromEnum(color)


func on_touch(_touch:bool) -> void:
	match item_name:
		Item.BEHOLDER:
			player.hasBeholder = true
			camera.inventoryHandler.showBeholder()
		Item.GEM:
			player.beholder.append(color)
			player.currentColor = color
			camera.setColor(color)
			camera.inventoryHandler.updateBeholder()
		Item.LASSO:
			player.hasLasso = true
			camera.inventoryHandler.showLasso()
		Item.TORCH:
			player.hasTorch = true
			camera.inventoryHandler.showTorch()
	queue_free()
