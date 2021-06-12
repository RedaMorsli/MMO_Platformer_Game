extends Node2D


func _on_Player_respawn(player):
	player.position = getSpawnPosition()

func getSpawnPosition():
	var r = 32 * 4
	var pos = $SpawnPosition.position
	return Vector2(rand_range(pos.x - r, pos.x + r), pos.y)
