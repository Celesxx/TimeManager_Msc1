defmodule TmWeb.PageController do
  use TmWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
