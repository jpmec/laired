defmodule Laired.SpriteSheetController do
  use Laired.Web, :controller

  alias Laired.SpriteSheet

  plug :scrub_params, "sprite_sheet" when action in [:create, :update]

  def index(conn, _params) do
    sprite_sheets = Repo.all(SpriteSheet)
    render(conn, "index.html", sprite_sheets: sprite_sheets)
  end

  def new(conn, _params) do
    changeset = SpriteSheet.changeset(%SpriteSheet{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"sprite_sheet" => sprite_sheet_params}) do
    changeset = SpriteSheet.changeset(%SpriteSheet{}, sprite_sheet_params)

    case Repo.insert(changeset) do
      {:ok, _sprite_sheet} ->
        conn
        |> put_flash(:info, "Sprite sheet created successfully.")
        |> redirect(to: sprite_sheet_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    sprite_sheet = Repo.get!(SpriteSheet, id)

    case get_format(conn) do
      "json" ->
        render(conn, sprite_sheet: sprite_sheet)
      _ ->
        render(conn, "show.html", sprite_sheet: sprite_sheet)
    end
  end

  def edit(conn, %{"id" => id}) do
    sprite_sheet = Repo.get!(SpriteSheet, id)
    changeset = SpriteSheet.changeset(sprite_sheet)
    render(conn, "edit.html", sprite_sheet: sprite_sheet, changeset: changeset)
  end

  def update(conn, %{"id" => id, "sprite_sheet" => sprite_sheet_params}) do
    sprite_sheet = Repo.get!(SpriteSheet, id)
    changeset = SpriteSheet.changeset(sprite_sheet, sprite_sheet_params)

    case Repo.update(changeset) do
      {:ok, sprite_sheet} ->
        conn
        |> put_flash(:info, "Sprite sheet updated successfully.")
        |> redirect(to: sprite_sheet_path(conn, :show, sprite_sheet))
      {:error, changeset} ->
        render(conn, "edit.html", sprite_sheet: sprite_sheet, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    sprite_sheet = Repo.get!(SpriteSheet, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(sprite_sheet)

    conn
    |> put_flash(:info, "Sprite sheet deleted successfully.")
    |> redirect(to: sprite_sheet_path(conn, :index))
  end
end
