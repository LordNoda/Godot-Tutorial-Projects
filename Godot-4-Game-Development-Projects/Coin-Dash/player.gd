extends Area2D

# Signals
signal pickup;
signal hurt;

# Export values
@export var speed = 350;

# Internal values
var velocity = Vector2.ZERO;
var screensize = Vector2(480, 720);

# Called when the node enters the scene tree for the first time.
func _ready():
	pass;

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
	
# Initial set up
func start():
	set_process(true); # This tells godot to run process function for this node
	position = screensize / 2;
	$AnimatedSprite2D.animation = "idle";

# On death function
func die():
	$AnimatedSprite2D.animation = "hurt";
	set_process(false); # This tells godot to run stop running process function for this node


func _on_area_entered(area):
	# When hitting something we follow a logic route (2 separate if's here mean both can occur)
	
	if area.is_in_group("coins"):
		area.pickup(); # Execute area.pickup method
		pickup.emit(); # Emit the pickup signal
		
	if area.is_in_group("obstacles"):
		hurt.emit(); # emit the hurt signal
		die() # Call die signal (Hitting an obstacle = losing)
