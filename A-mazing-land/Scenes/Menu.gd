extends Spatial

var is_playing = false

func _ready() -> void:
	$CameraMovement.play("MenuCameraCinematics")
	$CanvasLayer/CenterContainer/AnimationPlayer.play("Blink")

func _input(event):
	if event is InputEventKey and event.pressed and is_playing == false:
		$"../Player".startGame()
		$"..".startGame()
		$"../Player/Head/Camera".current = true
		$CanvasLayer/CenterContainer/Label.visible = false
		$CameraMovement.stop()
		$CanvasLayer/CenterContainer/AnimationPlayer.stop()
		is_playing = true

