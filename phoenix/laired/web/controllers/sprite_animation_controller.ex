defmodule Laired.SpriteAnimationController do
  use Laired.Web, :controller

  alias Laired.SpriteAnimation

  plug :scrub_params, "sprite_animation" when action in [:create, :update]

  def index(conn, _params) do
    sprite_animations = Repo.all(SpriteAnimation)
    render(conn, "index.html", sprite_animations: sprite_animations)
  end

  def new(conn, _params) do
    changeset = SpriteAnimation.changeset(%SpriteAnimation{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"sprite_animation" => sprite_animation_params}) do
    changeset = SpriteAnimation.changeset(%SpriteAnimation{}, sprite_animation_params)

    case Repo.insert(changeset) do
      {:ok, _sprite_animation} ->
        conn
        |> put_flash(:info, "Sprite animation created successfully.")
        |> redirect(to: sprite_animation_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    sprite_animation = Repo.get!(SpriteAnimation, id)

    case get_format(conn) do
      "json" ->
        render(conn, sprite_animation: sprite_animation)
      _ ->
        render(conn, "show.html", sprite_animation: sprite_animation)
    end
  end

  def edit(conn, %{"id" => id}) do
    sprite_animation = Repo.get!(SpriteAnimation, id)
    changeset = SpriteAnimation.changeset(sprite_animation)
    render(conn, "edit.html", sprite_animation: sprite_animation, changeset: changeset)
  end

  def update(conn, %{"id" => id, "sprite_animation" => sprite_animation_params}) do
    sprite_animation = Repo.get!(SpriteAnimation, id)
    changeset = SpriteAnimation.changeset(sprite_animation, sprite_animation_params)

    case Repo.update(changeset) do
      {:ok, sprite_animation} ->
        conn
        |> put_flash(:info, "Sprite animation updated successfully.")
        |> redirect(to: sprite_animation_path(conn, :show, sprite_animation))
      {:error, changeset} ->
        render(conn, "edit.html", sprite_animation: sprite_animation, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    sprite_animation = Repo.get!(SpriteAnimation, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(sprite_animation)

    conn
    |> put_flash(:info, "Sprite animation deleted successfully.")
    |> redirect(to: sprite_animation_path(conn, :index))
  end
end
