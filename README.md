# 🎲 Quest'Handi

Jeu de plateau 3D éducatif sur le thème du handicap, développé avec **Godot**.
## 📋 Description

Quest'Handi est un jeu de plateau multijoueur (2 à 5 équipes) où les joueurs avancent sur un plateau en lançant des dés. Certaines cases déclenchent des questions à thème, et une bonne réponse permet de lancer 2 dés au tour suivant.
## 🎮 Règles du jeu

1. Choisir le nombre d'équipes (2 à 5)
2. Chaque équipe lance un dé à son tour
3. **Cases Question** (colorées) : une question est posée à l'équipe
4. **Bonne réponse** → 2 dés au prochain tour
5. **Mauvaise réponse** → 1 seul dé
6. **Cases Bombe** : Force l'équipe à reculer de deux cases
7. **Cases Echelle** : Aide l'équipe à avancer plus vite sur le plateau
8. La première équipe à atteindre la dernière case gagne
## 🏗️ Modification des questions
### Accès aux questions
Si au moins une partie a été lancée, les fichiers questions ont du être créer sur l'ordinateur. 
1. Entrez le raccourci "Win + R"
2. Collez `%appdata%\Godot\app_userdata\QuestHandi\questions`
3. Cliquez sur "OK"

### Modifier les questions

Les questions sont enregistrées au format CSV, vous pouvez normalement utiliser Excel ou n'importe quel éditeur de texte pour modifier les questions existantes ou ajouter les vôtres.
N'incluez pas de point-virgule dans vos questions, il s'agit du caractère de séparation permettant de différencier les colonnes dans le format CSV.
Si les caractères ne s'affichent pas tous correctement c'est que l'encodage de votre éditeur n'est pas réglé sur UTF-8.

Si vous souhaitez inclure une image dans une question, glissez là dans le dossier "images" des questions, puis inscrivez le **nom complet** de l'image (Exemple: HandicapInternational.png) dans la colonne "image"  de la question correspondante.

### Réinitialiser les questions

Si pour une raison, vous souhaitez réinitialiser les questions à leurs valeurs des base, supprimez simplement le dossier "questions". Les questions seront remise au valeurs par défaut lors du prochain lancement d'une partie.
