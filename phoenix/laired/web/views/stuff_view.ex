defmodule Laired.StuffView do
  use Laired.Web, :view

  def render("show.json", %{stuff: stuff}) do
    stuff
  end
end
