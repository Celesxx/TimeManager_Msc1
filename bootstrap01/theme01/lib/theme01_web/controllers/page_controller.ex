defmodule Theme01Web.PageController do
  use Theme01Web, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
