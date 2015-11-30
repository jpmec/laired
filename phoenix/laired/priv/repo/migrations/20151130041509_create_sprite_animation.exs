defmodule Laired.Repo.Migrations.CreateSpriteAnimation do
  use Ecto.Migration

  def change do
    create table(:sprite_animations) do
      add :name, :string

      add :frames, {:array, :integer}
      add :framerate, :integer
      add :loop, :boolean

      add :sprite_id, references(:sprites)

      timestamps
    end

  end
end
