defmodule Scraper.Repo.Migrations.CreateSites do
  use Ecto.Migration

  def change do
    create table(:domains) do
      add :url, :string
    end
  end
end
