defmodule Laired.SpriteAnimation do
  use Laired.Web, :model

  @derive {Poison.Encoder, only: [
    :name,
    :frames,
    :framerate,
    :loop
  ]}

  schema "sprite_animations" do
    field :name, :string

    field :frames, {:array, :integer}
    field :framerate, :integer
    field :loop, :boolean

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
