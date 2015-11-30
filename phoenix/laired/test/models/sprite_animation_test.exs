defmodule Laired.SpriteAnimationTest do
  use Laired.ModelCase

  alias Laired.SpriteAnimation

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = SpriteAnimation.changeset(%SpriteAnimation{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = SpriteAnimation.changeset(%SpriteAnimation{}, @invalid_attrs)
    refute changeset.valid?
  end
end
