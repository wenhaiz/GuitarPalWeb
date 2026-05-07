defmodule GuitarPalWeb.ExerciseController do
  use GuitarPalWeb, :controller

  alias GuitarPal.Practice
  alias GuitarPal.Practice.Exercise

  action_fallback GuitarPalWeb.FallbackController

  def index(conn, _params) do
    exercise = Practice.list_exercise()
    render(conn, :index, exercise: exercise)
  end

  def create(conn, %{"exercise" => exercise_params}) do
    with {:ok, %Exercise{} = exercise} <- Practice.create_exercise(exercise_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/exercise/#{exercise}")
      |> render(:show, exercise: exercise)
    end
  end

  def show(conn, %{"id" => id}) do
    exercise = Practice.get_exercise!(id)
    render(conn, :show, exercise: exercise)
  end

  def update(conn, %{"id" => id, "exercise" => exercise_params}) do
    exercise = Practice.get_exercise!(id)

    with {:ok, %Exercise{} = exercise} <- Practice.update_exercise(exercise, exercise_params) do
      render(conn, :show, exercise: exercise)
    end
  end

  def delete(conn, %{"id" => id}) do
    exercise = Practice.get_exercise!(id)

    with {:ok, %Exercise{}} <- Practice.delete_exercise(exercise) do
      send_resp(conn, :no_content, "")
    end
  end
end
