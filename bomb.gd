extends AnimatedSprite2D

func _ready():
	# 进入开始播放炸弹动画
	play("bomb")
	# 连接动画完成信号 - Godot 4的正确连接方式
	#animation_finished.connect(_on_animation_finished)
	connect("animation_finished",_on_animation_finished)
	# 设置动画为非循环播放
	sprite_frames.set_animation_loop("bomb", false)

func _on_animation_finished():
	print("动画播放结束")
	queue_free()
