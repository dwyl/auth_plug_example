defmodule AppWeb.PageControllerTest do
  use AppWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to AuthPlug Example!"
  end

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

  test "get /optional with valid JWT", %{conn: conn} do
    data = %{email: "alex@dwyl.com", givenName: "Alexander",
      picture: "this", auth_provider: "GitHub"}

    jwt = AuthPlug.Token.generate_jwt!(data)

    conn =
      conn
      |> put_req_header("authorization", jwt)
      |> get("/optional")

    token = get_session(conn, :jwt)
    {:ok, decoded} = AuthPlug.Token.verify_jwt(token)

    assert Map.get(decoded, "email") == data.email
    assert html_response(conn, 200) =~ "Welcome Alex"
  end
end
