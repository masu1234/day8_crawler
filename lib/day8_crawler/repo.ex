defmodule Day8Crawler.Repo do
  use Ecto.Repo,
    otp_app: :day8_crawler,
    adapter: Ecto.Adapters.Postgres
end
