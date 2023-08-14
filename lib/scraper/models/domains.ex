defmodule Scraper.Domains do
  use Ecto.Schema

  schema "domains" do
    field :url, :string
     has_many :pages, Scraper.Pages
  end
end
