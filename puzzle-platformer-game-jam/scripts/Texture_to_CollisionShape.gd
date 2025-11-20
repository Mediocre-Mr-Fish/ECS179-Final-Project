extends CollisionShape2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var texture: CanvasItem = $CollisionTexture
	if self.shape is RectangleShape2D:
		var shape := self.shape as RectangleShape2D
		shape.size = texture.size
		self.position = texture.size / 2
		texture.position = -texture.size / 2
	
