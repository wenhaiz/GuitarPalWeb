defmodule GuitarPal.Practice.Exercise do
  use Ecto.Schema
  import Ecto.Changeset

  schema "exercise" do
    field :name, :string
    field :desc, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(exercise, attrs) do
    exercise
    |> cast(attrs, [:name, :desc])
    |> validate_required([:name, :desc])
  end
end
