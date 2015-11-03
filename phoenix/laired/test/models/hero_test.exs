defmodule Laired.HeroTest do
  use Laired.ModelCase

  alias Laired.Hero

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Hero.changeset(%Hero{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Hero.changeset(%Hero{}, @invalid_attrs)
    refute changeset.valid?
  end
end
