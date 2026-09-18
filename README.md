# 🌡️ Calcul de la Température de Bulle

Programme Fortran 90 calculant la température de bulle d'un mélange liquide à NC constituants, à partir de fichiers de données. Le comportement idéal (γᵢ = 1) est opérationnel ; le comportement non idéal (modèle NRTL) est prévu par l'architecture du programme mais reste une perspective.

![Fortran](https://img.shields.io/badge/fortran-90-green)
![Code::Blocks](https://img.shields.io/badge/IDE-Code%3A%3ABlocks-blue)
![gfortran](https://img.shields.io/badge/compiler-gfortran-orange)
![Projet](https://img.shields.io/badge/projet-acad%C3%A9mique-lightgrey)

## 🎯 Fonctionnalités

- **Mode idéal opérationnel** : γᵢ = 1, résolution complète de l'équation de bulle
- **Mode non idéal prévu** : l'aiguillage NRTL existe et est demandé à l'utilisateur, le calcul des coefficients d'activité reste à implémenter
- **Nombre de constituants libre** : NC quelconque, toutes les grandeurs sont allouées dynamiquement
- **Pression de saturation** : loi d'Antoine étendue à 5 coefficients (A, B, C, D, E)
- **Résolution par dichotomie** : recherche de T dans l'intervalle [Tmin, Tmax] avec une précision de 1×10⁻⁹
- **Données externalisées** : aucune recompilation nécessaire pour changer de mélange, tout passe par des fichiers `.txt`
- **Architecture modulaire** : modules de données (dimensions, thermo, opératoires, messages) et sous-programmes de calcul séparés

## 📐 Modèle

La température de bulle est la température à laquelle apparaît la première bulle de vapeur. Elle est solution de l'équation d'équilibre liquide-vapeur :

```
Σ xᵢ · γᵢ(T, x) · Pᵢsat(T) − P = 0            (équation de bulle)

Pᵢsat(T) = exp[ A + B/T + C·ln(T) + D·T^E ]   (Antoine étendue, en Pa)

Kᵢ = γᵢ · Pᵢsat / P                           (coefficient de partage)

γᵢ = 1                                        (mode 1 : mélange idéal — implémenté)
γᵢ = NRTL(x, T, Aij, Cij)                     (mode 2 : mélange non idéal — perspective)
```

Le modèle **NRTL** visé utilise τᵢⱼ = Cᵢⱼ / (R·T) et Gᵢⱼ = exp(−αᵢⱼ·τᵢⱼ), où `Aij` porte les paramètres de non-aléatoricité αᵢⱼ et `Cij` les énergies d'interaction binaire.

L'équation de bulle est résolue par **dichotomie** sur [Tmin, Tmax] : l'algorithme vérifie d'abord que la solution est bien encadrée, puis bissecte l'intervalle jusqu'à ce que (Tmax − Tmin) < 1×10⁻⁹.

**Système fourni en exemple** : mélange ternaire **Eau – Méthanol – Éthanol** sous 100 000 Pa.

## 🚀 Démarrage rapide

### Prérequis

- **Code::Blocks avec MinGW** — à télécharger depuis <https://www.codeblocks.org/downloads/binaries/> en choisissant impérativement une version dont le nom contient `mingw` (elle embarque **gfortran**). La version utilisée pour le projet est `codeblocks-25.03mingw-setup.exe`.
- Sous Linux : `sudo apt install codeblocks gfortran`

### Installation de Code::Blocks et réglage du compilateur

Ces étapes sont détaillées, captures à l'appui, dans [doc/installation.pdf](doc/installation.pdf).

```
1. Telecharger et lancer codeblocks-25.03mingw-setup.exe
   Installation standard, chemin par defaut : C:\Program Files\CodeBlocks

2. Ouvrir Code::Blocks puis aller dans :
   Settings > Compiler... > Toolchain executables

3. Selected compiler          : GNU Fortran Compiler (default)

4. Compiler's installation directory :
   C:\Program Files\CodeBlocks\MinGW        (bouton "Auto-detect" possible)

5. Onglet "Program Files", verifier que l'on a bien :
   C compiler              -> gfortran.exe
   C++ compiler            -> gfortran.exe
   Linker for dynamic libs -> gfortran.exe
   Linker for static libs  -> ar.exe
   Debugger                -> GDB/CDB debugger : Default
   Resource compiler       -> windres.exe
   Make program            -> gfortran.exe

6. Valider par OK
```

### Ouverture et exécution du projet

```
1. Cloner ou telecharger le depot
   git clone https://github.com/asbgra341/temperature-de-bulle.git

2. File > Open...  puis selectionner :
   TemperatureDeBulle/TemperatureBulle.cbp

3. Compiler et executer :
   Build > Build and run   (ou F9)
```

> ⚠️ Le programme lit ses fichiers de données avec des **chemins relatifs**. Le répertoire d'exécution doit donc être `TemperatureDeBulle/` (c'est le comportement par défaut de Code::Blocks). Si vous lancez l'exécutable `bin/Debug/TemperatureBulle.exe` à la main, placez-vous dans le dossier `TemperatureDeBulle/` ou copiez les fichiers `Donnees*.txt` à côté de lui.

### Compilation en ligne de commande (alternative)

L'ordre de compilation est imposé : les modules d'abord, le programme principal en dernier.

```bash
cd TemperatureDeBulle
gfortran -Wall -O2 -o TemperatureBulle mod_DIMENSIONS.f90 mod_THERMOS.f90 mod_OPERATOIRES.f90 mod_MESSAGES.f90 Affecte_Dimensions.f90 Affecte_Operatoires.f90 Affecte_Thermos.f90 Thermo_Psaturation.f90 Thermo_Calculgama.f90 Thermo_CalculTbulle.f90 Programme_Principale.f90
```

### Utilisation

Au lancement, le programme demande le comportement thermodynamique à utiliser.

**Mode 1 — solution idéale** (mélange Eau – Méthanol – Éthanol fourni en exemple) :

```
Choix du comportement decrit par le modele Thermodynamique NRTL

tapez 1 pour une solution ideale et tapez 2 pour une solution non ideale
> 1

Temperature d'ebullition du melange est (K):

   348.81141073411277
```

Soit **≈ 348,81 K (75,7 °C)** pour Eau 0,2 / Méthanol 0,3 / Éthanol 0,5 sous 100 000 Pa.

**Mode 2 — solution non idéale** : le mode est reconnu, mais le calcul des coefficients d'activité n'est pas implémenté ; le programme le signale et s'arrête proprement.

```
tapez 1 pour une solution ideale et tapez 2 pour une solution non ideale
> 2

Le mode 2 : gamma = NRTL(x, T, Aij, Cij)
Le modele de la solution non ideale n'est pas implemente dans ce programme !!!!
Pour aller plus loin sur le mode 2 : https://github.com/yajeddig
```

Toutes les autres données (nombre de constituants, pression, bornes de température, compositions, coefficients d'Antoine) sont lues dans les fichiers `Donnees*.txt`.

## 📁 Structure du projet

```
temperature-de-bulle/
├── README.md
├── doc/
│   ├── installation.pdf                  # Procedure d'installation Code::Blocks + MinGW
│   └── Rapport de Projet Fortran.pdf     # Rapport du projet
└── TemperatureDeBulle/
    ├── TemperatureBulle.cbp        # Projet Code::Blocks
    ├── Programme_Principale.f90    # Programme principal
    ├── mod_DIMENSIONS.f90          # Module : nombre de constituants NC
    ├── mod_THERMOS.f90             # Module : coefficients d'Antoine (ANT), R, precision
    ├── mod_OPERATOIRES.f90         # Module : conditions operatoires (P, Tmin, Tmax, Zi)
    ├── mod_MESSAGES.f90            # Module : messages d'accueil, de fin et d'erreur
    ├── Affecte_Dimensions.f90      # Lecture de NC
    ├── Affecte_Operatoires.f90     # Lecture de P, Tmin, Tmax et des compositions
    ├── Affecte_Thermos.f90         # Lecture des coefficients d'Antoine
    ├── Thermo_Psaturation.f90      # Pressions de vapeur saturante (Antoine)
    ├── Thermo_Calculgama.f90       # Coefficients d'activite (mode 1 ideal / mode 2 a venir)
    ├── Thermo_CalculTbulle.f90     # Resolution de l'equation de bulle par dichotomie
    ├── DonneesDimensions.txt       # Fichiers de donnees d'entree
    ├── DonneesOperatoires.txt
    ├── DonneesCoefAntoine.txt
    ├── bin/Debug/                  # Executable genere (TemperatureBulle.exe)
    └── obj/Debug/                  # Fichiers objets et .mod
```

## ⚙️ Configuration

Les fichiers de données se trouvent dans `TemperatureDeBulle/`. Le texte placé après `!` est un commentaire, ignoré à la lecture.

**`DonneesDimensions.txt`** — nombre de constituants

```
3                       ! Nombre de constituants
```

**`DonneesOperatoires.txt`** — conditions opératoires, une valeur par ligne

```
100000      ! Pression exterieure [Pa]
273.15D0    ! Borne min de l'intervalle de recherche [K]
1000D0      ! Borne max de l'intervalle de recherche [K]
0.2         ! Fraction molaire du constituant 1 (Eau)
0.3         ! Fraction molaire du constituant 2 (Methanol)
0.5         ! Fraction molaire du constituant 3 (Ethanol)
```

**`DonneesCoefAntoine.txt`** — une ligne par constituant : A, B, C, D, E (Psat en Pa, T en K)

```
73.649 -7258.2 -7.3037 4.1653E-06 2   ! Eau
81.768 -6876.0 -8.7078 7.1928E-06 2   ! Methanol
74.475 -7164.3 -7.3270 3.1340E-06 2   ! Ethanol
```

Pour changer de mélange : mettre à jour `NC`, ajouter ou retirer les lignes correspondantes dans chaque fichier, puis relancer le programme — aucune recompilation n'est nécessaire.

## 🔧 Développement

```
# Recompiler entierement le projet
Build > Rebuild            (Ctrl + F11)

# Nettoyer les fichiers objets
Build > Clean

# Passer en configuration optimisee
Build > Select target > Release
```

Le projet compile avec `-Wall` ; la cible *Debug* ajoute `-g`, la cible *Release* `-O2`.

### État actuel et perspectives

| Fonctionnalité | État |
|---|---|
| Mode 1 — solution idéale (γᵢ = 1) | ✅ opérationnel |
| Mode 2 — solution non idéale (NRTL) | 🔜 perspective, non implémenté |
| Température de rosée | 🔜 perspective, hors périmètre actuel |
| Coefficients de partage Kᵢ | 🔜 perspective, hors périmètre actuel |

**Le mode 2 (NRTL) est la principale perspective du projet.** L'architecture est déjà prête à l'accueillir : le choix du mode est demandé à l'utilisateur, la subroutine `CalculGama` contient l'aiguillage, et `CalculTbulle` accepte un vecteur `gama` quelconque. Il reste à :

1. ajouter les paramètres d'interaction binaire (αᵢⱼ, Cᵢⱼ) dans `mod_THERMOS.f90` et leur lecture dans `Affecte_Thermos.f90` (via un nouveau fichier de données, par exemple `DonneesCoefInteraction.txt`, à ajouter au projet `.cbp`) ;
2. coder dans `Thermo_Calculgama.f90` le modèle NRTL, avec τᵢⱼ = Cᵢⱼ/(R·T) et Gᵢⱼ = exp(−αᵢⱼ·τᵢⱼ) ;
3. mettre à jour γ(T) au cours de la résolution — les γᵢ dépendant de T, une boucle externe autour de la dichotomie est nécessaire pour un mélange fortement non idéal comme Eau – Méthanol – Éthanol.

Une implémentation de référence du modèle NRTL est indiquée dans les travaux => <https://github.com/yajeddig>.

Autres limites connues :

- `Tmin` et `Tmax` sont modifiés en place pendant la résolution ; un second appel à `CalculTbulle` imposerait de les réinitialiser.
- Le choix idéal / non idéal transite par un `common MODE` ; une variable de module serait plus propre.
- L'intervalle de recherche doit encadrer la solution, sinon le programme s'arrête sur « Pas de solution dans l'intervalle de T donnee ».

## 📚 Contexte

Ce projet a été réalisé dans le cadre du **projet de programmation Fortran de 1ʳᵉ année**, à l'**ENSGTI** (École Nationale Supérieure en Génie des Technologies Industrielles), Université de Pau et des Pays de l'Adour, année universitaire **2020-2021**.

**Réalisé par** : Aboubacar Sidiki BANGOURA — Bienvenu Désiré DAMIBA  
**Encadrants** : Pr Sylvain SERRA — Pr Pierre CEZAC

Le rapport complet (sujet, logigramme, tests et résultats) est disponible dans [doc/Rapport de Projet Fortran.pdf](doc/Rapport%20de%20Projet%20Fortran.pdf).

## 📄 Licence

Projet académique, mis à disposition à des fins pédagogiques.

## 🙏 Remerciements

- Pr Sylvain SERRA pour l'enseignement de la programmation Fortran et l'encadrement du projet
- Pr Pierre CEZAC, à l'origine du sujet, pour son accompagnement tout au long des différentes étapes
- L'ENSGTI pour le cadre pédagogique
