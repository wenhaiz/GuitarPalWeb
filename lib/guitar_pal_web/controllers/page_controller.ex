defmodule GuitarPalWeb.PageController do
  use GuitarPalWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
