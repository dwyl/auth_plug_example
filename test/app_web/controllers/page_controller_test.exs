defmodule AppWeb.PageControllerTest do
  use AppWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to Phoenix!"
  end

  # @tag endpoint: "/admin"
  test "get_session(conn, :jwt)", %{conn: conn} do
    data = %{email: "alice@dwyl.com", givenName: "Alice",
    picture: "this", auth_provider: "google"}
    jwt = AuthPlug.Token.generate_jwt!(data)
    conn =
      conn
      |> put_req_header("authorization", jwt)
      |> get("/admin")

    token = get_session(conn, :jwt)
    {:ok, decoded} = AuthPlug.Token.verify_jwt(token)
    assert Map.get(decoded, "email") == "alice@dwyl.com"
    assert html_response(conn, 200) =~ "Welcome Alice!"
  end
end
