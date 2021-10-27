defmodule Tm.Repo do
  use Ecto.Repo,
    otp_app: :tm,
    adapter: Ecto.Adapters.Postgres
end
