defmodule GuitarPal.Repo do
  use Ecto.Repo,
    otp_app: :guitar_pal,
    adapter: Ecto.Adapters.Postgres
end
