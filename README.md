# Extract SQL

## Introduction

This bash script searches for every occurences of a given SQL query in a given file, and extracts it to another file.

## How to use 

### Usage

```
Usage: 
	./extract_sql.sh [-h|--help] [-q|--query=query] [-i|--input=input_file] [-o|--o=output_file]

Options:
	-h, --help
		Display this menu

	-q, --query
		Required. The keyword to look for in the specified file

	-i, --input
		Required. The file to search into

	-o, --output 
		The file to write the extracted result in
```

### Example

The content of `input_file.sql` : 

```sql
CREATE TABLE IF NOT EXISTS `pokemons` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL DEFAULT 'placeholder.png',
  `hp` int(11) NOT NULL DEFAULT '1',
  `attack` int(11) NOT NULL DEFAULT '1',
  `specialAttack` int(11) NOT NULL DEFAULT '1',
  `experienceGiven` int(11) NOT NULL DEFAULT '1',
  `moneyGiven` int(11) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;

INSERT INTO `pokemons` (`id`, `name`, `image`, `hp`, `attack`, `specialAttack`, `experienceGiven`, `moneyGiven`) VALUES
(1, 'Bulbizarre', 'bulbasaur.png', 10, 5, 2, 5, 5),
(2, 'Herbizarre', 'ivysaur.png', 20, 10, 4, 10, 10),
(3, 'Florizarre', 'venusaur.png', 30, 20, 8, 20, 20),
(4, 'Carapuce', 'squirtle.png', 10, 5, 2, 5, 5),
(5, 'Carabaffe', 'wartortle.png', 20, 10, 4, 10, 10),
(6, 'Tortank', 'blastoise.png', 30, 20, 8, 20, 20),
(7, 'Salamèche', 'charmander.png', 10, 5, 2, 5, 5),
(8, 'Reptincel', 'charmeleon.png', 20, 10, 4, 10, 10),
(9, 'Dracaufeu', 'charizard.png', 30, 20, 8, 20, 20),
(10, 'Rattata', 'rattata.png', 10, 5, 2, 5, 5),
(11, 'Ratattac', 'raticate.png', 25, 15, 5, 15, 15),
(12, 'Roucool', 'pidgey.png', 10, 5, 2, 5, 5),
(13, 'Roucoups', 'pidgeotto.png', 20, 10, 4, 10, 10),
(14, 'Roucarnage', 'pidgeot.png', 30, 20, 8, 20, 20);

DROP TABLE IF EXISTS `pokemons_evolutions`;
CREATE TABLE IF NOT EXISTS `pokemons_evolutions` (
  `level` int(11) NOT NULL DEFAULT '1',
  `baseId` int(11) NOT NULL,
  `evolutionId` int(11) NOT NULL,
  PRIMARY KEY (`baseId`,`evolutionId`),
  KEY `evolutionId` (`evolutionId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

INSERT INTO `pokemons_evolutions` (`level`, `baseId`, `evolutionId`) VALUES
(16, 1, 2),
(34, 2, 3),
(16, 4, 5),
(36, 5, 6),
(16, 7, 8),
(36, 8, 9),
(20, 10, 11),
(18, 12, 13),
(36, 13, 14);
```

The command to run the script, to extract the `CREATE TABLE` queries : 

```bash
./extract-sql.bash -i=input_file.sql -q="CREATE TABLE" -o=output_file.sql
```

The content of the `output_file.sql` once the command is done : 

```sql
CREATE TABLE IF NOT EXISTS `pokemons` (   `id` int(11) NOT NULL AUTO_INCREMENT,   `name` varchar(255) NOT NULL,   `image` varchar(255) NOT NULL DEFAULT 'placeholder.png',   `hp` int(11) NOT NULL DEFAULT '1',   `attack` int(11) NOT NULL DEFAULT '1',   `specialAttack` int(11) NOT NULL DEFAULT '1',   `experienceGiven` int(11) NOT NULL DEFAULT '1',   `moneyGiven` int(11) NOT NULL DEFAULT '1',   PRIMARY KEY (`id`) ) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;  
CREATE TABLE IF NOT EXISTS `pokemons_evolutions` (   `level` int(11) NOT NULL DEFAULT '1',   `baseId` int(11) NOT NULL,   `evolutionId` int(11) NOT NULL,   PRIMARY KEY (`baseId`,`evolutionId`),   KEY `evolutionId` (`evolutionId`) ) ENGINE=InnoDB DEFAULT CHARSET=latin1;
```
