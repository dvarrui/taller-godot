extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$timer.wait_time = randf_range(1, 3)
	$timer.start()

func _process(delta: float) -> void:
	pass

func _on_timer_timeout() -> void:
	$anim.play()
	$timer.wait_time = randf_range(1, 3)
	$timer.start()
