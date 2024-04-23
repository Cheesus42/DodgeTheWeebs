extends Node

@export var mob_scene: PackedScene
var score

func _ready():
	pass

func game_over():
	$DeathSound.play()
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()
	
func new_game():
	$Music.play()
	score = 0
	get_tree().call_group("mobs", "queue_free")
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	$Player.start($StartPosition.position)
	$StartTimer.start()

func _on_score_timer_timeout():
	score += 1
	$HUD.update_score(score)


func _on_start_timer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

func _on_mob_timer_timeout():
	#erstellt eine neue instanz der mob szene
	var mob = mob_scene.instantiate()
	
	#random location auf dem pfad
	#.prgress_ratio nimmt einen wert zwischen 0 und 1
	#randf() generiert einen floatwert zwischen 0 und 1
	var mob_spawn_location = $MobPath/MobSpawnLocation
	mob_spawn_location.progress_ratio = randf()
	
	#setzt die richtung des mob orthogonal zum pfad
	var direction = mob_spawn_location.rotation + PI/2
	
	#zufällige position auf dem pfad als startposition wählen
	mob.position = mob_spawn_location.position
	
	#zufällige richtung zwische -PI/4 und PI/4
	direction += randf_range(-PI/4, PI/4)
	mob.rotation = direction
	
	#Zufällige geschwindigkeit
	var velocity = Vector2(randf_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	
	add_child(mob)


func _on_hud_start_game():
	new_game()
