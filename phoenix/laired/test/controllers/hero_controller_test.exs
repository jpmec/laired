defmodule Laired.HeroControllerTest do
  use Laired.ConnCase

  alias Laired.Hero
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, hero_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing heros"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, hero_path(conn, :new)
    assert html_response(conn, 200) =~ "New hero"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, hero_path(conn, :create), hero: @valid_attrs
    assert redirected_to(conn) == hero_path(conn, :index)
    assert Repo.get_by(Hero, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, hero_path(conn, :create), hero: @invalid_attrs
    assert html_response(conn, 200) =~ "New hero"
  end

  test "shows chosen resource", %{conn: conn} do
    hero = Repo.insert! %Hero{}
    conn = get conn, hero_path(conn, :show, hero)
    assert html_response(conn, 200) =~ "Show hero"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, hero_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    hero = Repo.insert! %Hero{}
    conn = get conn, hero_path(conn, :edit, hero)
    assert html_response(conn, 200) =~ "Edit hero"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    hero = Repo.insert! %Hero{}
    conn = put conn, hero_path(conn, :update, hero), hero: @valid_attrs
    assert redirected_to(conn) == hero_path(conn, :show, hero)
    assert Repo.get_by(Hero, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    hero = Repo.insert! %Hero{}
    conn = put conn, hero_path(conn, :update, hero), hero: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit hero"
  end

  test "deletes chosen resource", %{conn: conn} do
    hero = Repo.insert! %Hero{}
    conn = delete conn, hero_path(conn, :delete, hero)
    assert redirected_to(conn) == hero_path(conn, :index)
    refute Repo.get(Hero, hero.id)
  end
end
