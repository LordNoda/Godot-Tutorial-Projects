extends Area2D

var screensize = Vector2.ZERO;

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start(randf_range(3,8));
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func pickup():
	$CollisionShape2D.set_deferred("disabled", true); # Disables the collision detections
	var tween = create_tween().set_parallel().set_trans(Tween.TRANS_QUAD);
	# Set parralel means the below 2 happen at the same time
	# Tweened position up as looks nicer than scaling 3x size
	tween.tween_property(self, "position", position + Vector2(0, -15), 0.3);
	tween.tween_property(self, "modulate:a", 0.0, 0.3);
	await tween.finished;
	queue_free(); # Queue free removes the node in godot (This also removes it from memory)


func _on_timer_timeout():
	$AnimatedSprite2D.frame = 0;
	$AnimatedSprite2D.play();


func _on_area_entered(area):
	#Avoid placing on obstacles
	if area.is_in_group("obstacles"):
		# Place it somewhere else on the screen
		position = Vector2(randi_range(0, screensize.x),randi_range(0, screensize.y)); 
