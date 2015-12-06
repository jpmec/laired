defmodule Laired.HeroSkillControllerTest do
  use Laired.ConnCase

  alias Laired.HeroSkill
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, hero_skill_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing hero skills"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, hero_skill_path(conn, :new)
    assert html_response(conn, 200) =~ "New hero skill"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, hero_skill_path(conn, :create), hero_skill: @valid_attrs
    assert redirected_to(conn) == hero_skill_path(conn, :index)
    assert Repo.get_by(HeroSkill, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, hero_skill_path(conn, :create), hero_skill: @invalid_attrs
    assert html_response(conn, 200) =~ "New hero skill"
  end

  test "shows chosen resource", %{conn: conn} do
    hero_skill = Repo.insert! %HeroSkill{}
    conn = get conn, hero_skill_path(conn, :show, hero_skill)
    assert html_response(conn, 200) =~ "Show hero skill"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, hero_skill_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    hero_skill = Repo.insert! %HeroSkill{}
    conn = get conn, hero_skill_path(conn, :edit, hero_skill)
    assert html_response(conn, 200) =~ "Edit hero skill"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    hero_skill = Repo.insert! %HeroSkill{}
    conn = put conn, hero_skill_path(conn, :update, hero_skill), hero_skill: @valid_attrs
    assert redirected_to(conn) == hero_skill_path(conn, :show, hero_skill)
    assert Repo.get_by(HeroSkill, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    hero_skill = Repo.insert! %HeroSkill{}
    conn = put conn, hero_skill_path(conn, :update, hero_skill), hero_skill: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit hero skill"
  end

  test "deletes chosen resource", %{conn: conn} do
    hero_skill = Repo.insert! %HeroSkill{}
    conn = delete conn, hero_skill_path(conn, :delete, hero_skill)
    assert redirected_to(conn) == hero_skill_path(conn, :index)
    refute Repo.get(HeroSkill, hero_skill.id)
  end
end
