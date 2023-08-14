defmodule ParserTest do
  use ExUnit.Case

  test "parse relative links out of html" do
    html = TestServer.render_page()
    paths = Parser.get_paths(html)
    assert not Enum.member?(paths, "http://www.google.com")
    assert ["about/"] == paths
  end
end
