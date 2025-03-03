extends Area2D

@export var speed = 350;
var velocity = Vector2.ZERO;
var screensize = Vector2(480, 720);

# Called when the node enters the scene tree for the first time.
func _ready():
	# call start function to set up player on first call
	start()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# in build direction vector calculation
	velocity = Input.get_vector("move_left", "move_right", "move_up", "move_down");
	position += velocity * speed * delta;
	
	# clamp movement to screen to keep within bounds
	position = Vector2(clamp(position.x, 0, screensize.x), clamp(position.y, 0, screensize.y));
	
	# animation switcher determined by wether velocity has direction
	if velocity.length() > 0:
		$AnimatedSprite2D.animation = "run";
	else:
		$AnimatedSprite2D.animation = "idle";
		
	# flip animation based on velocity direction (if less than 0, going left flip image)
	if velocity.x != 0:
		$AnimatedSprite2D.flip_h = velocity.x <0;
		
	pass
	
# Initial set up
func start():
	set_process(true); # This tells godot to run process function for this node
	position = screensize / 2;
	$AnimatedSprite2D.animation = "idle";

# On death function
func die():
	$AnimatedSprite2D.animation = "hurt";
	set_process(false); # This tells godot to run stop running process function for this node
