ExUnit.start()

port = 4016
webserver = {Plug.Cowboy, plug: TestServer, scheme: :http, options: [port: port]}
{:ok, _} = Supervisor.start_link([webserver], strategy: :one_for_one, name: TestServer)
