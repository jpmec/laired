defmodule Laired.HeroSkillController do
  use Laired.Web, :controller

  alias Laired.HeroSkill

  plug :scrub_params, "hero_skill" when action in [:create, :update]

  def index(conn, _params) do
    hero_skills = Repo.all(HeroSkill)
    render(conn, "index.html", hero_skills: hero_skills)
  end

  def new(conn, _params) do
    changeset = HeroSkill.changeset(%HeroSkill{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"hero_skill" => hero_skill_params}) do
    changeset = HeroSkill.changeset(%HeroSkill{}, hero_skill_params)

    case Repo.insert(changeset) do
      {:ok, _hero_skill} ->
        conn
        |> put_flash(:info, "Hero skill created successfully.")
        |> redirect(to: hero_skill_path(conn, :index))
      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    hero_skill = Repo.get!(HeroSkill, id)
    case get_format(conn) do
      "json" ->
        render(conn, hero_skill: hero_skill)
      _ ->
        render(conn, "show.html", hero_skill: hero_skill)
    end
  end


  def edit(conn, %{"id" => id}) do
    hero_skill = Repo.get!(HeroSkill, id)
    changeset = HeroSkill.changeset(hero_skill)
    render(conn, "edit.html", hero_skill: hero_skill, changeset: changeset)
  end

  def update(conn, %{"id" => id, "hero_skill" => hero_skill_params}) do
    hero_skill = Repo.get!(HeroSkill, id)
    changeset = HeroSkill.changeset(hero_skill, hero_skill_params)

    case Repo.update(changeset) do
      {:ok, hero_skill} ->
        conn
        |> put_flash(:info, "Hero skill updated successfully.")
        |> redirect(to: hero_skill_path(conn, :show, hero_skill))
      {:error, changeset} ->
        render(conn, "edit.html", hero_skill: hero_skill, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    hero_skill = Repo.get!(HeroSkill, id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(hero_skill)

    conn
    |> put_flash(:info, "Hero skill deleted successfully.")
    |> redirect(to: hero_skill_path(conn, :index))
  end
end
