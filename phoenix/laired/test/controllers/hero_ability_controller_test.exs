defmodule Laired.HeroAbilityControllerTest do
  use Laired.ConnCase

  alias Laired.HeroAbility
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, hero_ability_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing hero abilities"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, hero_ability_path(conn, :new)
    assert html_response(conn, 200) =~ "New hero ability"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, hero_ability_path(conn, :create), hero_ability: @valid_attrs
    assert redirected_to(conn) == hero_ability_path(conn, :index)
    assert Repo.get_by(HeroAbility, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, hero_ability_path(conn, :create), hero_ability: @invalid_attrs
    assert html_response(conn, 200) =~ "New hero ability"
  end

  test "shows chosen resource", %{conn: conn} do
    hero_ability = Repo.insert! %HeroAbility{}
    conn = get conn, hero_ability_path(conn, :show, hero_ability)
    assert html_response(conn, 200) =~ "Show hero ability"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, hero_ability_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    hero_ability = Repo.insert! %HeroAbility{}
    conn = get conn, hero_ability_path(conn, :edit, hero_ability)
    assert html_response(conn, 200) =~ "Edit hero ability"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    hero_ability = Repo.insert! %HeroAbility{}
    conn = put conn, hero_ability_path(conn, :update, hero_ability), hero_ability: @valid_attrs
    assert redirected_to(conn) == hero_ability_path(conn, :show, hero_ability)
    assert Repo.get_by(HeroAbility, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    hero_ability = Repo.insert! %HeroAbility{}
    conn = put conn, hero_ability_path(conn, :update, hero_ability), hero_ability: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit hero ability"
  end

  test "deletes chosen resource", %{conn: conn} do
    hero_ability = Repo.insert! %HeroAbility{}
    conn = delete conn, hero_ability_path(conn, :delete, hero_ability)
    assert redirected_to(conn) == hero_ability_path(conn, :index)
    refute Repo.get(HeroAbility, hero_ability.id)
  end
end
