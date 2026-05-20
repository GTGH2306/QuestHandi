extends Node
## Singleton permettant d'assurer la gestion des fichiers
## Les vérifications sur les fichiers restent légers car l'utilisateur doit être capable d'ajouter/modifier des questions

var config: ConfigFile = ConfigFile.new()

func load_questions() -> void:
	var err = config.load(OS.get_executable_path().get_base_dir().path_join("config.cfg"))
	print("Chemin Exe: ", OS.get_executable_path().get_base_dir().path_join("config.cfg"))
	print("Chemin Config: ", config.get_value("CONFIG", "chemin_questions"))
	if err == OK:
		filepath = config.get_value("CONFIG", "chemin_questions")
	else:
		var dialog : AcceptDialog = AcceptDialog.new()
		dialog.dialog_text = "Fichier config.cfg introuvable\nUtilisation des questions par défaut."
		$".".add_child(dialog)
		dialog.visible = true
		dialog.move_to_center()
		print("Utilisation des questions par défaut")


var filepath = "res://questions"
var path_images: String:
	get:
		return filepath.path_join("images")

var questions_paths : Dictionary[Globals.clr, String]:
	get:
		return {
	Globals.clr.RED : filepath.path_join("questions_red.csv"),
	Globals.clr.GREEN : filepath.path_join("questions_green.csv"),
	Globals.clr.BLUE : filepath.path_join("questions_blue.csv"),
	Globals.clr.ORANGE : filepath.path_join("questions_orange.csv"),
	Globals.clr.PINK : filepath.path_join("questions_pink.csv")
}


## Vérifie si le dossier est vide
func is_dir_empty(dir: DirAccess) -> bool:
	dir.list_dir_begin()
	var file_name = dir.get_next()

	while file_name != "":
		if file_name != "." and file_name != "..":
			dir.list_dir_end()
			return false
		file_name = dir.get_next()

	dir.list_dir_end()
	return true


## Créer les fichiers questions de façon récurs 	ive en ce basant sur celles avec lesquels le jeu est compilé
func create_files(from:String, to:String):
	#créer le dossier
	DirAccess.make_dir_recursive_absolute(to)
	var default = DirAccess.open(from)
	if default:
		default.list_dir_begin()
		var file_name = default.get_next()
		#On itère sur les fichiers par défaut
		while file_name != "":
			if file_name != "." && file_name != ".." && not file_name.contains(".import"):
				#indique un fichier complet, comme user://questions/questions_orange.csv
				var source = from.path_join(file_name)
				var destination = to.path_join(file_name)
				#Si c'est un dossier, on fait un appel récursif pour créer les fichiers à l'intérieur
				if default.current_is_dir():
					create_files(source, destination)
				#Sinon, copie le fichier
				else:
					DirAccess.copy_absolute(source, destination)
					print("création de ", destination)
			file_name = default.get_next()
