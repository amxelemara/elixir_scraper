defmodule Scraper.Repo.Migrations.CreatePages do
  use Ecto.Migration

  def change do
    create table(:pages) do
      add :path, :string
      add :domains_id, references(:domains)
    end
  end
end
