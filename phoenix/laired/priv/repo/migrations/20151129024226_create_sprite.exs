defmodule Laired.Repo.Migrations.CreateSprite do
  use Ecto.Migration

  def change do
    create table(:sprites) do
      add :name, :string
      add :x, :integer
      add :y, :integer
      add :frame, :integer, default: 0

      add :display_group_id, references(:display_groups)

      timestamps
    end

  end
end
