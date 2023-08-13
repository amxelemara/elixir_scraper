defmodule SpiderTest do
  use ExUnit.Case

  test "fetch a web page" do
    url = "localhost:4000/"
    assert :http200  == elem(Spider.get(url), 0)
  end
  
end
