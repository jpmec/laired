defmodule Laired.BagControllerTest do
  use Laired.ConnCase

  alias Laired.Bag
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, bag_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing bags"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, bag_path(conn, :new)
    assert html_response(conn, 200) =~ "New bag"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, bag_path(conn, :create), bag: @valid_attrs
    assert redirected_to(conn) == bag_path(conn, :index)
    assert Repo.get_by(Bag, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, bag_path(conn, :create), bag: @invalid_attrs
    assert html_response(conn, 200) =~ "New bag"
  end

  test "shows chosen resource", %{conn: conn} do
    bag = Repo.insert! %Bag{}
    conn = get conn, bag_path(conn, :show, bag)
    assert html_response(conn, 200) =~ "Show bag"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, bag_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    bag = Repo.insert! %Bag{}
    conn = get conn, bag_path(conn, :edit, bag)
    assert html_response(conn, 200) =~ "Edit bag"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    bag = Repo.insert! %Bag{}
    conn = put conn, bag_path(conn, :update, bag), bag: @valid_attrs
    assert redirected_to(conn) == bag_path(conn, :show, bag)
    assert Repo.get_by(Bag, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    bag = Repo.insert! %Bag{}
    conn = put conn, bag_path(conn, :update, bag), bag: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit bag"
  end

  test "deletes chosen resource", %{conn: conn} do
    bag = Repo.insert! %Bag{}
    conn = delete conn, bag_path(conn, :delete, bag)
    assert redirected_to(conn) == bag_path(conn, :index)
    refute Repo.get(Bag, bag.id)
  end
end
