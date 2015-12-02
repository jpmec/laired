defmodule Laired.DisplayGroup do
  use Laired.Web, :model

  @derive {Poison.Encoder, only: [
    :name,
#    :groups,
    :sprites
  ]}

  schema "display_groups" do
    field :name, :string

    has_many :groups, Laired.DisplayGroup
    has_many :sprites, Laired.Sprite

    belongs_to :group, Laired.DisplayGroup
    belongs_to :hero, Laired.Hero
    belongs_to :stuff, Laired.Stuff

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
