defmodule Laired.Repo.Migrations.CreateTilemap do
  use Ecto.Migration

  def change do
    create table(:tilemaps) do
      add :name, :string
      add :tile_width, :integer
      add :tile_height, :integer
      add :width, :integer
      add :height, :integer
      add :orientation, :string

      timestamps
    end

  end
end
