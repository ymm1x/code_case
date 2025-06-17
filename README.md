# code_case

A tool for converting input strings into various case styles, including both singular and plural forms.

Supports conversion to MACRO_CASE, snake_case, UpperCamelCase, and lowerCamelCase, and automatically generates both singular and plural transformations for each case style.

## License

MIT License

## Usage

Run the Ruby script directly:  
`ruby code_case.rb <InputString>`

Or use the included alias script:  
`cc2 <InputString>`

Example:

```sh
$ cc2 QuestEnemy
quest_enemy
questEnemy
QuestEnemy
QUEST_ENEMY
quest_enemies
questEnemies
QuestEnemies
QUEST_ENEMIES
```

## Environment

- Recommended Ruby version: 3.x  
- Ruby 2.6 or lower is not guaranteed to work due to ActiveSupport incompatibilities.  
- Dependencies managed with Bundler.

## Setup

```sh
bundle install
```

```sh
# Enable alias
sudo ln -s "$(realpath cc2)" /usr/local/bin/cc2

# Disable alias
sudo rm /usr/local/bin/cc2
```
