defmodule Laired.SpriteView do
  use Laired.Web, :view

  def render("show.json", %{sprite: sprite}) do
    sprite
  end
end
