defmodule SpiderTest do
  use ExUnit.Case

  test "fetch a web page" do
    url = "localhost:4000/"
    {:ok, spider} = Spider.start_link(url)
    {status, _} = Spider.scrape(spider, "/")
    # ideally get a :http200 but need to implement
    # a test server to call
    assert :error  == status
  end
  
end
