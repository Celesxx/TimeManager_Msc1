defmodule GothamWeb.WorkingTimeController do
  use GothamWeb, :controller
  require Logger
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

  def post(conn, %{"userID" => userID, "working_time" => working_time_params}) do
    with {:ok, %WorkingTime{} = working_time} <- WorkingTimeController.create_working_time(working_time_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.working_time_path(conn, :show, working_time))
      |> render("show.json", working_time: working_time)
    end
  end

  def aled(conn, %{"id" => id}, %{"start" => start}, %{"end" => fin}) do
    start = WorkingTimeController.get_working_time!(start)
    fin = WorkingTimeController.get_working_time!(fin)
    id = WorkingTimeController.get_working_time!(id)
    Logger.info "content #{(start)}, #{(fin)}, #{(id)}"
    render(conn, "show.json", start: start, end: fin, id: id)
  end

  def createUserWorkingTime(conn, %{"start" => start}, %{"end" => fin}, %{"id" => id}) do
    try do
      with {:ok, %WorkingTime{} = working_time} <- WorkingTimeController.create_work(start,fin, id) do
        json(conn, %{
          "data" => %{
            "start" => working_time.start,
            "end" => working_time.end,
            "user" => working_time.user,
          }
        })
      end
    rescue
      e in Ecto.ConstraintError ->
        json(conn, %{"error" => "Validation failed"})
      true -> json(conn, %{"error" => "error"})
    end
  end

end
