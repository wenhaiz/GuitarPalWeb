defmodule GuitarPalWeb.ExerciseJSON do
  alias GuitarPal.Practice.Exercise

  @doc """
  Renders a list of exercise.
  """
  def index(%{exercise: exercise}) do
    %{data: for(exercise <- exercise, do: data(exercise))}
  end

  @doc """
  Renders a single exercise.
  """
  def show(%{exercise: exercise}) do
    %{data: data(exercise)}
  end

  defp data(%Exercise{} = exercise) do
    %{
      id: exercise.id,
      name: exercise.name,
      desc: exercise.desc
    }
  end
end
