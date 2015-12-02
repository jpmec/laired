defmodule Laired.DisplayGroupControllerTest do
  use Laired.ConnCase

  alias Laired.DisplayGroup
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, display_group_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing display groups"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, display_group_path(conn, :new)
    assert html_response(conn, 200) =~ "New display group"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, display_group_path(conn, :create), display_group: @valid_attrs
    assert redirected_to(conn) == display_group_path(conn, :index)
    assert Repo.get_by(DisplayGroup, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, display_group_path(conn, :create), display_group: @invalid_attrs
    assert html_response(conn, 200) =~ "New display group"
  end

  test "shows chosen resource", %{conn: conn} do
    display_group = Repo.insert! %DisplayGroup{}
    conn = get conn, display_group_path(conn, :show, display_group)
    assert html_response(conn, 200) =~ "Show display group"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, display_group_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    display_group = Repo.insert! %DisplayGroup{}
    conn = get conn, display_group_path(conn, :edit, display_group)
    assert html_response(conn, 200) =~ "Edit display group"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    display_group = Repo.insert! %DisplayGroup{}
    conn = put conn, display_group_path(conn, :update, display_group), display_group: @valid_attrs
    assert redirected_to(conn) == display_group_path(conn, :show, display_group)
    assert Repo.get_by(DisplayGroup, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    display_group = Repo.insert! %DisplayGroup{}
    conn = put conn, display_group_path(conn, :update, display_group), display_group: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit display group"
  end

  test "deletes chosen resource", %{conn: conn} do
    display_group = Repo.insert! %DisplayGroup{}
    conn = delete conn, display_group_path(conn, :delete, display_group)
    assert redirected_to(conn) == display_group_path(conn, :index)
    refute Repo.get(DisplayGroup, display_group.id)
  end
end
