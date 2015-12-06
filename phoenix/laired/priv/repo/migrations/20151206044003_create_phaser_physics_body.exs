defmodule Laired.Repo.Migrations.CreatePhaserPhysicsBody do
  use Ecto.Migration

  def change do
    create table(:phaser_physics_bodies) do
      add :collideWorldBounds, :boolean
      add :bounce, :map
      add :gravity, :map

      add :sprite_id, references(:sprites)


      timestamps
    end

  end
end
