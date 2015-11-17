defmodule Laired.TilemapControllerTest do
  use Laired.ConnCase

  alias Laired.Tilemap
  @valid_attrs %{height: 42, tile_height: 42, tile_width: 42, width: 42}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, tilemap_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing tilemaps"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, tilemap_path(conn, :new)
    assert html_response(conn, 200) =~ "New tilemap"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, tilemap_path(conn, :create), tilemap: @valid_attrs
    assert redirected_to(conn) == tilemap_path(conn, :index)
    assert Repo.get_by(Tilemap, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, tilemap_path(conn, :create), tilemap: @invalid_attrs
    assert html_response(conn, 200) =~ "New tilemap"
  end

  test "shows chosen resource", %{conn: conn} do
    tilemap = Repo.insert! %Tilemap{}
    conn = get conn, tilemap_path(conn, :show, tilemap)
    assert html_response(conn, 200) =~ "Show tilemap"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, tilemap_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    tilemap = Repo.insert! %Tilemap{}
    conn = get conn, tilemap_path(conn, :edit, tilemap)
    assert html_response(conn, 200) =~ "Edit tilemap"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    tilemap = Repo.insert! %Tilemap{}
    conn = put conn, tilemap_path(conn, :update, tilemap), tilemap: @valid_attrs
    assert redirected_to(conn) == tilemap_path(conn, :show, tilemap)
    assert Repo.get_by(Tilemap, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    tilemap = Repo.insert! %Tilemap{}
    conn = put conn, tilemap_path(conn, :update, tilemap), tilemap: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit tilemap"
  end

  test "deletes chosen resource", %{conn: conn} do
    tilemap = Repo.insert! %Tilemap{}
    conn = delete conn, tilemap_path(conn, :delete, tilemap)
    assert redirected_to(conn) == tilemap_path(conn, :index)
    refute Repo.get(Tilemap, tilemap.id)
  end
end
