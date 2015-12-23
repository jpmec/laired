defmodule Laired.Sprite do
  use Laired.Web, :model


  @derive {Poison.Encoder, only: [
    :name,
    :x,
    :y,
    :frame,
    :spritesheet,
    :spriteanimations,
    :body
  ]}


  schema "sprites" do
    field :name, :string
    field :x, :integer
    field :y, :integer
    field :frame, :integer

    has_one :spritesheet, Laired.SpriteSheet
    has_many :spriteanimations, Laired.SpriteAnimation

    has_one :body, Laired.PhaserPhysicsBody

    belongs_to :display_group, Laired.DisplayGroup

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
