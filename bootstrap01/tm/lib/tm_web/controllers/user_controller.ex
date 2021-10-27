defmodule TmWeb.UserController do
  use TmWeb, :controller

  alias Tm.Schema
  alias Tm.Schema.User

  action_fallback TmWeb.FallbackController

  def index(conn, _params) do
    users = Schema.list_users()
    render(conn, "index.json", users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Schema.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Schema.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Schema.get_user!(id)

    with {:ok, %User{} = user} <- Schema.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Schema.get_user!(id)

    with {:ok, %User{}} <- Schema.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
