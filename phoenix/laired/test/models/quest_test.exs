defmodule Laired.QuestTest do
  use Laired.ModelCase

  alias Laired.Quest

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Quest.changeset(%Quest{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Quest.changeset(%Quest{}, @invalid_attrs)
    refute changeset.valid?
  end
end
