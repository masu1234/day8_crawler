import Config

config :day8_crawler, Day8Crawler.Repo,
  database: "day8_crawler_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

config :day8_crawler, ecto_repos: [Day8Crawler.Repo]
