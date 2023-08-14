defmodule TestServer do
  @moduledoc """
    A dummy server to test scraping against
    """
  use Plug.Router
  plug :match
  plug :dispatch
  
  get "/" do
    send_resp(conn, 200, render_page() )
  end

  get "about/" do
    send_resp(conn, 200, render_page())
  end

  get "shop/" do
    send_resp(conn, 200, render_page() )
  end

  get "profile/" do
    send_resp(conn, 200, render_page() )
  end

  match _ do
    send_resp(conn, 404, "not found")
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
