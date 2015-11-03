defmodule Laired.LairController do
  use Laired.Web, :controller

  alias Laired.Lair

  plug :scrub_params, "lair" when action in [:create, :update]

  def index(conn, _params) do
    lairs = Repo.all(Lair)
    render(conn, "index.html", lairs: lairs)
  end

  def new(conn, _params) do
    changeset = Lair.changeset(%Lair{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"lair" => lair_params}) do
    changeset = Lair.changeset(%Lair{}, lair_params)

    case Repo.insert(changeset) do
      {:ok, _lair} ->
        conn
        |> put_flash(:info, "Lair created successfully.")
        |> redirect(to: lair_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    lair = Repo.get!(Lair, id)
    render(conn, "show.html", lair: lair)
  end

  def edit(conn, %{"id" => id}) do
    lair = Repo.get!(Lair, id)
    changeset = Lair.changeset(lair)
    render(conn, "edit.html", lair: lair, changeset: changeset)
  end

  def update(conn, %{"id" => id, "lair" => lair_params}) do
    lair = Repo.get!(Lair, id)
    changeset = Lair.changeset(lair, lair_params)

    case Repo.update(changeset) do
      {:ok, lair} ->
        conn
        |> put_flash(:info, "Lair updated successfully.")
        |> redirect(to: lair_path(conn, :show, lair))
      {:error, changeset} ->
        render(conn, "edit.html", lair: lair, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    lair = Repo.get!(Lair, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(lair)

    conn
    |> put_flash(:info, "Lair deleted successfully.")
    |> redirect(to: lair_path(conn, :index))
  end
end
