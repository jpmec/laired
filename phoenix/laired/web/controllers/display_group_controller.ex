defmodule Laired.DisplayGroupController do
  use Laired.Web, :controller

  alias Laired.DisplayGroup

  plug :scrub_params, "display_group" when action in [:create, :update]

  def index(conn, _params) do
    display_groups = Repo.all(DisplayGroup)
    render(conn, "index.html", display_groups: display_groups)
  end

  def new(conn, _params) do
    changeset = DisplayGroup.changeset(%DisplayGroup{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"display_group" => display_group_params}) do
    changeset = DisplayGroup.changeset(%DisplayGroup{}, display_group_params)

    case Repo.insert(changeset) do
      {:ok, _display_group} ->
        conn
        |> put_flash(:info, "Display group created successfully.")
        |> redirect(to: display_group_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    display_group = Repo.get!(DisplayGroup, id)
      |> Repo.preload([
        {:sprites, :spriteanimations},
        {:sprites, :spritesheets},
        {:sprites, :body}
      ])

    case get_format(conn) do
      "json" ->
        render(conn, display_group: display_group)
      _ ->
        render(conn, "show.html", display_group: display_group)
    end
  end

  def edit(conn, %{"id" => id}) do
    display_group = Repo.get!(DisplayGroup, id)
    changeset = DisplayGroup.changeset(display_group)
    render(conn, "edit.html", display_group: display_group, changeset: changeset)
  end

  def update(conn, %{"id" => id, "display_group" => display_group_params}) do
    display_group = Repo.get!(DisplayGroup, id)
    changeset = DisplayGroup.changeset(display_group, display_group_params)

    case Repo.update(changeset) do
      {:ok, display_group} ->
        conn
        |> put_flash(:info, "Display group updated successfully.")
        |> redirect(to: display_group_path(conn, :show, display_group))
      {:error, changeset} ->
        render(conn, "edit.html", display_group: display_group, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    display_group = Repo.get!(DisplayGroup, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(display_group)

    conn
    |> put_flash(:info, "Display group deleted successfully.")
    |> redirect(to: display_group_path(conn, :index))
  end
end
