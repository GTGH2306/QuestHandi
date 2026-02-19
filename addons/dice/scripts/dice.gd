extends RigidBody3D
class_name Dice

var rng: RandomNumberGenerator = RandomNumberGenerator.new()
#Direction de lancé du dé
@export var ThrowForce: Vector3 = Vector3(0, 0, 0);
var faces: Array[FaceMarker]
signal dice_landed(value: int)
var landed: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Ajoute les marqueurs des différentes faces.
	faces = [
	get_node('FaceMarkers/face_1'),
	get_node('FaceMarkers/face_2'),
	get_node('FaceMarkers/face_3'),
	get_node('FaceMarkers/face_4'),
	get_node('FaceMarkers/face_5'),
	get_node('FaceMarkers/face_6')
	]
	#Lance le dé dans la direction configurée
	apply_impulse(ThrowForce)
	#Le dé apparait avec une rotation aléatoire
	rotation = Vector3(rng.randf_range(-180, 180),rng.randf_range(-180, 180),rng.randf_range(-180, 180))
	#Le dé a aussi une force de rotation aléatoire, ce qui donne une animation ressemblant à un vrai lancé
	apply_torque(Vector3(rng.randf_range(300, 600),rng.randf_range(300, 600),rng.randf_range(300, 600)))

#Lorsque le dé ne bouge plus, envoi un signal contenant la valeur du dé
func _on_sleeping_state_changed() -> void:
	landed = true
	emit_signal('dice_landed', get_value())
	
#Retourne un int de la face la plus élevée
func get_value() -> int:
	var highest_face: FaceMarker = faces[0]
	for face in faces:
		if face.global_position.y > highest_face.global_position.y:
			highest_face = face
	return highest_face.face_value
