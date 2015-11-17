defmodule Laired.TilemapController do
  use Laired.Web, :controller

  alias Laired.Tilemap

  plug :scrub_params, "tilemap" when action in [:create, :update]

  def index(conn, _params) do
    tilemaps = Repo.all(Tilemap)
    render(conn, "index.html", tilemaps: tilemaps)
  end

  def new(conn, _params) do
    changeset = Tilemap.changeset(%Tilemap{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"tilemap" => tilemap_params}) do
    changeset = Tilemap.changeset(%Tilemap{}, tilemap_params)

    case Repo.insert(changeset) do
      {:ok, _tilemap} ->
        conn
        |> put_flash(:info, "Tilemap created successfully.")
        |> redirect(to: tilemap_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    tilemap = Repo.get!(Tilemap, id) |> Repo.preload(:layers) |> Repo.preload(:tilesets)

    case get_format(conn) do
      "json" ->
        render(conn, tilemap: tilemap)
      _ ->
        render(conn, "show.html", tilemap: tilemap)
    end
  end

  def edit(conn, %{"id" => id}) do
    tilemap = Repo.get!(Tilemap, id)
    changeset = Tilemap.changeset(tilemap)
    render(conn, "edit.html", tilemap: tilemap, changeset: changeset)
  end

  def update(conn, %{"id" => id, "tilemap" => tilemap_params}) do
    tilemap = Repo.get!(Tilemap, id)
    changeset = Tilemap.changeset(tilemap, tilemap_params)

    case Repo.update(changeset) do
      {:ok, tilemap} ->
        conn
        |> put_flash(:info, "Tilemap updated successfully.")
        |> redirect(to: tilemap_path(conn, :show, tilemap))
      {:error, changeset} ->
        render(conn, "edit.html", tilemap: tilemap, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    tilemap = Repo.get!(Tilemap, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(tilemap)

    conn
    |> put_flash(:info, "Tilemap deleted successfully.")
    |> redirect(to: tilemap_path(conn, :index))
  end
end
