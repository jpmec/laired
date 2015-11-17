defmodule Laired.Repo.Migrations.CreateTilemapLayer do
  use Ecto.Migration

  def change do
    create table(:tilemap_layers) do
      add :name, :string
      add :width, :integer
      add :height, :integer
      add :x, :integer
      add :y, :integer
      add :type, :string
      add :visible, :boolean, default: false
      add :opacity, :integer
      add :data, {:array, :integer}
      add :tilemap_id, references(:tilemaps)

      timestamps
    end

  end
end
