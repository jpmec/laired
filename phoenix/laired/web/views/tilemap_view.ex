defmodule Laired.TilemapView do
  use Laired.Web, :view

  def render("show.json", %{tilemap: tilemap}) do
    tilemap
  end
end
