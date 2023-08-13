defmodule SpiderTest do
  use ExUnit.Case

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

defmodule TestServer do
  @moduledoc """
    A dummy server to test scraping against
    """
  import Plug.Conn
  
  def init(options) do
    options
  end

  def call(conn, _opts) do
    conn
    |> put_resp_content_type("text/plain")
    |> send_resp(200, render_page())
  end

  def render_page() do
    """
    <head>
      <title> Dummy Site </title>
    </head>
    <body>
      <h1> Welcome to dummy site </h1>
    </body>
    """
  end
end
