defmodule Laired.Repo.Migrations.CreateSpriteSheet do
  use Ecto.Migration

  def change do
    create table(:sprite_sheets) do
      add :name, :string

      add :image, :string
      add :imagewidth, :integer
      add :imageheight, :integer
      add :framewidth, :integer
      add :frameheight, :integer
      add :framemax, :integer
      add :framemargin, :integer
      add :framespacing, :integer

      add :sprite_id, references(:sprites)

      timestamps
    end

  end
end
