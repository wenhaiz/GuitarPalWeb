defmodule GuitarPal.PracticeFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `GuitarPal.Practice` context.
  """

  @doc """
  Generate a exercise.
  """
  def exercise_fixture(attrs \\ %{}) do
    {:ok, exercise} =
      attrs
      |> Enum.into(%{
        desc: "some desc",
        name: "some name"
      })
      |> GuitarPal.Practice.create_exercise()

    exercise
  end
end
