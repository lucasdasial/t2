defmodule T2.Repo do
  use Ecto.Repo,
    otp_app: :t2,
    adapter: Ecto.Adapters.Postgres
end
