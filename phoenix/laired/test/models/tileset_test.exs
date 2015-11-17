defmodule Laired.TilesetTest do
  use Laired.ModelCase

  alias Laired.Tileset

  @valid_attrs %{firstgid: 42, image: "some content", imageheight: 42, imagewidth: 42, margin: 42, name: "some content", spacing: 42, tileheight: 42, tilewidth: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Tileset.changeset(%Tileset{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Tileset.changeset(%Tileset{}, @invalid_attrs)
    refute changeset.valid?
  end
end
