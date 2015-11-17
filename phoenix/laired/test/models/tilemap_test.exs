defmodule Laired.TilemapTest do
  use Laired.ModelCase

  alias Laired.Tilemap

  @valid_attrs %{height: 42, tile_height: 42, tile_width: 42, width: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Tilemap.changeset(%Tilemap{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Tilemap.changeset(%Tilemap{}, @invalid_attrs)
    refute changeset.valid?
  end
end
