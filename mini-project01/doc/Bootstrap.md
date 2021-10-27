# Bootstrap 

## ajouter les schéma 

```bash
mix phx.gen.json Schema User users firstName:string lastName:string
mix ecto.migrate

mix phx.gen.json Schema  Task tasks title:string description:string status:string user:references:users
mix ecto.migrate
mix ecto.migrations

```

## Ajouter les routes 

dans le fichier lib --> tmWeb --> routeur.ex ajouter 

```elixir

resources "/users", UserController, except: [:new, :edit]

scope "/api", TmWeb do

	resources "/tasks", TaskController
end
̀```