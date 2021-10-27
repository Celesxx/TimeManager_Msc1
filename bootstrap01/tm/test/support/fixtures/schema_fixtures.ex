defmodule Tm.SchemaFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Tm.Schema` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        firstName: "some firstName",
        lastName: "some lastName"
      })
      |> Tm.Schema.create_user()

    user
  end

  @doc """
  Generate a task.
  """
  def task_fixture(attrs \\ %{}) do
    {:ok, task} =
      attrs
      |> Enum.into(%{
        description: "some description",
        status: "some status",
        title: "some title"
      })
      |> Tm.Schema.create_task()

    task
  end
end
