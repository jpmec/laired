defmodule Laired.Stuff do
  use Laired.Web, :model

  @derive {Poison.Encoder, only: [
    :name,
    :description,
    :display_group
  ]}

  schema "stuffs" do
    field :name, :string
    field :description, :string

    has_one :display_group, Laired.DisplayGroup

    belongs_to :bag, Laired.Bag
    belongs_to :place, Laired.Place

    timestamps
  end

  @required_fields ~w(name description)
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
