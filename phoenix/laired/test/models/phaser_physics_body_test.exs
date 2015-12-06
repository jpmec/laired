defmodule Laired.PhaserPhysicsBodyTest do
  use Laired.ModelCase

  alias Laired.PhaserPhysicsBody

  @valid_attrs %{"": true, collideWorldBounds: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = PhaserPhysicsBody.changeset(%PhaserPhysicsBody{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = PhaserPhysicsBody.changeset(%PhaserPhysicsBody{}, @invalid_attrs)
    refute changeset.valid?
  end
end
