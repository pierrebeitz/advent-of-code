coords =
  System.argv()
  |> File.read()
  |> elem(1)
  |> String.split("\n", trim: true)
  |> Day06.parse_coords()

coords
|> Day06.grid_coords()
|> Enum.reduce(0, fn coord, acc ->
  dist = Enum.sum(Enum.map(coords, fn other -> Day06.distance(coord, other) end))
  if dist < 10000, do: 1 + acc, else: acc
end)
|> IO.puts
