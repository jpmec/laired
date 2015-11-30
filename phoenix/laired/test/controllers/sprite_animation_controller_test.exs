defmodule Laired.SpriteAnimationControllerTest do
  use Laired.ConnCase

  alias Laired.SpriteAnimation
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, sprite_animation_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing sprite animations"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, sprite_animation_path(conn, :new)
    assert html_response(conn, 200) =~ "New sprite animation"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, sprite_animation_path(conn, :create), sprite_animation: @valid_attrs
    assert redirected_to(conn) == sprite_animation_path(conn, :index)
    assert Repo.get_by(SpriteAnimation, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, sprite_animation_path(conn, :create), sprite_animation: @invalid_attrs
    assert html_response(conn, 200) =~ "New sprite animation"
  end

  test "shows chosen resource", %{conn: conn} do
    sprite_animation = Repo.insert! %SpriteAnimation{}
    conn = get conn, sprite_animation_path(conn, :show, sprite_animation)
    assert html_response(conn, 200) =~ "Show sprite animation"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, sprite_animation_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    sprite_animation = Repo.insert! %SpriteAnimation{}
    conn = get conn, sprite_animation_path(conn, :edit, sprite_animation)
    assert html_response(conn, 200) =~ "Edit sprite animation"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    sprite_animation = Repo.insert! %SpriteAnimation{}
    conn = put conn, sprite_animation_path(conn, :update, sprite_animation), sprite_animation: @valid_attrs
    assert redirected_to(conn) == sprite_animation_path(conn, :show, sprite_animation)
    assert Repo.get_by(SpriteAnimation, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    sprite_animation = Repo.insert! %SpriteAnimation{}
    conn = put conn, sprite_animation_path(conn, :update, sprite_animation), sprite_animation: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit sprite animation"
  end

  test "deletes chosen resource", %{conn: conn} do
    sprite_animation = Repo.insert! %SpriteAnimation{}
    conn = delete conn, sprite_animation_path(conn, :delete, sprite_animation)
    assert redirected_to(conn) == sprite_animation_path(conn, :index)
    refute Repo.get(SpriteAnimation, sprite_animation.id)
  end
end
