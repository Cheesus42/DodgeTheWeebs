extends RigidBody2D

func _ready():
	#gibt ein array zurück mit den namen aller animationen
	var mob_types = $AnimatedSprite2D.sprite_frames.get_animation_names()
	#spielt eine random animation ab mit einem namen aus dem array index random zahl mod anzahl elemente
	$AnimatedSprite2D.play(mob_types[randi() % mob_types.size()])



func _on_visible_on_screen_notifier_2d_screen_exited():
	#löscht ein node aus dem spiel am ende des frames
	queue_free()
