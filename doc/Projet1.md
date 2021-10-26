# Projet 1

## Initialisation du projet

# Installe les dépendances 

Supprime la database si elle existe déjà
```bash
$ sudo -u postgres psql <<< "DROP DATABASE gotham;" 
```

Setup la base du projet dans le dossier actuel 
```bash
$ mix phx.new . --app gotham --module Gotham --no-html --no-assets 
```

Crée la database dans postgres 
mix ecto.create 

Génére les controllers 
```bash
mix phx.gen.json UserController User users username:string email:string 
mix ecto.migrate 
mix phx.gen.json ClockController Clock clocks time:datetime status:boolean user:references:users 
mix ecto.migrate mix phx.gen.json WorkingTimeController WorkingTime workingtimes start:datetime end:datetime user:references:users 
mix ecto.migrate 
```

Ajoute les controllers dans les routes d'API 

```bash
sed -i '10i resources "/users", UserController, except: [:new, :edit]' lib/gotham_web/router.ex 
sed -i '10i resources "/clocks", ClockController, except: [:new, :edit]' lib/gotham_web/router.ex 
sed -i '10i resources "/workingtimes", WorkingTimeController, except: [:new, :edit]' lib/gotham_web/router.ex
```
