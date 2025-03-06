extends Node

# exports
@export var coin_scene : PackedScene;
@export var playtime = 30;

# scene variables
var level = 1;
var score = 0;
var time_left = 0;
var screensize = Vector2.ZERO;
var playing = false;

# Called when the node enters the scene tree for the first time.
func _ready():
	# Initializes some values when a node loads
	screensize = get_viewport().get_visible_rect().size; # get the viewports visible size (whats set in props)
	$Player.screensize = screensize; # propogate to the player element as well
	$Player.hide();
	# RESET EVERY RUn
	$HUD.update_score(score);
	$HUD.update_timer(time_left);

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Advance level and spawn new coins when all are picked up
	# Done via searching from root node via get_tree all nodes in "coins" group
	if playing and get_tree().get_nodes_in_group("coins").size() == 0:
		level += 1;
		time_left += 5;
		spawn_coins();

func new_game():
	# This will initialize a new game
	playing = true;
	level = 0;
	score = 0;
	time_left = playtime;
	$Player.start(); # Call player start, it sets to the middle, enables process to run, sets start animation
	$Player.show();
	$GameTimer.start(); # start timer node
	spawn_coins(); # this method will rng spawn the coins
	
func spawn_coins():
	$LevelSound.play();
	for i in level + 4:
		var c = coin_scene.instantiate(); #this create a instance of the packed scene
		add_child(c); # adds the packed scene as a child to the current node
		c.screensize = screensize;
		c.position = Vector2(randi_range(0, screensize.x),randi_range(0, screensize.y)); #Place it somewhere on screen

# This procs every 1 second continuously
func _on_game_timer_timeout():
	time_left -= 1;
	$HUD.update_timer(time_left);
	if(time_left <= 0):
		game_over();
		
func game_over():
	$EndSound.play();
	playing = false;
	$GameTimer.stop();
	get_tree().call_group("coins", "queue_free"); #This calls given function on every item in the group (delete)
	$HUD.show_game_over();
	$Player.die();

# Connects to player hurt signal, will fire when emitted
func _on_player_hurt():
	game_over(); # End game when hurt

# Connects to player pick up signal, will fire when emitted
func _on_player_pickup():
	$CoinSound.play();
	score += 1;
	$HUD.update_score(score); # Update HUD

# Connects to the button signal, when button is pressed
func _on_hud_start_game():
	new_game();
