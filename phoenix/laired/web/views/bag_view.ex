defmodule Laired.BagView do
  use Laired.Web, :view

  def render("show.json", %{bag: bag}) do
    bag
  end
end
