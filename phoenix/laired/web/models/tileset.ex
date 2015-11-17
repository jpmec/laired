defmodule Laired.Tileset do
  use Laired.Web, :model

  @derive {Poison.Encoder, only: [
    :name,
    :firstgid,
    :image,
    :imageheight,
    :imagewidth,
    :margin,
    :spacing,
    :tileheight,
    :tilewidth
  ]}

  schema "tilesets" do
    field :name, :string
    field :firstgid, :integer
    field :image, :string
    field :imageheight, :integer
    field :imagewidth, :integer
    field :margin, :integer
    field :spacing, :integer
    field :tileheight, :integer
    field :tilewidth, :integer

    belongs_to :tilemap, Laired.Tilemap

    timestamps
  end

  @required_fields ~w(name firstgid image imageheight imagewidth margin spacing tileheight tilewidth)
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
