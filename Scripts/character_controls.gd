extends CharacterBody2D
@export var movement_coefficient : float


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var pre_collision_velocity
	var additional_velocity = Vector2(0,0)
	if Input.is_action_pressed("move_right"):
		additional_velocity += Vector2(90,0)
	if Input.is_action_pressed("move_left"):
		additional_velocity -= Vector2(90,0)
	if Input.is_action_pressed("move_up"):
		additional_velocity -= Vector2(0,90)
	if Input.is_action_pressed("move_down"):
		additional_velocity += Vector2(0,90)
	if Input.is_action_just_released("move_right") or Input.is_action_just_released("move_left") or Input.is_action_just_released("move_up") or Input.is_action_just_released("move_down"): 
		velocity = Vector2(0,0)

	velocity = additional_velocity * movement_coefficient

	pre_collision_velocity = velocity # velocity goes to 0,0 when we collide
	move_and_slide()
	for i in get_slide_collision_count():
		var collision : KinematicCollision2D = get_slide_collision(i)
		if collision.get_collider().is_in_group("object"):
			var collision_normal = collision.get_normal()
			if collision_normal.x < 0 and pre_collision_velocity.x > 0:
				collision_normal.x = -collision_normal.x
			if collision_normal.y < 0 and pre_collision_velocity.y > 0:
				collision_normal.y = -collision_normal.y
			collision.get_collider().apply_force(pre_collision_velocity * collision_normal)

		

