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
      <div>
        <a href="about/"> about </a>
      </div>

    <a href="https://www.google.com"> external link </a>
    </body>
    """
  end
end
