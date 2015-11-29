defmodule Laired.SpriteControllerTest do
  use Laired.ConnCase

  alias Laired.Sprite
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, sprite_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing sprites"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, sprite_path(conn, :new)
    assert html_response(conn, 200) =~ "New sprite"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, sprite_path(conn, :create), sprite: @valid_attrs
    assert redirected_to(conn) == sprite_path(conn, :index)
    assert Repo.get_by(Sprite, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, sprite_path(conn, :create), sprite: @invalid_attrs
    assert html_response(conn, 200) =~ "New sprite"
  end

  test "shows chosen resource", %{conn: conn} do
    sprite = Repo.insert! %Sprite{}
    conn = get conn, sprite_path(conn, :show, sprite)
    assert html_response(conn, 200) =~ "Show sprite"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, sprite_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    sprite = Repo.insert! %Sprite{}
    conn = get conn, sprite_path(conn, :edit, sprite)
    assert html_response(conn, 200) =~ "Edit sprite"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    sprite = Repo.insert! %Sprite{}
    conn = put conn, sprite_path(conn, :update, sprite), sprite: @valid_attrs
    assert redirected_to(conn) == sprite_path(conn, :show, sprite)
    assert Repo.get_by(Sprite, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    sprite = Repo.insert! %Sprite{}
    conn = put conn, sprite_path(conn, :update, sprite), sprite: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit sprite"
  end

  test "deletes chosen resource", %{conn: conn} do
    sprite = Repo.insert! %Sprite{}
    conn = delete conn, sprite_path(conn, :delete, sprite)
    assert redirected_to(conn) == sprite_path(conn, :index)
    refute Repo.get(Sprite, sprite.id)
  end
end
