defmodule Tm.Repo.Migrations.CreateTasks do
  use Ecto.Migration

  def change do
    create table(:tasks) do
      add :title, :string
      add :description, :string
      add :status, :string
      add :user, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:tasks, [:user])
  end
end
