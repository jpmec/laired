defmodule Laired.Router do
  use Laired.Web, :router

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

  scope "/", Laired do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index

    get "/game", GameController, :game

    resources "/users", UserController
    resources "/heros", HeroController
    resources "/lairs", LairController
    resources "/quests", QuestController
    resources "/worlds", WorldController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Laired do
  #   pipe_through :api
  # end
end
