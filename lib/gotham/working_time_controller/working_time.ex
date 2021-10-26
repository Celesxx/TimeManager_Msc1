defmodule Gotham.WorkingTimeController.WorkingTime do
  use Ecto.Schema
  import Ecto.Changeset

  schema "workingtimes" do
    field :end, :naive_datetime
    field :start, :naive_datetime
    field :user, :id

    timestamps()
  end

  @doc false
  def changeset(working_time, attrs) do
    working_time
    |> cast(attrs, [:start, :end, :user])
<<<<<<< HEAD
    |> validate_required([:start, :end])
=======
    |> validate_required([:start, :end, :user])
>>>>>>> f0e46b89b31d5aa74591b70b5752350e0c41e337
  end
end
