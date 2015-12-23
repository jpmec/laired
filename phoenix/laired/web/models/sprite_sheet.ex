defmodule Laired.SpriteSheet do
  use Laired.Web, :model

  @derive {Poison.Encoder, only: [
    :name,
    :image,
    :imagewidth,
    :imageheight,
    :framewidth,
    :frameheight,
    :framemax,
    :framemargin,
    :framespacing
  ]}

  schema "sprite_sheets" do
    field :name, :string

    field :image, :string
    field :imagewidth, :integer
    field :imageheight, :integer
    field :framewidth, :integer
    field :frameheight, :integer
    field :framemax, :integer, default: -1
    field :framemargin, :integer, default: 0
    field :framespacing, :integer, default: 0

    belongs_to :sprite, Laired.Sprite

    timestamps
  end

  @required_fields ~w(name)
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
