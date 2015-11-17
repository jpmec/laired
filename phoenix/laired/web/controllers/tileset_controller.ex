defmodule Laired.TilesetController do
  use Laired.Web, :controller

  alias Laired.Tileset

  plug :scrub_params, "tileset" when action in [:create, :update]

  def index(conn, _params) do
    tilesets = Repo.all(Tileset)
    render(conn, "index.html", tilesets: tilesets)
  end

  def new(conn, _params) do
    changeset = Tileset.changeset(%Tileset{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"tileset" => tileset_params}) do
    changeset = Tileset.changeset(%Tileset{}, tileset_params)

    case Repo.insert(changeset) do
      {:ok, _tileset} ->
        conn
        |> put_flash(:info, "Tileset created successfully.")
        |> redirect(to: tileset_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    tileset = Repo.get!(Tileset, id)

    case get_format(conn) do
      "json" ->
        render(conn, tileset: tileset)
      _ ->
        render(conn, "show.html", tileset: tileset)
    end
  end

  def edit(conn, %{"id" => id}) do
    tileset = Repo.get!(Tileset, id)
    changeset = Tileset.changeset(tileset)
    render(conn, "edit.html", tileset: tileset, changeset: changeset)
  end

  def update(conn, %{"id" => id, "tileset" => tileset_params}) do
    tileset = Repo.get!(Tileset, id)
    changeset = Tileset.changeset(tileset, tileset_params)

    case Repo.update(changeset) do
      {:ok, tileset} ->
        conn
        |> put_flash(:info, "Tileset updated successfully.")
        |> redirect(to: tileset_path(conn, :show, tileset))
      {:error, changeset} ->
        render(conn, "edit.html", tileset: tileset, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    tileset = Repo.get!(Tileset, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(tileset)

    conn
    |> put_flash(:info, "Tileset deleted successfully.")
    |> redirect(to: tileset_path(conn, :index))
  end
end
