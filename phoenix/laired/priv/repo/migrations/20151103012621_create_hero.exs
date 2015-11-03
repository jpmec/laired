defmodule Laired.Repo.Migrations.CreateHero do
  use Ecto.Migration

  def change do
    create table(:heros) do
      add :name, :string

      timestamps
    end

  end
end
