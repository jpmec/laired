defmodule Laired.QuestController do
  use Laired.Web, :controller

  alias Laired.Quest

  plug :scrub_params, "quest" when action in [:create, :update]

  def index(conn, _params) do
    quests = Repo.all(Quest)
    render(conn, "index.html", quests: quests)
  end

  def new(conn, _params) do
    changeset = Quest.changeset(%Quest{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"quest" => quest_params}) do
    changeset = Quest.changeset(%Quest{}, quest_params)

    case Repo.insert(changeset) do
      {:ok, _quest} ->
        conn
        |> put_flash(:info, "Quest created successfully.")
        |> redirect(to: quest_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    quest = Repo.get!(Quest, id)
    render(conn, "show.html", quest: quest)
  end

  def edit(conn, %{"id" => id}) do
    quest = Repo.get!(Quest, id)
    changeset = Quest.changeset(quest)
    render(conn, "edit.html", quest: quest, changeset: changeset)
  end

  def update(conn, %{"id" => id, "quest" => quest_params}) do
    quest = Repo.get!(Quest, id)
    changeset = Quest.changeset(quest, quest_params)

    case Repo.update(changeset) do
      {:ok, quest} ->
        conn
        |> put_flash(:info, "Quest updated successfully.")
        |> redirect(to: quest_path(conn, :show, quest))
      {:error, changeset} ->
        render(conn, "edit.html", quest: quest, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    quest = Repo.get!(Quest, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(quest)

    conn
    |> put_flash(:info, "Quest deleted successfully.")
    |> redirect(to: quest_path(conn, :index))
  end
end
