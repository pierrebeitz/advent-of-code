defmodule Part2 do
  @doc """
  Removes the `i`th index from all the strings of `input` and checks whether there are equal strings now.
  If no equal strings can be be found the next index is tried.
  """
  def solve(input, i) do
    result =
      Enum.map(input, &List.delete_at(String.codepoints(&1), i))
      |> Enum.sort()
      |> (&Enum.zip(&1, ["" | &1])).()
      |> Enum.find(fn {a, b} -> a == b end)

    if result, do: elem(result, 0), else: solve(input, i + 1)
  end
end

System.argv() |> File.read() |> elem(1) |> String.split("\n") |> Part2.solve(0) |> IO.puts()
