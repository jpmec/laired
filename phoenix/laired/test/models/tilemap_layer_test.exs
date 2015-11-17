defmodule Laired.TilemapLayerTest do
  use Laired.ModelCase

  alias Laired.TilemapLayer

  @valid_attrs %{height: 42, name: "some content", opacity: 42, type: "some content", visible: true, width: 42, x: 42, y: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = TilemapLayer.changeset(%TilemapLayer{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = TilemapLayer.changeset(%TilemapLayer{}, @invalid_attrs)
    refute changeset.valid?
  end
end
