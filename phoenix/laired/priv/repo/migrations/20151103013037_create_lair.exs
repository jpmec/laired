defmodule Laired.Repo.Migrations.CreateLair do
  use Ecto.Migration

  def change do
    create table(:lairs) do
      add :name, :string

      timestamps
    end

  end
end
