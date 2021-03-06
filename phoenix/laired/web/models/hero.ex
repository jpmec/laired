defmodule Laired.Hero do
  use Laired.Web, :model

  @derive {Poison.Encoder, only: [
    :name,
    :bag,
    :display_group,
    :abilities,
    :skills
  ]}

  schema "heros" do
    field :name, :string

    has_one :bag, Laired.Bag
    has_one :display_group, Laired.DisplayGroup

    has_many :abilities, Laired.HeroAbility
    has_many :skills, Laired.HeroSkill

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
