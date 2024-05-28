defmodule Consistix.Repo do
  use Ecto.Repo,
    otp_app: :consistix,
    adapter: Ecto.Adapters.Postgres
end
