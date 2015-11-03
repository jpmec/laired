defmodule Laired.LairTest do
  use Laired.ModelCase

  alias Laired.Lair

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Lair.changeset(%Lair{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Lair.changeset(%Lair{}, @invalid_attrs)
    refute changeset.valid?
  end
end
