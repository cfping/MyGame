extends Node2D

# 玩家相关参数
@export var speed: float = 200.0
@export var rotation_speed: float = 2.0
@export var jump_height: float = 100.0
@export var jump_speed: float = 4.0

# 子弹/炸弹相关参数
@export var random_angle_degrees: float = 10.0
@export var max_range: int = 2000
@export var max_bullet_speed: float = 1500.0

# 游戏角色设置出生点为居中
func _ready() -> void:
	center_player()

# 将玩家居中显示
func center_player() -> void:
	var player = $player
	var viewport_rect = get_viewport_rect()
	var player_size = player.get_rect().size if player.has_method("get_rect") else Vector2.ZERO
	player.position = (viewport_rect.size - player_size) / 2

# 处理输入事件
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("move_space"):
		print("move_space")
		spawn_bomb()

# 生成炸弹
func spawn_bomb() -> void:
	var bomb = load("res://bomb.tscn").instantiate()
	bomb.position = $player.position
	add_child(bomb)
	# 炸弹的逻辑已在bomb.gd中处理
