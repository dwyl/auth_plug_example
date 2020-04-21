defmodule AppWeb.PageController do
  use AppWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def admin(conn, _param) do
    send_resp(conn, 200, "Admin!")
  end
end
