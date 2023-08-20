defmodule Scraper do
  @moduledoc """
    A web scraper
  """

  @doc """
  Hello world.

  ## Examples

      iex> Scraper.hello()
      :world

  """
  use Application

  def start(_type, _args) do
    Scraper.Supervisor.start_link(name: Scraper.Supervisor)
  end

  def hello do
    :world
  end
end
