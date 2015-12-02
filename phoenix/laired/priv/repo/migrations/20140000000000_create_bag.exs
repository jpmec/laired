defmodule Laired.Repo.Migrations.CreateBag do
  use Ecto.Migration

  def change do
    create table(:bags) do
      add :name, :string

      add :hero_id, references(:heros)
      timestamps
    end

  end
end
