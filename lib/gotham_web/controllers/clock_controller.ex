defmodule GothamWeb.ClockController do
  use GothamWeb, :controller

  alias Gotham.ClockController
  alias Gotham.ClockController.Clock

  action_fallback GothamWeb.FallbackController

  def retrieveUserClock(conn, %{"id" => id}) do
    clock = ClockController.get_clock_by_user_id(id)
    render(conn, "show.json", clock: clock)
  end

  def createUserClock(conn, %{"id" => id}) do
    try do
      with {:ok, %Clock{} = clock} <- ClockController.create_clock(DateTime.utc_now(), id) do
        json(conn, %{
          "data" => %{
            "time" => clock.time,
            "status" => clock.status,
            "user" => clock.user,
          }
        })
      end
    rescue
      _e in Ecto.ConstraintError ->
        json(conn, %{"error" => "Validation failed"})
      true ->
        json(conn, %{"error" => "error"})
    end
  end

  def index(conn, _params) do
    clocks = ClockController.list_clocks()
    render(conn, "index.json", clocks: clocks)
  end

  # def create(conn, %{"clock" => clock_params}) do
  #   with {:ok, %Clock{} = clock} <- ClockController.create_clock(clock_params) do
  #     conn
  #     |> put_status(:created)
  #     |> put_resp_header("location", Routes.clock_path(conn, :show, clock))
  #     |> render("show.json", clock: clock)
  #   end
  # end

  def show(conn, %{"id" => id}) do
    clock = ClockController.get_clock!(id)
    render(conn, "show.json", clock: clock)
  end

  def update(conn, %{"id" => id, "clock" => clock_params}) do
    clock = ClockController.get_clock!(id)

    with {:ok, %Clock{} = clock} <- ClockController.update_clock(clock, clock_params) do
      render(conn, "show.json", clock: clock)
    end
  end

  def delete(conn, %{"id" => id}) do
    clock = ClockController.get_clock!(id)

    with {:ok, %Clock{}} <- ClockController.delete_clock(clock) do
      send_resp(conn, :no_content, "")
    end
  end
end
