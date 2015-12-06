defmodule Laired.PhaserPhysicsBodyView do
  use Laired.Web, :view

  def render("show.json", %{phaser_physics_body: phaser_physics_body}) do
    phaser_physics_body
  end
end
