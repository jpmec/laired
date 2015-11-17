defmodule Laired.TilemapLayerController do
  use Laired.Web, :controller

  alias Laired.TilemapLayer

  plug :scrub_params, "tilemap_layer" when action in [:create, :update]

  def index(conn, _params) do
    tilemap_layers = Repo.all(TilemapLayer)
    render(conn, "index.html", tilemap_layers: tilemap_layers)
  end

  def new(conn, _params) do
    changeset = TilemapLayer.changeset(%TilemapLayer{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"tilemap_layer" => tilemap_layer_params}) do
    changeset = TilemapLayer.changeset(%TilemapLayer{}, tilemap_layer_params)

    case Repo.insert(changeset) do
      {:ok, _tilemap_layer} ->
        conn
        |> put_flash(:info, "Tilemap layer created successfully.")
        |> redirect(to: tilemap_layer_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    tilemap_layer = Repo.get!(TilemapLayer, id)

    case get_format(conn) do
      "json" ->
        render(conn, tilemap_layer: tilemap_layer)
      _ ->
        render(conn, "show.html", tilemap_layer: tilemap_layer)
    end
  end

  def edit(conn, %{"id" => id}) do
    tilemap_layer = Repo.get!(TilemapLayer, id)
    changeset = TilemapLayer.changeset(tilemap_layer)
    render(conn, "edit.html", tilemap_layer: tilemap_layer, changeset: changeset)
  end

  def update(conn, %{"id" => id, "tilemap_layer" => tilemap_layer_params}) do
    tilemap_layer = Repo.get!(TilemapLayer, id)
    changeset = TilemapLayer.changeset(tilemap_layer, tilemap_layer_params)

    case Repo.update(changeset) do
      {:ok, tilemap_layer} ->
        conn
        |> put_flash(:info, "Tilemap layer updated successfully.")
        |> redirect(to: tilemap_layer_path(conn, :show, tilemap_layer))
      {:error, changeset} ->
        render(conn, "edit.html", tilemap_layer: tilemap_layer, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    tilemap_layer = Repo.get!(TilemapLayer, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(tilemap_layer)

    conn
    |> put_flash(:info, "Tilemap layer deleted successfully.")
    |> redirect(to: tilemap_layer_path(conn, :index))
  end
end
