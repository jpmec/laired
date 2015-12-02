defmodule Laired.BagTest do
  use Laired.ModelCase

  alias Laired.Bag

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Bag.changeset(%Bag{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Bag.changeset(%Bag{}, @invalid_attrs)
    refute changeset.valid?
  end
end
