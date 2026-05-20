# 🎲 Quest'Handi

Jeu de plateau 3D éducatif sur le thème du handicap, développé avec **Godot**.
## 📋 Description

Quest'Handi est un jeu de plateau multijoueur (2 à 5 équipes) où les joueurs avancent sur un plateau en lançant des dés. Certaines cases déclenchent des questions à thème, et une bonne réponse permet de lancer 2 dés au tour suivant.
## 🎮 Règles du jeu

1. Choisir le nombre d’équipes (**de 2 à 5**)
2. Chaque équipe lance **1 dé** à son tour
3. **Cases Question** (cases colorées) : une question est posée à l’équipe
4. **Bonne réponse** : l’équipe pourra lancer **2 dés** au prochain tour
5. **Mauvaise réponse** : l’équipe ne lancera qu’**1 seul dé**
6. **Cases Banane** : l’équipe recule de **2 cases**
7. **Cases Échelle** : l’équipe avance plus rapidement sur le plateau
8. La première équipe à atteindre la dernière case gagne
## 🏗️ Modifier les questions du jeu

Les questions du jeu peuvent être modifiées facilement. Elles sont enregistrées dans des fichiers **CSV**, que vous pouvez ouvrir et modifier avec **Excel** ou un autre tableur compatible.
### 1. Fichier de configuration à placer au bon endroit

Le fichier **`config.cfg`** fourni avec le jeu doit être placé **dans le même dossier que l’exécutable du jeu**.

En pratique, cela signifie qu’il doit se trouver à côté du fichier qui permet de lancer le jeu.

**Exemple :**
```
QuestHandi.exe
config.cfg
```

Ce fichier `config.cfg` indique au jeu **où aller chercher les fichiers de questions**.

---
### 2. Indiquer correctement le chemin des questions dans `config.cfg`

Dans le fichier `config.cfg`, vous devez renseigner le **chemin du dossier contenant les questions**.
Vous pouvez modifier `config.cfg` en faisant clic droit puis "Modifier dans Bloc-notes" si vous êtes sous Windows 11.

Pour que le chemin soit bien lu par le jeu, il faut l’écrire :

- soit avec des **slashes** : `/`
- soit avec des **antislashes doublés** : `\\`

### Exemples

```
[CONFIG]
chemin_questions="C:/Users/TGrandgirard/Desktop/questionstest"
```
ou
```
[CONFIG]
chemin_questions="C:\\Users\\TGrandgirard\\Desktop\\questionstest"
```

> **Conseil :** si vous avez un doute, utilisez de préférence les `/`, qui sont plus simples à écrire.

---

### 3. Modifier les questions

Les questions sont enregistrées au format **CSV**.  
Vous pouvez modifier les questions existantes ou en ajouter de nouvelles avec **Excel**.

#### Important

- **N’ajoutez pas de point-virgule `;` dans le texte des questions ou des réponses**, car ce caractère est utilisé pour séparer les colonnes dans le fichier CSV.
- Vous pouvez forcer un retour à la ligne au sein des questions ou des réponses en saisissant `\n`
- Si certains caractères s’affichent mal, vérifiez que votre logiciel est bien réglé en **UTF-8**.

---
### 4. Ajouter une image à une question

Si vous souhaitez afficher une image avec une question :

1. Placez l’image dans le dossier **`images`** des questions
2. Dans la colonne **`image`** du fichier CSV, indiquez le **nom complet du fichier image**
	Exemple: `HandicapInternational.png`