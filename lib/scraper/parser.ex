defmodule Parser do
  @doc "Parse the input data"
  @callback  parse(term) :: {:ok, term}
end

defmodule PathParser do
  import Meeseeks.CSS
  @behaviour Parser

  @doc """
  Given a html string returns a list of relative links.
  """
  @impl Parser
  def parse(html) do
    {:ok, get_paths(html)}
  end

  def get_paths(html) do
    html
    |> Meeseeks.parse(:html)
    |> Meeseeks.all(css("a"))
    |> Enum.map(&extract_link/1)
    |> Enum.filter(&is_relative_link/1)
  end

  defp extract_link(link) do
    link
    |> Meeseeks.tree()
    |> elem(1)
    |> List.first()
    |> elem(1)
  end

  defp is_relative_link(link) do
    case URI.parse(link).authority() do
      nil -> true
      _ -> false
    end
  end
end
