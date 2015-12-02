defmodule Laired.Bag do
  use Laired.Web, :model

  @derive {Poison.Encoder, only: [
    :name,
    :stuffs
  ]}

  schema "bags" do
    field :name, :string

    has_many :stuffs, Laired.Stuff

    belongs_to :hero, Laired.Hero

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
