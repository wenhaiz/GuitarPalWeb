defmodule GuitarPal.PracticeTest do
  use GuitarPal.DataCase

  alias GuitarPal.Practice

  describe "exercise" do
    alias GuitarPal.Practice.Exercise

    import GuitarPal.PracticeFixtures

    @invalid_attrs %{name: nil, desc: nil}

    test "list_exercise/0 returns all exercise" do
      exercise = exercise_fixture()
      assert Practice.list_exercise() == [exercise]
    end

    test "get_exercise!/1 returns the exercise with given id" do
      exercise = exercise_fixture()
      assert Practice.get_exercise!(exercise.id) == exercise
    end

    test "create_exercise/1 with valid data creates a exercise" do
      valid_attrs = %{name: "some name", desc: "some desc"}

      assert {:ok, %Exercise{} = exercise} = Practice.create_exercise(valid_attrs)
      assert exercise.name == "some name"
      assert exercise.desc == "some desc"
    end

    test "create_exercise/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Practice.create_exercise(@invalid_attrs)
    end

    test "update_exercise/2 with valid data updates the exercise" do
      exercise = exercise_fixture()
      update_attrs = %{name: "some updated name", desc: "some updated desc"}

      assert {:ok, %Exercise{} = exercise} = Practice.update_exercise(exercise, update_attrs)
      assert exercise.name == "some updated name"
      assert exercise.desc == "some updated desc"
    end

    test "update_exercise/2 with invalid data returns error changeset" do
      exercise = exercise_fixture()
      assert {:error, %Ecto.Changeset{}} = Practice.update_exercise(exercise, @invalid_attrs)
      assert exercise == Practice.get_exercise!(exercise.id)
    end

    test "delete_exercise/1 deletes the exercise" do
      exercise = exercise_fixture()
      assert {:ok, %Exercise{}} = Practice.delete_exercise(exercise)
      assert_raise Ecto.NoResultsError, fn -> Practice.get_exercise!(exercise.id) end
    end

    test "change_exercise/1 returns a exercise changeset" do
      exercise = exercise_fixture()
      assert %Ecto.Changeset{} = Practice.change_exercise(exercise)
    end
  end
end
