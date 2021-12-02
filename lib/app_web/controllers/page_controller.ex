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
    auth_url = AuthPlug.get_auth_url(conn)
    render(conn, "optional.html", auth_url: auth_url)
  end

  def ping(conn, params) do
    Ping.render_pixel(conn, params)
  end

  def logout(conn, _params) do
    conn
    |> AuthPlug.logout()
    |> render("loggedout.html")
  end
end
