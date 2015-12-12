defmodule Laired.DisplayGroupView do
  use Laired.Web, :view

  def render("show.json", %{display_group: display_group}) do
    display_group
  end
end
