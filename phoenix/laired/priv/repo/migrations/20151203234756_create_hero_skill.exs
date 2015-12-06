defmodule Laired.Repo.Migrations.CreateHeroSkill do
  use Ecto.Migration

  def change do
    create table(:hero_skills) do
      add :name, :string
      add :data, :map

      add :hero_id, references(:heros)

      timestamps
    end

  end
end
