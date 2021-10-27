defmodule TmWeb.TaskController do
  use TmWeb, :controller
  require Logger
  alias Tm.Schema
  alias Tm.Schema.Task

  action_fallback TmWeb.FallbackController

  def index(conn, _params) do
    tasks = Schema.list_tasks()
    render(conn, "index.json", tasks: tasks)
  end

  def create(conn, %{"task" => task_params}) do
    Logger.info task_params
    with {:ok, %Task{} = task} <- Schema.create_task(task_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.task_path(conn, :show, task))
      |> render("show.json", task: task)
    end
  end

  def show(conn, %{"id" => id}) do
    task = Schema.get_task!(id)
    render(conn, "show.json", task: task)
  end

  def update(conn, %{"id" => id, "task" => task_params}) do
    task = Schema.get_task!(id)

    with {:ok, %Task{} = task} <- Schema.update_task(task, task_params) do
      render(conn, "show.json", task: task)
    end
  end

  def delete(conn, %{"id" => id}) do
    task = Schema.get_task!(id)

    with {:ok, %Task{}} <- Schema.delete_task(task) do
      send_resp(conn, :no_content, "")
    end
  end
end
