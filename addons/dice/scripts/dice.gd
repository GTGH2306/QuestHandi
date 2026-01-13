extends RigidBody3D
class_name Dice

var rng: RandomNumberGenerator = RandomNumberGenerator.new()
@export var ThrowForce: Vector3 = Vector3(0, 0, 0);
var faces: Array[FaceMarker]
signal dice_landed(value: int)
var landed: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	faces = [
	get_node('FaceMarkers/face_1'),
	get_node('FaceMarkers/face_2'),
	get_node('FaceMarkers/face_3'),
	get_node('FaceMarkers/face_4'),
	get_node('FaceMarkers/face_5'),
	get_node('FaceMarkers/face_6')
	]
	
	apply_impulse(ThrowForce)
	rotation = Vector3(rng.randf_range(-180, 180),rng.randf_range(-180, 180),rng.randf_range(-180, 180))
	apply_torque(Vector3(rng.randf_range(300, 600),rng.randf_range(300, 600),rng.randf_range(300, 600)))


func _on_sleeping_state_changed() -> void:
	landed = true
	emit_signal('dice_landed', get_value())
	
func get_value() -> int:
	var highest_face: FaceMarker = faces[0]
	for face in faces:
		if face.global_position.y > highest_face.global_position.y:
			highest_face = face
	return highest_face.face_value
