defmodule Laired.HeroSkillView do
  use Laired.Web, :view

  def render("show.json", %{hero_skill: hero_skill}) do
    hero_skill
  end
end
