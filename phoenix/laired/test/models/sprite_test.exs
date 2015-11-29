defmodule Laired.SpriteTest do
  use Laired.ModelCase

  alias Laired.Sprite

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Sprite.changeset(%Sprite{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Sprite.changeset(%Sprite{}, @invalid_attrs)
    refute changeset.valid?
  end
end
