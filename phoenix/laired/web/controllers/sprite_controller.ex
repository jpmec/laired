defmodule Laired.SpriteController do
  use Laired.Web, :controller

  def hero(conn, _params) do
    render conn, "hero.png"
  end
end
