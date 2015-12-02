defmodule Laired.HeroView do
  use Laired.Web, :view

  def render("show.json", %{hero: hero}) do
    hero
  end
end
