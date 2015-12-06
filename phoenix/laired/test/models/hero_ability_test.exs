defmodule Laired.HeroAbilityTest do
  use Laired.ModelCase

  alias Laired.HeroAbility

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = HeroAbility.changeset(%HeroAbility{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = HeroAbility.changeset(%HeroAbility{}, @invalid_attrs)
    refute changeset.valid?
  end
end
