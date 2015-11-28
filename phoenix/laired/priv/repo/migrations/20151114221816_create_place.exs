defmodule Laired.Repo.Migrations.CreatePlace do
  use Ecto.Migration

  def change do
    create table(:places) do
      add :name, :string

      timestamps
    end

  end
end
