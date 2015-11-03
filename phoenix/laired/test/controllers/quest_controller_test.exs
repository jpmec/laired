defmodule Laired.QuestControllerTest do
  use Laired.ConnCase

  alias Laired.Quest
  @valid_attrs %{name: "some content"}
  @invalid_attrs %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, quest_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing quests"
  end

  test "renders form for new resources", %{conn: conn} do
    conn = get conn, quest_path(conn, :new)
    assert html_response(conn, 200) =~ "New quest"
  end

  test "creates resource and redirects when data is valid", %{conn: conn} do
    conn = post conn, quest_path(conn, :create), quest: @valid_attrs
    assert redirected_to(conn) == quest_path(conn, :index)
    assert Repo.get_by(Quest, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, quest_path(conn, :create), quest: @invalid_attrs
    assert html_response(conn, 200) =~ "New quest"
  end

  test "shows chosen resource", %{conn: conn} do
    quest = Repo.insert! %Quest{}
    conn = get conn, quest_path(conn, :show, quest)
    assert html_response(conn, 200) =~ "Show quest"
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_raise Ecto.NoResultsError, fn ->
      get conn, quest_path(conn, :show, -1)
    end
  end

  test "renders form for editing chosen resource", %{conn: conn} do
    quest = Repo.insert! %Quest{}
    conn = get conn, quest_path(conn, :edit, quest)
    assert html_response(conn, 200) =~ "Edit quest"
  end

  test "updates chosen resource and redirects when data is valid", %{conn: conn} do
    quest = Repo.insert! %Quest{}
    conn = put conn, quest_path(conn, :update, quest), quest: @valid_attrs
    assert redirected_to(conn) == quest_path(conn, :show, quest)
    assert Repo.get_by(Quest, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    quest = Repo.insert! %Quest{}
    conn = put conn, quest_path(conn, :update, quest), quest: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit quest"
  end

  test "deletes chosen resource", %{conn: conn} do
    quest = Repo.insert! %Quest{}
    conn = delete conn, quest_path(conn, :delete, quest)
    assert redirected_to(conn) == quest_path(conn, :index)
    refute Repo.get(Quest, quest.id)
  end
end
