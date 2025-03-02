extends Area2D

@export var speed = 350;
var velocity = Vector2.ZERO;
var screensize = Vector2(480, 720);

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# in build direction vector calculation
	velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down");
	position += velocity * speed * delta;
	
	# clamp movement to screen to keep within bounds
	position = Vector2(clamp(position.x, 0, screensize.x), clamp(position.y, 0, screensize.y));
	
	pass
