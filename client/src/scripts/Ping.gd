extends MarginContainer

func start():
	$PingTimer.start()

func stop():
	$PingTimer.stop()


func updatePing(time):
	$HBoxContainer/PingLabel.text = str(time)


func _on_PingTimer_timeout():
	Server.ping()
