defmodule Laired.HeroSkillTest do
  use Laired.ModelCase

  alias Laired.HeroSkill

  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = HeroSkill.changeset(%HeroSkill{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = HeroSkill.changeset(%HeroSkill{}, @invalid_attrs)
    refute changeset.valid?
  end
end
