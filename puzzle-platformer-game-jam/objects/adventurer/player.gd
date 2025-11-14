class_name Player
extends Character 

@export var health:int = 100

var _damaged:bool = false
var _dead:bool = false

var cmd_list : Array[Command]

@onready var animation_tree:AnimationTree = $AnimationTree

func _ready():
	animation_tree.active = true
	bind_player_input_commands()

func _physics_process(delta: float):
	if _dead:
		return
		
	var move_input = Input.get_action_strength("right") - Input.get_action_strength("left")
	
	if Input.is_action_just_pressed("up"):
		if is_on_floor() == true:
			up_cmd.execute(self)
			
	
	if move_input > 0.1:
		right_cmd.execute(self)
	elif move_input < -0.1:
		left_cmd.execute(self)
	else:
		idle.execute(self)
		
		
	#executes commands first
	if len(cmd_list)>0:
		unbind_player_input_commands()
		var command_status:Command.Status = cmd_list.front().execute(self)
		if Command.Status.DONE == command_status:
			cmd_list.pop_front()

	
	
	super(delta)
	
	#_manage_animation_tree_state()


func take_damage(damage:int) -> void:
	health -= damage
	_damaged = true
	#if 0 >= health:
		#_dead = true
		#animation_tree.active = false
		#animation_player.play("death")
	#else:
		#_play($Audio/hurt)


func bind_player_input_commands():
	#print("bind")
	right_cmd = MoveRightCommand.new()
	left_cmd = MoveLeftCommand.new()
	up_cmd = JumpCommand.new()
	idle = IdleCommand.new()


func unbind_player_input_commands():
	#print("unbind")
	right_cmd = IdleCommand.new()
	left_cmd = IdleCommand.new()
	up_cmd = IdleCommand.new()
	idle = IdleCommand.new()


func resurrect() -> void:
	_dead = false
	health = 100
	animation_tree.active = true
	var sm:AnimationNodeStateMachinePlayback = animation_tree["parameters/playback"]


#func command_callback(cmd_name:String) -> void:
	#if "attack" == cmd_name:
		#_play($Audio/attack)
		#
	#if "jump" == cmd_name:
		#_play($Audio/jump)
	#
	#if "dash" == cmd_name:
		#_play($Audio/jump)
		#
	#if "engage" == cmd_name:
		#_play($Audio/engage)
		#
	#if "undeath" == cmd_name:
		#_play($Audio/undeath)


##Logic to support the state machine in the AnimationTree
#func _manage_animation_tree_state() -> void:
	#if !is_zero_approx(velocity.x):
		#animation_tree["parameters/conditions/idle"] = false
		#animation_tree["parameters/conditions/move"] = true
	#else:
		#animation_tree["parameters/conditions/idle"] = true
		#animation_tree["parameters/conditions/move"] = false
	#
	#if is_on_floor():
		#animation_tree["parameters/conditions/jump"] = false
		#animation_tree["parameters/conditions/on_floor"] = true
	#else:
		#animation_tree["parameters/conditions/jump"] = true
		#animation_tree["parameters/conditions/on_floor"] = false
