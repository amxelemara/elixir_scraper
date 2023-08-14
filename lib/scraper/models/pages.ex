defmodule Scraper.Pages do
  use Ecto.Schema

  schema "pages" do
    field(:path, :string)
    belongs_to(:domains, Scraper.Domains)
  end
end
