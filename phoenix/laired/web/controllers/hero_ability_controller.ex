defmodule Laired.HeroAbilityController do
  use Laired.Web, :controller

  alias Laired.HeroAbility

  plug :scrub_params, "hero_ability" when action in [:create, :update]

  def index(conn, _params) do
    hero_abilities = Repo.all(HeroAbility)
    render(conn, "index.html", hero_abilities: hero_abilities)
  end

  def new(conn, _params) do
    changeset = HeroAbility.changeset(%HeroAbility{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"hero_ability" => hero_ability_params}) do
    changeset = HeroAbility.changeset(%HeroAbility{}, hero_ability_params)

    case Repo.insert(changeset) do
      {:ok, _hero_ability} ->
        conn
        |> put_flash(:info, "Hero ability created successfully.")
        |> redirect(to: hero_ability_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    hero_ability = Repo.get!(HeroAbility, id)
    case get_format(conn) do
      "json" ->
        render(conn, hero_ability: hero_ability)
      _ ->
        render(conn, "show.html", hero_ability: hero_ability)
    end
  end

  def edit(conn, %{"id" => id}) do
    hero_ability = Repo.get!(HeroAbility, id)
    changeset = HeroAbility.changeset(hero_ability)
    render(conn, "edit.html", hero_ability: hero_ability, changeset: changeset)
  end

  def update(conn, %{"id" => id, "hero_ability" => hero_ability_params}) do
    hero_ability = Repo.get!(HeroAbility, id)
    changeset = HeroAbility.changeset(hero_ability, hero_ability_params)

    case Repo.update(changeset) do
      {:ok, hero_ability} ->
        conn
        |> put_flash(:info, "Hero ability updated successfully.")
        |> redirect(to: hero_ability_path(conn, :show, hero_ability))
      {:error, changeset} ->
        render(conn, "edit.html", hero_ability: hero_ability, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    hero_ability = Repo.get!(HeroAbility, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(hero_ability)

    conn
    |> put_flash(:info, "Hero ability deleted successfully.")
    |> redirect(to: hero_ability_path(conn, :index))
  end
end
