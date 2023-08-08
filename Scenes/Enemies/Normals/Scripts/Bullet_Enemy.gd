extends KinematicBody

export var speed = 2
export var life = 5
var vel = Vector3(0, 0, speed)

func _physics_process(delta):
	# Calculate the forward vector based on the local rotation
	var forward = -transform.basis.z

	# Check for collisions in the forward direction
	var collision = move_and_collide(forward * speed * delta)

	if collision:
		# Calculate the bounce velocity with random perturbation
		vel = calculate_bounce_velocity(vel, collision.normal)
		
		life -= 1
		if life <= 0:
			queue_free()

		# Rotate the object to face the movement direction
		if vel.length_squared() > 0.001:
			var rotation_angle = vel.normalized().angle_to(Vector3.FORWARD)
			rotate_y(rotation_angle)

	# Move the node in its local coordinate system
	move_and_slide(vel * speed * delta)

func calculate_bounce_velocity(velocity, collision_normal):
	# Calculate the dot product between the velocity and the collision normal
	var dot_product = velocity.dot(collision_normal)

	# Calculate the reflection vector
	var reflection = velocity - 2 * collision_normal * dot_product

	# Add a random perturbation to the reflection vector
	var random_direction = Vector3(rand_range(-1, 1), rand_range(-1, 1), rand_range(-1, 1)).normalized()
	var perturbation_amount = 0.5  # Adjust this value to control the randomness of the bouncing direction
	reflection += random_direction * perturbation_amount

	return reflection

func _on_Damage_Area_area_entered(area):
	if area.is_in_group("DamagePlayer"):
		get_tree().get_nodes_in_group("Player")[0].get_node("Status").set_life(-10)
		queue_free()
