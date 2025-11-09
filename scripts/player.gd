extends CharacterBody2D


@onready var dpad: DPad = $CanvasLayer/Control/DPad
@onready var f_applier: FunctionApplier = $FuntionApplier

const SPEED = 300.0
const JUMP_VELOCITY = -800.0

var jumping := false
var hardland := false

func _ready() -> void:
	dpad.position.y = get_viewport_rect().end.y - 10
	dpad.position.x = 10

func _physics_process(_d: float) -> void:
	handle_y_movement()
	var x_dir := Input.get_axis("a", "d")
	if x_dir:
		velocity.x = x_dir * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	f_applier.apply_funcs()
	move_and_slide()

func _input(_event: InputEvent) -> void:
	if Input.is_action_pressed("w") and dpad.can_jump and !jumping:
		jumping = true
		dpad.can_jump = false
		velocity.y = JUMP_VELOCITY
	elif Input.is_action_pressed("s") and dpad.can_hardland and !hardland:
		hardland = true
		dpad.can_hardland = false
		velocity.y = -JUMP_VELOCITY * 1.5

func handle_y_movement():
	if !is_on_floor():
		velocity.y += get_gravity().y * get_physics_process_delta_time()
		dpad.can_hardland = true
		dpad.can_jump = false
	else:
		if jumping: jumping = false
		if hardland: hardland = false
		dpad.can_hardland = false
		dpad.can_jump = true


func _on_func1_pressed() -> void:
	f_applier.v_applied = true
