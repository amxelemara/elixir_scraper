defmodule ParserTest do
  use ExUnit.Case

  test "parse relative links out of html" do
    html = TestServer.render_page()
    {:ok, paths} = PathParser.parse(html)
    assert not Enum.member?(paths, "http://www.google.com")
    assert ["about/"] == paths
  end

  test "implement a parser behaviour" do
    defmodule TestParser do
      @behaviour Parser

      @impl Parser
      def parse(_) do
        {:ok, :test}
      end
    end

    html = TestServer.render_page()
    assert {:ok, :test} = TestParser.parse(html)
  end
end
