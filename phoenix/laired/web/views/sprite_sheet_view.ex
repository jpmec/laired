defmodule Laired.SpriteSheetView do
  use Laired.Web, :view

  def render("show.json", %{sprite_sheet: sprite_sheet}) do
    sprite_sheet
  end
end
