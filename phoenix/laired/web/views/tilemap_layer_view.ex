defmodule Laired.TilemapLayerView do
  use Laired.Web, :view

  def render("show.json", %{tilemap_layer: tilemap_layer}) do
    tilemap_layer
  end
end
