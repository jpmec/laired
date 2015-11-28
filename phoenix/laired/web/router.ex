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
    get "/lair_editor", LairEditorController, :editor


    resources "/users", UserController
    resources "/heros", HeroController
    resources "/lairs", LairController
    resources "/places", PlaceController
    resources "/quests", QuestController
    resources "/tilemaps", TilemapController
    resources "/tilemap_layers", TilemapLayerController
    resources "/tilesets", TilesetController
    resources "/worlds", WorldController
  end

  # Other scopes may use custom stacks.
  scope "/api", Laired do
    pipe_through :api

    get "/sprite", SpriteController, :hero

    resources "/places", PlaceController
    resources "/tilemaps", TilemapController
    resources "/tilemap_layers", TilemapLayerController
    resources "/tilesets", TilesetController
  end
end
