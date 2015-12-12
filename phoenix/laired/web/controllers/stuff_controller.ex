defmodule Laired.StuffController do
  use Laired.Web, :controller

  alias Laired.Stuff

  plug :scrub_params, "stuff" when action in [:create, :update]

  def index(conn, _params) do
    stuffs = Repo.all(Stuff)
    render(conn, "index.html", stuffs: stuffs)
  end

  def new(conn, _params) do
    changeset = Stuff.changeset(%Stuff{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"stuff" => stuff_params}) do
    changeset = Stuff.changeset(%Stuff{}, stuff_params)

    case Repo.insert(changeset) do
      {:ok, _stuff} ->
        conn
        |> put_flash(:info, "Stuff created successfully.")
        |> redirect(to: stuff_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    stuff = Repo.get!(Stuff, id)
      |> Repo.preload({
        :display_group, [
          {:sprites, :spriteanimations},
          {:sprites, :spritesheets},
          {:sprites, :body}
        ]
      })

    case get_format(conn) do
      "json" ->
        render(conn, stuff: stuff)
      _ ->
        render(conn, "show.html", stuff: stuff)
    end
  end

  def edit(conn, %{"id" => id}) do
    stuff = Repo.get!(Stuff, id)
    changeset = Stuff.changeset(stuff)
    render(conn, "edit.html", stuff: stuff, changeset: changeset)
  end

  def update(conn, %{"id" => id, "stuff" => stuff_params}) do
    stuff = Repo.get!(Stuff, id)
    changeset = Stuff.changeset(stuff, stuff_params)

    case Repo.update(changeset) do
      {:ok, stuff} ->
        conn
        |> put_flash(:info, "Stuff updated successfully.")
        |> redirect(to: stuff_path(conn, :show, stuff))
      {:error, changeset} ->
        render(conn, "edit.html", stuff: stuff, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    stuff = Repo.get!(Stuff, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(stuff)

    conn
    |> put_flash(:info, "Stuff deleted successfully.")
    |> redirect(to: stuff_path(conn, :index))
  end
end
