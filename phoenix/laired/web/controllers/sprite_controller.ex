defmodule Laired.SpriteController do
  use Laired.Web, :controller

  alias Laired.Sprite

  plug :scrub_params, "sprite" when action in [:create, :update]

  def index(conn, _params) do
    sprites = Repo.all(Sprite)
    render(conn, "index.html", sprites: sprites)
  end

  def new(conn, _params) do
    changeset = Sprite.changeset(%Sprite{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"sprite" => sprite_params}) do
    changeset = Sprite.changeset(%Sprite{}, sprite_params)

    case Repo.insert(changeset) do
      {:ok, _sprite} ->
        conn
        |> put_flash(:info, "Sprite created successfully.")
        |> redirect(to: sprite_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    sprite = Repo.get!(Sprite, id) |> Repo.preload(:spritesheets) |> Repo.preload(:spriteanimations)

    case get_format(conn) do
      "json" ->
        render(conn, sprite: sprite)
      _ ->
        render(conn, "show.html", sprite: sprite)
    end
  end

  def edit(conn, %{"id" => id}) do
    sprite = Repo.get!(Sprite, id)
    changeset = Sprite.changeset(sprite)
    render(conn, "edit.html", sprite: sprite, changeset: changeset)
  end

  def update(conn, %{"id" => id, "sprite" => sprite_params}) do
    sprite = Repo.get!(Sprite, id)
    changeset = Sprite.changeset(sprite, sprite_params)

    case Repo.update(changeset) do
      {:ok, sprite} ->
        conn
        |> put_flash(:info, "Sprite updated successfully.")
        |> redirect(to: sprite_path(conn, :show, sprite))
      {:error, changeset} ->
        render(conn, "edit.html", sprite: sprite, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    sprite = Repo.get!(Sprite, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(sprite)

    conn
    |> put_flash(:info, "Sprite deleted successfully.")
    |> redirect(to: sprite_path(conn, :index))
  end
end
