defmodule SpiderTest do
  use ExUnit.Case

  setup do
    port = 4016
    url = "localhost:#{port}"
    {:ok, spider} = Spider.start_link(url)
    %{spider: spider, url: url}
  end

  test "fetch a web page", %{spider: spider} do
    {status, resp} = Spider.scrape(spider, "/")
    assert {:ok, 200} == {status, resp.status_code}
  end

  test "scrape multiple pages and message", %{spider: spider} do
    paths = ["about/", "shop/", "profile/"]

    results =
      Spider.crawl_async(spider, paths)
      |> Enum.map(&Task.await(&1))

    assert length(results) == 3

    Enum.each(results, fn {status, resp} ->
      assert {:ok, 200} == {status, resp.status_code}
    end)
  end

  test "start a scrape task from server", %{url: url} do

    uri = url <> "/"
    {:ok, pid} = GenServer.start_link(SpiderServer, [])
    task = GenServer.call(pid, {:fetch, uri, DummyParser} )
    assert %Task{} = task
    # Race condition here, #REFCTOR
    Process.sleep(1000)
    assert Process.alive?(task.pid) == false
  end
end

defmodule DummyParser do
  def parse(_) do
    :ok
  end
end
