import Config

config :scraper, Scraper.Repo,
  database: "scraper_repo",
  username: "user",
  password: "pass",
  hostname: "localhost"

config :scraper, ecto_repos: [Scraper.Repo]
