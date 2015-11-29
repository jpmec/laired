defmodule Laired.Repo.Migrations.CreateSprite do
  use Ecto.Migration

  def change do
    create table(:sprites) do
      add :name, :string

      timestamps
    end

  end
end
