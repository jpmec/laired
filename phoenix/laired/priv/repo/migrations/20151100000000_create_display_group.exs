defmodule Laired.Repo.Migrations.CreateDisplayGroup do
  use Ecto.Migration

  def change do
    create table(:display_groups) do
      add :name, :string

      add :group_id, references(:display_groups)
      add :hero_id, references(:heros)
      add :stuff_id, references(:stuffs)


      timestamps
    end

  end
end
