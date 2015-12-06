defmodule Laired.HeroAbilityView do
  use Laired.Web, :view

  def render("show.json", %{hero_ability: hero_ability}) do
    hero_ability
  end
end
