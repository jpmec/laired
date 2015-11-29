defmodule Laired.SpriteSheet do
  use Laired.Web, :model

  @derive {Poison.Encoder, only: [
    :name,
    :image,
    :imageheight,
    :imagewidth
  ]}

  schema "sprite_sheets" do
    field :name, :string

    field :image, :string
    field :imageheight, :integer
    field :imagewidth, :integer

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
