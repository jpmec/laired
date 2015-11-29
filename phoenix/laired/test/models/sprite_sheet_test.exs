defmodule Laired.SpriteSheetTest do
  use Laired.ModelCase

  alias Laired.SpriteSheet

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = SpriteSheet.changeset(%SpriteSheet{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = SpriteSheet.changeset(%SpriteSheet{}, @invalid_attrs)
    refute changeset.valid?
  end
end
