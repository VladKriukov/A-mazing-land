extends Spatial

export (Resource) var KeyDoorResource

func _ready() -> void:
	pass
	#var mat = $DoorFrame/Hinge/DoorBallThing
	#var mat_color = doorBallThing.material_override.get("albedo_color")
	#$DoorFrame/Hinge/DoorBallThing/OmniLight.light_color = mat_color

func _open_door(key):
	#key.queue_free() #play animation that inserts the key and opens door
	var key_hole = $DoorFrame/Hinge/RemoteTransform
	var player = get_tree().get_nodes_in_group("Player")[0]
	player.get_node("RemoteTransform").remote_path = ""
	key_hole.remote_path = key.get_path()
	$AnimationPlayer.play("DoorOpen")
	#get_node("../Player/RemoteTransform").set_remote_node(null)

func _on_Trigger_area_entered(area: Area) -> void:
	print (area.name)
	if area.KeyDoorResource == KeyDoorResource:
		print("Key matched!")
		_open_door(area)
		
