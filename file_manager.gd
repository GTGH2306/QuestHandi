extends Node
## Singleton permettant d'assurer la gestion des fichiers
## Les vérifications sur les fichiers restent légers car l'utilisateur doit être capable d'ajouter/modifier des questions

var filepath = "user://questions"
var path_images = "user://questions/images/"

var questions_paths : Dictionary[Globals.clr, String] = {
	Globals.clr.RED : "user://questions/questions_red.csv",
	Globals.clr.GREEN : "user://questions/questions_green.csv",
	Globals.clr.BLUE : "user://questions/questions_blue.csv",
	Globals.clr.ORANGE : "user://questions/questions_orange.csv",
	Globals.clr.PINK : "user://questions/questions_pink.csv"
}

## Si le dossier questions n'est pas trouvé, créer les fichiers
func ensure_folders():
	var dir = DirAccess.open(filepath)
	if dir == null or is_dir_empty(dir):
		print("Création de fichiers...")

		create_files("res://questions", filepath)


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
