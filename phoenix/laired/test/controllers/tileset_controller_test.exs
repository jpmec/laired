defmodule Laired.TilesetControllerTest do
  use Laired.ConnCase

  alias Laired.Tileset
  @valid_attrs %{firstgid: 42, image: "some content", imageheight: 42, imagewidth: 42, margin: 42, name: "some content", spacing: 42, tileheight: 42, tilewidth: 42}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, tileset_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing tilesets"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, tileset_path(conn, :new)
    assert html_response(conn, 200) =~ "New tileset"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, tileset_path(conn, :create), tileset: @valid_attrs
    assert redirected_to(conn) == tileset_path(conn, :index)
    assert Repo.get_by(Tileset, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, tileset_path(conn, :create), tileset: @invalid_attrs
    assert html_response(conn, 200) =~ "New tileset"
  end

  test "shows chosen resource", %{conn: conn} do
    tileset = Repo.insert! %Tileset{}
    conn = get conn, tileset_path(conn, :show, tileset)
    assert html_response(conn, 200) =~ "Show tileset"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, tileset_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    tileset = Repo.insert! %Tileset{}
    conn = get conn, tileset_path(conn, :edit, tileset)
    assert html_response(conn, 200) =~ "Edit tileset"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    tileset = Repo.insert! %Tileset{}
    conn = put conn, tileset_path(conn, :update, tileset), tileset: @valid_attrs
    assert redirected_to(conn) == tileset_path(conn, :show, tileset)
    assert Repo.get_by(Tileset, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    tileset = Repo.insert! %Tileset{}
    conn = put conn, tileset_path(conn, :update, tileset), tileset: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit tileset"
  end

  test "deletes chosen resource", %{conn: conn} do
    tileset = Repo.insert! %Tileset{}
    conn = delete conn, tileset_path(conn, :delete, tileset)
    assert redirected_to(conn) == tileset_path(conn, :index)
    refute Repo.get(Tileset, tileset.id)
  end
end
