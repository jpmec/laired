defmodule Laired.StuffControllerTest do
  use Laired.ConnCase

  alias Laired.Stuff
  @valid_attrs %{description: "some content", name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, stuff_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing stuffs"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, stuff_path(conn, :new)
    assert html_response(conn, 200) =~ "New stuff"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, stuff_path(conn, :create), stuff: @valid_attrs
    assert redirected_to(conn) == stuff_path(conn, :index)
    assert Repo.get_by(Stuff, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, stuff_path(conn, :create), stuff: @invalid_attrs
    assert html_response(conn, 200) =~ "New stuff"
  end

  test "shows chosen resource", %{conn: conn} do
    stuff = Repo.insert! %Stuff{}
    conn = get conn, stuff_path(conn, :show, stuff)
    assert html_response(conn, 200) =~ "Show stuff"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, stuff_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    stuff = Repo.insert! %Stuff{}
    conn = get conn, stuff_path(conn, :edit, stuff)
    assert html_response(conn, 200) =~ "Edit stuff"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    stuff = Repo.insert! %Stuff{}
    conn = put conn, stuff_path(conn, :update, stuff), stuff: @valid_attrs
    assert redirected_to(conn) == stuff_path(conn, :show, stuff)
    assert Repo.get_by(Stuff, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    stuff = Repo.insert! %Stuff{}
    conn = put conn, stuff_path(conn, :update, stuff), stuff: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit stuff"
  end

  test "deletes chosen resource", %{conn: conn} do
    stuff = Repo.insert! %Stuff{}
    conn = delete conn, stuff_path(conn, :delete, stuff)
    assert redirected_to(conn) == stuff_path(conn, :index)
    refute Repo.get(Stuff, stuff.id)
  end
end
