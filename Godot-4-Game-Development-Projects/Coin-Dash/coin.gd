extends Area2D

var screensize = Vector2.ZERO;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func pickip():
	queue_free(); # Queue free removes the node in godot (This also removes it from memory)
