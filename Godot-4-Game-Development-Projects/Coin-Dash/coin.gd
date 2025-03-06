extends Area2D

var screensize = Vector2.ZERO;

# Called when the node enters the scene tree for the first time.
func _ready():
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
