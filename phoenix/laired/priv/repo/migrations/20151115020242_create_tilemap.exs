defmodule Laired.Repo.Migrations.CreateTilemap do
  use Ecto.Migration

  def change do
    create table(:tilemaps) do
      add :name, :string
      add :tilewidth, :integer
      add :tileheight, :integer
      add :width, :integer
      add :height, :integer
      add :orientation, :string
      add :version, :integer

      timestamps
    end

  end
end
