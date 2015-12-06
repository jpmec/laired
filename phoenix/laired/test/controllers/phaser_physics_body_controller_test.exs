defmodule Laired.PhaserPhysicsBodyControllerTest do
  use Laired.ConnCase

  alias Laired.PhaserPhysicsBody
  @valid_attrs %{"": true, collideWorldBounds: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, phaser_physics_body_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing phaser physics bodies"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, phaser_physics_body_path(conn, :new)
    assert html_response(conn, 200) =~ "New phaser physics body"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, phaser_physics_body_path(conn, :create), phaser_physics_body: @valid_attrs
    assert redirected_to(conn) == phaser_physics_body_path(conn, :index)
    assert Repo.get_by(PhaserPhysicsBody, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, phaser_physics_body_path(conn, :create), phaser_physics_body: @invalid_attrs
    assert html_response(conn, 200) =~ "New phaser physics body"
  end

  test "shows chosen resource", %{conn: conn} do
    phaser_physics_body = Repo.insert! %PhaserPhysicsBody{}
    conn = get conn, phaser_physics_body_path(conn, :show, phaser_physics_body)
    assert html_response(conn, 200) =~ "Show phaser physics body"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, phaser_physics_body_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    phaser_physics_body = Repo.insert! %PhaserPhysicsBody{}
    conn = get conn, phaser_physics_body_path(conn, :edit, phaser_physics_body)
    assert html_response(conn, 200) =~ "Edit phaser physics body"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    phaser_physics_body = Repo.insert! %PhaserPhysicsBody{}
    conn = put conn, phaser_physics_body_path(conn, :update, phaser_physics_body), phaser_physics_body: @valid_attrs
    assert redirected_to(conn) == phaser_physics_body_path(conn, :show, phaser_physics_body)
    assert Repo.get_by(PhaserPhysicsBody, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    phaser_physics_body = Repo.insert! %PhaserPhysicsBody{}
    conn = put conn, phaser_physics_body_path(conn, :update, phaser_physics_body), phaser_physics_body: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit phaser physics body"
  end

  test "deletes chosen resource", %{conn: conn} do
    phaser_physics_body = Repo.insert! %PhaserPhysicsBody{}
    conn = delete conn, phaser_physics_body_path(conn, :delete, phaser_physics_body)
    assert redirected_to(conn) == phaser_physics_body_path(conn, :index)
    refute Repo.get(PhaserPhysicsBody, phaser_physics_body.id)
  end
end
