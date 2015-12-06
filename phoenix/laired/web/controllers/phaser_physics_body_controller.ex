defmodule Laired.PhaserPhysicsBodyController do
  use Laired.Web, :controller

  alias Laired.PhaserPhysicsBody

  plug :scrub_params, "phaser_physics_body" when action in [:create, :update]

  def index(conn, _params) do
    phaser_physics_bodies = Repo.all(PhaserPhysicsBody)
    render(conn, "index.html", phaser_physics_bodies: phaser_physics_bodies)
  end

  def new(conn, _params) do
    changeset = PhaserPhysicsBody.changeset(%PhaserPhysicsBody{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"phaser_physics_body" => phaser_physics_body_params}) do
    changeset = PhaserPhysicsBody.changeset(%PhaserPhysicsBody{}, phaser_physics_body_params)

    case Repo.insert(changeset) do
      {:ok, _phaser_physics_body} ->
        conn
        |> put_flash(:info, "Phaser physics body created successfully.")
        |> redirect(to: phaser_physics_body_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    phaser_physics_body = Repo.get!(PhaserPhysicsBody, id)

    case get_format(conn) do
      "json" ->
        render(conn, phaser_physics_body: phaser_physics_body)
      _ ->
        render(conn, "show.html", phaser_physics_body: phaser_physics_body)
    end
  end

  def edit(conn, %{"id" => id}) do
    phaser_physics_body = Repo.get!(PhaserPhysicsBody, id)
    changeset = PhaserPhysicsBody.changeset(phaser_physics_body)
    render(conn, "edit.html", phaser_physics_body: phaser_physics_body, changeset: changeset)
  end

  def update(conn, %{"id" => id, "phaser_physics_body" => phaser_physics_body_params}) do
    phaser_physics_body = Repo.get!(PhaserPhysicsBody, id)
    changeset = PhaserPhysicsBody.changeset(phaser_physics_body, phaser_physics_body_params)

    case Repo.update(changeset) do
      {:ok, phaser_physics_body} ->
        conn
        |> put_flash(:info, "Phaser physics body updated successfully.")
        |> redirect(to: phaser_physics_body_path(conn, :show, phaser_physics_body))
      {:error, changeset} ->
        render(conn, "edit.html", phaser_physics_body: phaser_physics_body, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    phaser_physics_body = Repo.get!(PhaserPhysicsBody, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(phaser_physics_body)

    conn
    |> put_flash(:info, "Phaser physics body deleted successfully.")
    |> redirect(to: phaser_physics_body_path(conn, :index))
  end
end
