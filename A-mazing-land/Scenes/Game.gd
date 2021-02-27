extends Spatial

var in_game = false
var finished_the_game = false

var time: float
onready var time_text = $GameplayUI/CanvasLayer/Label

func startGame():
	in_game = true
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	time_text.visible = true
	
func _process(delta: float) -> void:
	if in_game == true:
		if (Input.is_action_just_pressed("ui_cancel")):
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		if (Input.is_action_just_pressed("fire")):
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		time+=delta
		_format_text()
	if finished_the_game == true:
		if Input.is_action_just_pressed("restart"):
			print("Restarting the game")
			time = 0
			get_tree().reload_current_scene()

func _on_EndArea_body_entered(body: Node) -> void:
	finished_the_game = true
	in_game = false

func _format_text():
	var minutes : String = str(int(time / 60.0))
	var seconds : String = str(int(fmod(time, 60)))
	var step_ms = stepify(fmod(time, 1000), 0.01)
	var i_ms : int = (step_ms - floor(step_ms)) * 100
	var milliseconds : String = str(i_ms)
	time_text.text = "%s:%s.%s" % [minutes, seconds, milliseconds]
