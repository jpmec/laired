defmodule Laired.Repo.Migrations.CreateStuff do
  use Ecto.Migration

  def change do
    create table(:stuffs) do
      add :name, :string
      add :description, :string

      add :bag_id, references(:bags)
      add :place_id, references(:places)

      timestamps
    end

  end
end
