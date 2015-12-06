defmodule Laired.PhaserPhysicsBody do
  use Laired.Web, :model

  @derive {Poison.Encoder, only: [
    :collideWorldBounds,
    :bounce,
    :gravity
  ]}


  schema "phaser_physics_bodies" do
    field :collideWorldBounds, :boolean
    field :bounce, :map
    field :gravity, :map

    belongs_to :sprite, Laired.Sprite

    timestamps
  end

  @required_fields ~w(collideWorldBounds )
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end
