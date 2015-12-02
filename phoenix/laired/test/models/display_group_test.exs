defmodule Laired.DisplayGroupTest do
  use Laired.ModelCase

  alias Laired.DisplayGroup

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = DisplayGroup.changeset(%DisplayGroup{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = DisplayGroup.changeset(%DisplayGroup{}, @invalid_attrs)
    refute changeset.valid?
  end
end
