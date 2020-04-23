defmodule AppWeb.Router do
  use AppWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    # plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug(AuthPlug, %{auth_url: "https://dwylauth.herokuapp.com"})
  end


  scope "/", AppWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/", AppWeb do
    pipe_through :auth
    pipe_through :browser

    get "/admin", PageController, :admin
  end

  # Other scopes may use custom stacks.
  # scope "/api", AppWeb do
  #   pipe_through :api
  # end
end
