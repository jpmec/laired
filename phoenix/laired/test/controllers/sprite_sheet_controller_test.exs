defmodule Laired.SpriteSheetControllerTest do
  use Laired.ConnCase

  alias Laired.SpriteSheet
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, sprite_sheet_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing sprite sheets"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, sprite_sheet_path(conn, :new)
    assert html_response(conn, 200) =~ "New sprite sheet"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, sprite_sheet_path(conn, :create), sprite_sheet: @valid_attrs
    assert redirected_to(conn) == sprite_sheet_path(conn, :index)
    assert Repo.get_by(SpriteSheet, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, sprite_sheet_path(conn, :create), sprite_sheet: @invalid_attrs
    assert html_response(conn, 200) =~ "New sprite sheet"
  end

  test "shows chosen resource", %{conn: conn} do
    sprite_sheet = Repo.insert! %SpriteSheet{}
    conn = get conn, sprite_sheet_path(conn, :show, sprite_sheet)
    assert html_response(conn, 200) =~ "Show sprite sheet"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, sprite_sheet_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    sprite_sheet = Repo.insert! %SpriteSheet{}
    conn = get conn, sprite_sheet_path(conn, :edit, sprite_sheet)
    assert html_response(conn, 200) =~ "Edit sprite sheet"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    sprite_sheet = Repo.insert! %SpriteSheet{}
    conn = put conn, sprite_sheet_path(conn, :update, sprite_sheet), sprite_sheet: @valid_attrs
    assert redirected_to(conn) == sprite_sheet_path(conn, :show, sprite_sheet)
    assert Repo.get_by(SpriteSheet, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    sprite_sheet = Repo.insert! %SpriteSheet{}
    conn = put conn, sprite_sheet_path(conn, :update, sprite_sheet), sprite_sheet: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit sprite sheet"
  end

  test "deletes chosen resource", %{conn: conn} do
    sprite_sheet = Repo.insert! %SpriteSheet{}
    conn = delete conn, sprite_sheet_path(conn, :delete, sprite_sheet)
    assert redirected_to(conn) == sprite_sheet_path(conn, :index)
    refute Repo.get(SpriteSheet, sprite_sheet.id)
  end
end
