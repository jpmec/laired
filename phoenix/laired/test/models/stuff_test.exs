defmodule Laired.StuffTest do
  use Laired.ModelCase

  alias Laired.Stuff

  @valid_attrs %{description: "some content", name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Stuff.changeset(%Stuff{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Stuff.changeset(%Stuff{}, @invalid_attrs)
    refute changeset.valid?
  end
end
