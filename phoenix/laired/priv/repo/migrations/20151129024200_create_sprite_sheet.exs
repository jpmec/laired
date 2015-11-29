defmodule Laired.Repo.Migrations.CreateSpriteSheet do
  use Ecto.Migration

  def change do
    create table(:sprite_sheets) do
      add :name, :string

      add :image, :string
      add :imageheight, :integer
      add :imagewidth, :integer

      timestamps
    end

  end
end
