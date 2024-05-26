extends Node2D
class_name Frog

@onready var target : Node2D = $target
@onready var tail : Node2D = $tail
var start_position := Vector2.ZERO
var target_pos := Vector2.ZERO
var max_distance = 150
@onready var tonge: Node2D = $tongue/tongue
@onready var tonge_tip: Node2D = $tongue/tongue_tip
@onready var frong_sprites = [$frogSprite/back, $frogSprite/front]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("hold_shoot"):
		start_position = get_global_mouse_position()
		set_frog_sprite(1)
	if Input.is_action_pressed("hold_shoot"):
		target_pos = get_global_mouse_position() - start_position
		if target_pos.length() > max_distance:
			target_pos = target_pos.normalized() * max_distance
		if target_pos.angle() < 0:
			target_pos.y = 0
		target.position = target_pos
		tail.transform = Transform2D().scaled(Vector2(0.1,target_pos.length()/50)).rotated(target_pos.angle() - PI/2)
	if Input.is_action_just_released("hold_shoot"): 
		reset_tail()
		set_frog_sprite(0)
		shoot_tonge(target_pos.length(), target_pos.angle())

func _input(event):
	if event.is_action_pressed("hold_shoot"):
		pass

func set_frog_sprite(id := 0):
	for sprite in frong_sprites:
		sprite.frame = id

func shoot_tonge(dist:float, angle:float):
	tonge.transform = Transform2D().rotated(angle)
	var tw = create_tween()
	tw.set_ease(Tween.EASE_OUT)
	tw.set_trans(Tween.TRANS_SPRING)
	tw.tween_property(tonge, "scale:y", dist*2, .2)
	
func reset_tail():
	tail.transform = Transform2D().scaled(Vector2(0.1,1))
