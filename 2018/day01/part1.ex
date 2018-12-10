IO.puts File.stream!(System.argv())
  |> Stream.map(&(elem(Integer.parse(&1), 0)))
  |> Enum.sum
