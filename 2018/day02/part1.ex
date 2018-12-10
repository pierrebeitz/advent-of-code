defmodule Part1 do
  def n_same?(string, count),
    do: Enum.any?(group_by_letter_count(string) |> Map.values(), &(&1 == count))

  defp group_by_letter_count(string) do
    Enum.reduce(String.codepoints(string), %{}, fn letter, acc ->
      Map.update(acc, letter, 1, &(&1 + 1))
    end)
  end
end

boxes = System.argv() |> File.read() |> elem(1) |> String.split("\n")

for(a <- boxes, b <- boxes, Part1.n_same?(a, 2), Part1.n_same?(b, 3), do: {a, b})
|> Enum.count()
|> IO.puts()
