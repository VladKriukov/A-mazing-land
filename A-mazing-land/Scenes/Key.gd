extends Area

export (Resource) var KeyDoorResource

func _on_Key_body_entered(body):
	#print("Something hit key")
	var player = get_tree().get_nodes_in_group("Player")[0]
	if body is KinematicBody and player.get_node("RemoteTransform").remote_path != self.get_path():
		player.get_node("RemoteTransform").remote_path = self.get_path()
		body.KeyDoorResource = KeyDoorResource
		player.get_node("KeyPickupSound").play()
