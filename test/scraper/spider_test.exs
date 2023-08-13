defmodule SpiderTest do
  use ExUnit.Case

  test "fetch a web page" do
    url = "localhost:4000/"
    {:ok, spider} = Spider.start_link(url)
    {status, _} = Spider.scrape("/")
    assert :http200  == status
  end
  
end
