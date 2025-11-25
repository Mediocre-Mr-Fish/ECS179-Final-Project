extends Node

@onready var subject = $"..".subject
# Called when the node enters the scene tree for the first time.



func _ready() -> void:
	if subject.hasBeholder:
		showBeholder()
	if subject.hasLasso:
		showLasso()
	if subject.hasTorch:
		showTorch()

func switchColor(color):
	var deactivated = load("res://assets/beholder/gem_deactivated.png")
	var activated = load("res://assets/beholder/gem_activated.png")
	match color:
		0: #green
			$Beholden/green.modulate = colors.getColorFromEnum(color) 
			$Beholden/green.texture = activated
			$Beholden/red.texture = deactivated
			$Beholden/blue.texture = deactivated
		1: #red
			$Beholden/red.modulate = colors.getColorFromEnum(color) 
			$Beholden/red.texture = activated
			$Beholden/green.texture = deactivated
			$Beholden/blue.texture = deactivated
		2: #blue
			$Beholden/blue.modulate = colors.getColorFromEnum(color)
			$Beholden/blue.texture = activated
			$Beholden/green.texture = deactivated
			$Beholden/red.texture = deactivated

func showBeholder():
	$Beholden.visible = true
	$Beholden/Input.text = getInputText("filter_activate")

func updateBeholder():
	if $"..".subject.beholder.size()>1:
		$"Beholden/second text ui".visible = true
		$"Beholden/second text ui/Input".text = getInputText("filter_switch")

func showLasso():
	$Lasso.visible = true
	$Lasso/Input.text = getInputText("null")

func showTorch():
	$Torch.visible = true
	$Torch/Input.text = getInputText("null")

func getInputText(input):
	return InputMap.get_action_description(input).split(" ")[0]
