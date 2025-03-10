extends CanvasLayer

signal start_game

func update_timer(value):
		$MarginContainer/Time.text = str(value);

func update_score(value):
		$MarginContainer/Score.text = str(value);

func show_message(text):
		$Message.text = text;
		$Message.show();
		$Timer.start();
		
		
func show_game_over():
	show_message("GAME OVER!");
	await $Timer.timeout;
	$StartButton.show();
	$Message.text = "COIN DASH!"
	$Message.show();
		
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# On timer timeout signal (From $Timer)
func _on_timer_timeout():
	$Message.hide();

# On start button pressed (From $StartButton)
func _on_start_button_pressed():
	$StartButton.hide();
	$Message.hide();
	start_game.emit();
	
