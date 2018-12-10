require Day05

input = System.argv() |> File.read() |> elem(1) |> String.trim()

for(n <- ?a..?z, do: <<n::utf8>>)
|> Enum.map(fn letter ->
  i = String.replace(input, letter, "")
  i = String.replace(i, String.upcase(letter), "")

  {letter, String.length Day05.react(i)}
end)
|> Enum.min_by(&(elem(&1, 1)))
|> elem(1)
|> IO.puts()
