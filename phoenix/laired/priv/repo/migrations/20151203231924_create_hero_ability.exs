defmodule Laired.Repo.Migrations.CreateHeroAbility do
  use Ecto.Migration

  def change do
    create table(:hero_abilities) do
      add :name, :string
      add :data, :map

      add :hero_id, references(:heros)

      timestamps
    end

  end
end
