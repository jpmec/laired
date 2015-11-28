defmodule Laired.Tilemap do
  use Laired.Web, :model

  @derive {Poison.Encoder, only: [
    :name,
    :tilewidth,
    :tileheight,
    :width,
    :height,
    :orientation,
    :layers,
    :tilesets,
    :version
  ]}

  schema "tilemaps" do

    field :name, :string
    field :tilewidth, :integer
    field :tileheight, :integer
    field :width, :integer
    field :height, :integer
    field :orientation, :string
    field :version, :integer

    has_many :layers, Laired.TilemapLayer
    has_many :tilesets, Laired.Tileset

    belongs_to :place, Laired.Place

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
