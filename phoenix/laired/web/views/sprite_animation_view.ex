defmodule Laired.SpriteAnimationView do
  use Laired.Web, :view

  def render("show.json", %{sprite_animation: sprite_animation}) do
    sprite_animation
  end

end
