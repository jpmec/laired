defmodule Laired.TilesetView do
  use Laired.Web, :view

  def render("show.json", %{tileset: tileset}) do
    tileset
  end
end
