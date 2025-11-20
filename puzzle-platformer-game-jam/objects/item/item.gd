extends Node2D

@export var player:Node
@export var item_name:Item
@export var color:colors.FilterColors

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
		Item.GEM:
			player.beholder.append(color)
			player.currentColor = color
		Item.LASSO:
			player.hasLasso = true
		Item.TORCH:
			player.hasTorch = true
	queue_free()
