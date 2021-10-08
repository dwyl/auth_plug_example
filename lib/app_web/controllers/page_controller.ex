defmodule AppWeb.PageController do
  use AppWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def admin(conn, _param) do
    # IO.inspect(conn.assigns.person, label: "conn.assigns.person")
    render(conn, "admin.html")
  end

  def optional(conn, _param) do
    # IO.inspect(conn.assigns, label: "conn.assigns")
    render(conn, "optional.html")
  end

  def ping(conn, params) do
    Ping.render_pixel(conn, params)
  end
end
