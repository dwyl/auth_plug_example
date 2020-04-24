defmodule AppWeb.Router do
  use AppWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end


  scope "/", AppWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  pipeline :auth do
    plug(AuthPlug, %{auth_url: "https://dwylauth.herokuapp.com"})
  end

  scope "/", AppWeb do
    pipe_through :browser
    pipe_through :auth

    get "/admin", PageController, :admin
  end
end
