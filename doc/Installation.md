# Installation des dépendances

## Installation de asdf
*Pour installer elixir il faut dans un premier installer asdf, la mettre à jour et ajouter le plugin arlang et elixir dans leurs dernière versions*

git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1

```bash
$ git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.8.1
$ . $HOME/.asdf/asdf.sh
$ . $HOME/.asdf/completions/asdf.bash
$ asdf update
$ asdf plugin-update --all
$ asdf plugin add elixir
$ asdf plugin add erlang
$ asdf install erlang latest
$ asdf install elixir latest
$ asdf global elixir latest
$ asdf global erlang latest
$ elixir -v

```

## Installation de postgree sql 

```bash
$ sudo apt install postgresql
```

## Installation de pheonix

```
$ mix local.hex
$ mix archive.install hex phx_new
$ mix phx.new tm –app timeManager –module Todolist –no-html –no-webpack
$ cd tm
$ mix ecto.create
```



