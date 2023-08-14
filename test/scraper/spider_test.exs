defmodule SpiderTest do
  use ExUnit.Case

  setup do
    port = 4016
    url = "localhost:#{port}"
    {:ok, spider} = Spider.start_link(url)
    %{spider: spider}
  end

  test "fetch a web page", %{spider: spider} do
    {status, resp} = Spider.scrape(spider, "/")
    assert {:ok, 200} == {status , resp.status_code}
  end

  test "scrape multiple pages and message", %{spider: spider} do
    paths = ["about/", "shop/", "profile/"]

    results =
      Spider.crawl_async(spider, paths)
      |> Enum.map( &(Task.await(&1)) )

    assert length(results) == 3
    Enum.each(results, fn {status, resp} ->
      assert {:ok, 200} == {status , resp.status_code}
      end
    )
  end
end
