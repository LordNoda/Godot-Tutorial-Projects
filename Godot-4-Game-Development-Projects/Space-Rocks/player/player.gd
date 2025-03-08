extends RigidBody2D

enum {INIT, ALIVE, INVULNERABLE, DEAD};
var state = INIT;

@export var engine_power = 500;
@export var spin_power = 8000;

var thrust = Vector2.ZERO;
var rotation_dir = 0;
var screensize = Vector2.ZERO;

# Called when the node enters the scene tree for the first time.
func _ready():
	change_state(ALIVE);
	screensize = get_viewport_rect().size;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	get_input();

# Physics process
func _physics_process(delta):
	constant_force = thrust;
	constant_torque= rotation_dir * spin_power;

# Use this when wanting to manipulate physics objects physics related values directly to avoid issues
func _integrate_forces(physics_state):
	var xform = physics_state.transform; # gets the transform of the physics object
	xform.origin.x = wrapf(xform.origin.x, 0, screensize.x); # wrap x value to 0 and screen x
	xform.origin.y = wrapf(xform.origin.y, 0, screensize.y); # same as above but y. This is what wrap f does (f is for float)
	physics_state.transform = xform;

func get_input():
	thrust = Vector2.ZERO;
	
	if state in [DEAD, INIT]:
		return; # do nothing
	
	if Input.is_action_pressed("thrust"):
		thrust = transform.x * engine_power;
		rotation_dir = Input.get_axis("rotate_left", "rotate_right");
	
func change_state(new_state):
	# General switch statement to change state, collision is disabled on every state except alive
	match new_state:
		INIT:
			$CollisionShape2D.set_deferred("disabled", true);
		ALIVE:
			$CollisionShape2D.set_deferred("disabled", false);
		INVULNERABLE:
			$CollisionShape2D.set_deferred("disabled", true);
		DEAD:
			$CollisionShape2D.set_deferred("disabled", true);
	
	state = new_state;
	

