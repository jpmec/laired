defmodule Laired.BagController do
  use Laired.Web, :controller

  alias Laired.Bag

  plug :scrub_params, "bag" when action in [:create, :update]

  def index(conn, _params) do
    bags = Repo.all(Bag)
    render(conn, "index.html", bags: bags)
  end

  def new(conn, _params) do
    changeset = Bag.changeset(%Bag{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"bag" => bag_params}) do
    changeset = Bag.changeset(%Bag{}, bag_params)

    case Repo.insert(changeset) do
      {:ok, _bag} ->
        conn
        |> put_flash(:info, "Bag created successfully.")
        |> redirect(to: bag_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    bag = Repo.get!(Bag, id)
    |> Repo.preload({
      :stuffs, {
        :display_group, [
          {:sprites, :spriteanimations},
          {:sprites, :spritesheet},
          {:sprites, :body}
        ]
      }
    })

    case get_format(conn) do
      "json" ->
        render(conn, bag: bag)
      _ ->
        render(conn, "show.html", bag: bag)
    end
  end

  def edit(conn, %{"id" => id}) do
    bag = Repo.get!(Bag, id)
    changeset = Bag.changeset(bag)
    render(conn, "edit.html", bag: bag, changeset: changeset)
  end

  def update(conn, %{"id" => id, "bag" => bag_params}) do
    bag = Repo.get!(Bag, id)
    changeset = Bag.changeset(bag, bag_params)

    case Repo.update(changeset) do
      {:ok, bag} ->
        conn
        |> put_flash(:info, "Bag updated successfully.")
        |> redirect(to: bag_path(conn, :show, bag))
      {:error, changeset} ->
        render(conn, "edit.html", bag: bag, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    bag = Repo.get!(Bag, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(bag)

    conn
    |> put_flash(:info, "Bag deleted successfully.")
    |> redirect(to: bag_path(conn, :index))
  end
end
