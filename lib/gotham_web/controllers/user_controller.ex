defmodule GothamWeb.UserController do
  require Logger
  use GothamWeb, :controller

  alias Gotham.UserController
  alias Gotham.UserController.User

  action_fallback GothamWeb.FallbackController

  # def index(conn, _params) do
  #   users = UserController.list_users()
  #   render(conn, "index.json", users: users)
  # end

  def index(conn, _params) do

    if not is_nil(conn.query_params["username"]) do
      username = conn.query_params["username"]
      email = conn.query_params["email"]

      Logger.info "username : #{(username)}"

      try do
        user = UserController.get_userMail(username,email)
          json(conn, %{
            "data" => %{
              "username" => user.username,
              "email" => user.email,
              "id" => user.id,
            }
          })
      rescue
        _e in Ecto.ConstraintError ->
          json(conn, %{"error" => "Validation failed"})
        true ->
          json(conn, %{"error" => "error"})
      end
    else
      users = UserController.list_users()
      render(conn, "index.json", users: users)
    end
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- UserController.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end


  def show(conn, %{"id" => id}) do
    user = UserController.get_user!(id)
    render(conn, "show.json", user: user)
  end


  # def index(conn, %{"search" => search_params} = params) do
  #   search_params = search_params

  #   {emails, kerosene} = Email
  #                       |> QueryBuilder.filter_by_search(search_params)
  #                       |> QueryBuilder.filter_by_from(search_params)
  #                       |> QueryBuilder.filter_by_status(search_params)
  #                       |> QueryBuilder.filter_by_date(search_params)
  #                       |> order_by(desc: :date_sent)
  #                       |> Repo.paginate

  #   render conn, "index.html",
  #     emails: emails,
  #     stats: Stats.fetch(search_params),
  #     kerosene: kerosene,
  #     search_params: search_params
  # end

  # def show(conn, %{"id" => id}, %{"email" => email}) do
  #   Logger.info "content : \did = #{(id)} email = #{(email)}"
  #   user = UserController.get_user!(id)
  #   email = UserController.get_user!(email)
  #   render(conn, "show.json", user: user, email: email)
  # end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = UserController.get_user!(id)

    with {:ok, %User{} = user} <- UserController.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    Logger.info "id #{(id)}"
    user = UserController.get_user!(id)

    with {:ok, %User{}} <- UserController.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
