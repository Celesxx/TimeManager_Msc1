defmodule GothamWeb.WorkingTimeController do
  use GothamWeb, :controller

  alias Gotham.WorkingTimeController
  alias Gotham.WorkingTimeController.WorkingTime

  action_fallback GothamWeb.FallbackController

  def index(conn, _params) do
    workingtimes = WorkingTimeController.list_workingtimes()
    render(conn, "index.json", workingtimes: workingtimes)
  end

  def create(conn, %{"working_time" => working_time_params}) do
    with {:ok, %WorkingTime{} = working_time} <- WorkingTimeController.create_working_time(working_time_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.working_time_path(conn, :show, working_time))
      |> render("show.json", working_time: working_time)
    end
  end

  def show(conn, %{"id" => id}) do
    working_time = WorkingTimeController.get_working_time!(id)
    render(conn, "show.json", working_time: working_time)
  end

  def update(conn, %{"id" => id, "working_time" => working_time_params}) do
    working_time = WorkingTimeController.get_working_time!(id)

    with {:ok, %WorkingTime{} = working_time} <- WorkingTimeController.update_working_time(working_time, working_time_params) do
      render(conn, "show.json", working_time: working_time)
    end
  end

  def delete(conn, %{"id" => id}) do
    working_time = WorkingTimeController.get_working_time!(id)

    with {:ok, %WorkingTime{}} <- WorkingTimeController.delete_working_time(working_time) do
      send_resp(conn, :no_content, "")
    end
  end

  def createUserWorkingTime(conn, %{"id" => id}) do

    start = conn.body_params["working_time"]["start"]
    fin = conn.body_params["working_time"]["end"]
    try do
      with {:ok, %WorkingTime{} = working_time} <- WorkingTimeController.create_work(start,fin, id) do
        json(conn, %{
          "data" => %{
            "start" => working_time.start,
            "end" => working_time.end,
            "user" => working_time.user
          }
        })
      end
    rescue
      _e in Ecto.ConstraintError ->
        json(conn, %{"error" => "Validation failed"})
      true -> json(conn, %{"error" => "error"})
    end
  end

end
