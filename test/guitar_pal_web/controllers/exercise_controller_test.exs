defmodule GuitarPalWeb.ExerciseControllerTest do
  use GuitarPalWeb.ConnCase

  import GuitarPal.PracticeFixtures
  alias GuitarPal.Practice.Exercise

  @create_attrs %{
    name: "some name",
    desc: "some desc"
  }
  @update_attrs %{
    name: "some updated name",
    desc: "some updated desc"
  }
  @invalid_attrs %{name: nil, desc: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all exercise", %{conn: conn} do
      conn = get(conn, ~p"/api/exercise")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create exercise" do
    test "renders exercise when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/exercise", exercise: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/exercise/#{id}")

      assert %{
               "id" => ^id,
               "desc" => "some desc",
               "name" => "some name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/exercise", exercise: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update exercise" do
    setup [:create_exercise]

    test "renders exercise when data is valid", %{conn: conn, exercise: %Exercise{id: id} = exercise} do
      conn = put(conn, ~p"/api/exercise/#{exercise}", exercise: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/exercise/#{id}")

      assert %{
               "id" => ^id,
               "desc" => "some updated desc",
               "name" => "some updated name"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, exercise: exercise} do
      conn = put(conn, ~p"/api/exercise/#{exercise}", exercise: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete exercise" do
    setup [:create_exercise]

    test "deletes chosen exercise", %{conn: conn, exercise: exercise} do
      conn = delete(conn, ~p"/api/exercise/#{exercise}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/exercise/#{exercise}")
      end
    end
  end

  defp create_exercise(_) do
    exercise = exercise_fixture()

    %{exercise: exercise}
  end
end
