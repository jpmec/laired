defmodule Laired.PlaceView do
  use Laired.Web, :view

  def render("show.json", %{place: place}) do
    place
  end
end
