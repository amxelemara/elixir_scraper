defmodule SpiderTest do
  use ExUnit.Case
  import TestServer

  setup do
    webserver = {Plug.Cowboy, plug: TestServer, scheme: :http, options: [port: 4000]}
    {:ok, _} = Supervisor.start_link([webserver], strategy: :one_for_one)
    :ok
  end

  test "fetch a web page" do
    url = "localhost:4000"
    {:ok, spider} = Spider.start_link(url)
    {status, resp} = Spider.scrape(spider, "/")
    assert {:ok, 200} == {status , resp.status_code}
  end
  
end
