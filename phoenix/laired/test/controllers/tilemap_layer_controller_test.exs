defmodule Laired.TilemapLayerControllerTest do
  use Laired.ConnCase

  alias Laired.TilemapLayer
  @valid_attrs %{height: 42, name: "some content", opacity: 42, type: "some content", visible: true, width: 42, x: 42, y: 42}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, tilemap_layer_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing tilemap layers"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, tilemap_layer_path(conn, :new)
    assert html_response(conn, 200) =~ "New tilemap layer"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, tilemap_layer_path(conn, :create), tilemap_layer: @valid_attrs
    assert redirected_to(conn) == tilemap_layer_path(conn, :index)
    assert Repo.get_by(TilemapLayer, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, tilemap_layer_path(conn, :create), tilemap_layer: @invalid_attrs
    assert html_response(conn, 200) =~ "New tilemap layer"
  end

  test "shows chosen resource", %{conn: conn} do
    tilemap_layer = Repo.insert! %TilemapLayer{}
    conn = get conn, tilemap_layer_path(conn, :show, tilemap_layer)
    assert html_response(conn, 200) =~ "Show tilemap layer"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, tilemap_layer_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    tilemap_layer = Repo.insert! %TilemapLayer{}
    conn = get conn, tilemap_layer_path(conn, :edit, tilemap_layer)
    assert html_response(conn, 200) =~ "Edit tilemap layer"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    tilemap_layer = Repo.insert! %TilemapLayer{}
    conn = put conn, tilemap_layer_path(conn, :update, tilemap_layer), tilemap_layer: @valid_attrs
    assert redirected_to(conn) == tilemap_layer_path(conn, :show, tilemap_layer)
    assert Repo.get_by(TilemapLayer, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    tilemap_layer = Repo.insert! %TilemapLayer{}
    conn = put conn, tilemap_layer_path(conn, :update, tilemap_layer), tilemap_layer: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit tilemap layer"
  end

  test "deletes chosen resource", %{conn: conn} do
    tilemap_layer = Repo.insert! %TilemapLayer{}
    conn = delete conn, tilemap_layer_path(conn, :delete, tilemap_layer)
    assert redirected_to(conn) == tilemap_layer_path(conn, :index)
    refute Repo.get(TilemapLayer, tilemap_layer.id)
  end
end
