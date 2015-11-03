defmodule Laired.LairControllerTest do
  use Laired.ConnCase

  alias Laired.Lair
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, lair_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing lairs"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, lair_path(conn, :new)
    assert html_response(conn, 200) =~ "New lair"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, lair_path(conn, :create), lair: @valid_attrs
    assert redirected_to(conn) == lair_path(conn, :index)
    assert Repo.get_by(Lair, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, lair_path(conn, :create), lair: @invalid_attrs
    assert html_response(conn, 200) =~ "New lair"
  end

  test "shows chosen resource", %{conn: conn} do
    lair = Repo.insert! %Lair{}
    conn = get conn, lair_path(conn, :show, lair)
    assert html_response(conn, 200) =~ "Show lair"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, lair_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    lair = Repo.insert! %Lair{}
    conn = get conn, lair_path(conn, :edit, lair)
    assert html_response(conn, 200) =~ "Edit lair"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    lair = Repo.insert! %Lair{}
    conn = put conn, lair_path(conn, :update, lair), lair: @valid_attrs
    assert redirected_to(conn) == lair_path(conn, :show, lair)
    assert Repo.get_by(Lair, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    lair = Repo.insert! %Lair{}
    conn = put conn, lair_path(conn, :update, lair), lair: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit lair"
  end

  test "deletes chosen resource", %{conn: conn} do
    lair = Repo.insert! %Lair{}
    conn = delete conn, lair_path(conn, :delete, lair)
    assert redirected_to(conn) == lair_path(conn, :index)
    refute Repo.get(Lair, lair.id)
  end
end
