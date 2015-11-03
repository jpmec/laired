defmodule Laired.Repo.Migrations.CreateQuest do
  use Ecto.Migration

  def change do
    create table(:quests) do
      add :name, :string

      timestamps
    end

  end
end
