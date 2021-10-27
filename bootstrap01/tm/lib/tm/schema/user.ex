defmodule Tm.Schema.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :firstName, :string
    field :lastName, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:firstName, :lastName])
    |> validate_required([:firstName, :lastName])
  end
end
