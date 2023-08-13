defmodule Spider do
  use Agent

  @doc """
    Start a spider, initial state is the 
    base url to crawl
    """
  def start_link(url) do
    Agent.start_link(fn -> %{url: url} end)
  end

  @doc """
    GET a page from a path using the base url
    """
  def scrape(spider, path) do
    Agent.get(spider, fn state -> state[:url] end ) <> path
    |> HTTPoison.get(header())

    # base_url = Agent.get(spider, fn state -> state[:url] end )
    # url = base_url <> path
    # HTTPoison.get(url)
  end

  @docp """
    A default header to use when scraping
    """
  defp header() do
    [
      {"User-Agent", "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.164 Safari/537.36"},
      {"Accept", "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8"},
      {"Accept-Language", "en-US,en;q=0.9"}
    ]
  end
end
