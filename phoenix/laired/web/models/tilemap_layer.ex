defmodule Laired.TilemapLayer do
  use Laired.Web, :model

  @derive {Poison.Encoder, only: [
    :name,
    :width,
    :height,
    :x,
    :y,
    :type,
    :visible,
    :opacity,
    :data
  ]}

  schema "tilemap_layers" do
    field :name, :string
    field :width, :integer
    field :height, :integer
    field :x, :integer
    field :y, :integer
    field :type, :string
    field :visible, :boolean, default: false
    field :opacity, :integer
    field :data, {:array, :integer}

    belongs_to :tilemap, Laired.Tilemap

    timestamps
  end

  @required_fields ~w(width height x y type visible opacity name)
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
