extends AnimatedSprite2D

@export var speed: float = 200.0
@export var rotation_speed: float = 2.0
@export var jump_force: float = 400.0

var direction = Vector2.ZERO
var is_jumping = false

func _ready():
	# 打印可用的动画名称，帮助调试
	print("可用动画: ", sprite_frames.get_animation_names())
	
	# 默认播放静止动画
	if sprite_frames.has_animation("idle"):
		play("idle")
	else:
		print("警告：找不到'idle'动画")

func _process(delta: float) -> void:
	handle_input()
	update_animation()
	# 直接更新位置
	position += direction * speed * delta

func handle_input():
	direction = Vector2.ZERO

	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_right"):
		direction.x += 1

	if direction.length() > 0:
		direction = direction.normalized()

	if Input.is_action_just_pressed("ui_accept"):
		is_jumping = true

func update_animation():
	var anim_name = "idle"  # 默认使用idle动画

	if direction.length() > 0:
		# 根据移动方向决定动画
		if direction.y > 0 and abs(direction.y) >= abs(direction.x):
			anim_name = "down"
		elif direction.y < 0 and abs(direction.y) >= abs(direction.x):
			anim_name = "up"
		elif direction.x < 0:
			anim_name = "left"
		elif direction.x > 0:
			anim_name = "right"

	# 只有当新动画不同于当前动画时才切换
	if animation != anim_name:
		if sprite_frames.has_animation(anim_name):
			play(anim_name)
		else:
			print("警告：找不到动画 ", anim_name)

func get_current_direction() -> String:
	var current_anim = animation
	
	# 如果是idle动画，返回上一个方向
	if current_anim == "idle":
		return "down"  # 默认朝下
		
	return current_anim  # 直接返回当前动画名称作为方向
