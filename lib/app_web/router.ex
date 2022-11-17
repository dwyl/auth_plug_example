defmodule AppWeb.Router do
  use AppWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :authoptional, do: plug(AuthPlugOptional, %{})

  scope "/", AppWeb do
    pipe_through :browser
    pipe_through :authoptional
    get "/", PageController, :index
    get "/optional", PageController, :optional
    get "/logout", PageController, :logout
  end

  pipeline :auth, do: plug(AuthPlug)

  scope "/", AppWeb do
    pipe_through :browser
    pipe_through :auth
    get "/admin", PageController, :admin
  end

end
