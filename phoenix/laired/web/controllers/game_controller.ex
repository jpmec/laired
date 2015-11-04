defmodule Laired.GameController do
  use Laired.Web, :controller

  def game(conn, _params) do
    render conn, "game.html"
  end
end
