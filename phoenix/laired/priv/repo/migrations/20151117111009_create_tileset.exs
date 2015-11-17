defmodule Laired.Repo.Migrations.CreateTileset do
  use Ecto.Migration

  def change do
    create table(:tilesets) do
      add :name, :string
      add :firstgid, :integer
      add :image, :string
      add :imageheight, :integer
      add :imagewidth, :integer
      add :margin, :integer
      add :spacing, :integer
      add :tileheight, :integer
      add :tilewidth, :integer
      add :tilemap_id, references(:tilemaps)

      timestamps
    end

  end
end
