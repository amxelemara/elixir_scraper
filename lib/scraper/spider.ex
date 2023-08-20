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
    (Agent.get(spider, fn state -> state[:url] end) <> "/" <> path)
    |> HTTPoison.get(header())
  end

  def crawl_async(spider, paths) do
    Enum.map(
      paths,
      &Task.Supervisor.async(SpiderSupervisor, fn ->
        scrape(spider, &1)
      end)
    )
  end

  defp header() do
    [
      {"User-Agent",
       "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.164 Safari/537.36"},
      {"Accept",
       "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8"},
      {"Accept-Language", "en-US,en;q=0.9"}
    ]
  end
end

defmodule SpiderServer do
  use GenServer

  @impl true
  def init(state) do
    {:ok, state}
  end

  @impl true
  def handle_call({:fetch, url, parser }, _from, _) do
    task = Task.Supervisor.async_nolink(SpiderSupervisor, fn ->
      HTTPoison.get(url, header())
      |> parser.parse()
    end)
    {:reply, task, []}
  end

  @impl true
  def handle_info({ref, _answer}, state) do
    Process.demonitor(ref)
    {:noreply, state}
  end

  def handle_info({:DOWN, _ref, :process, _pid, reason}, state) do
    IO.inspect(reason)
    {:noreply, state}
  end

  defp header() do
    [
      {"User-Agent",
       "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.164 Safari/537.36"},
      {"Accept",
       "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,image/apng,*/*;q=0.8"},
      {"Accept-Language", "en-US,en;q=0.9"}
    ]
  end
end
