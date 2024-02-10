extends CharacterBody2D
@export var movement_speed : float
var force_coefficient = 20
@export var apply_gravity : bool


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func get_input():
	var input_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	velocity = input_direction * movement_speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	get_input()

	if apply_gravity:
		velocity +=  Vector2(0, 600)

	var pre_collision_velocity
	pre_collision_velocity = velocity # velocity goes to 0,0 when we collide, which is why we record the velocity prior to the move_and_slide() func call
	move_and_slide()

	for i in get_slide_collision_count():
		var collision : KinematicCollision2D = get_slide_collision(i)

		if collision.get_collider().get_class() != "TileMap":
			var collision_normal = collision.get_normal()
			if collision_normal.x < 0 and pre_collision_velocity.x > 0:
				collision_normal.x = -collision_normal.x
			if collision_normal.y < 0 and pre_collision_velocity.y > 0:
				collision_normal.y = -collision_normal.y
			collision.get_collider().apply_force(pre_collision_velocity * collision_normal * force_coefficient)

		

