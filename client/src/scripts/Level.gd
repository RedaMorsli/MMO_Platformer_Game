extends Node2D




func _on_Player_respawn(player):
	var r = 32 * 4
	var pos = $SpawnPosition.position
	player.position = Vector2(rand_range(pos.x - r, pos.x + r), pos.y)
