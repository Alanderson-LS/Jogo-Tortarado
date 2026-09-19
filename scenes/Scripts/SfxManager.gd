extends Node

func play_sfx(stream: AudioStream, posicao: Vector2, volume_db := 0.0) -> void:
	var player := AudioStreamPlayer2D.new()
	player.stream = stream
	player.global_position = posicao
	player.bus = "SFX"
	player.volume_db = volume_db
	add_child(player)
	player.play()
	player.finished.connect(player.queue_free)
