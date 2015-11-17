defmodule Laired.Tilemap do
  use Laired.Web, :model

  @derive {Poison.Encoder, only: [
    :name,
    :tile_width,
    :tile_height,
    :width,
    :height,
    :orientation
  ]}

  schema "tilemaps" do

    field :name, :string
    field :tile_width, :integer
    field :tile_height, :integer
    field :width, :integer
    field :height, :integer
    field :orientation, :string

    has_many :tilemap_layers, Laired.TilemapLayer

    timestamps
  end

  @required_fields ~w(tile_width tile_height width height)
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
