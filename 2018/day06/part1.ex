coords =
  System.argv()
  |> File.read()
  |> elem(1)
  |> String.split("\n", trim: true)
  |> Day06.parse_coords()

grid = Day06.grid_coords(coords) |> Enum.reduce(%{}, Day06.to_distance_map(coords))
infinite = Day06.boundary_coords(coords) |> Enum.map(&Map.get(grid, &1)) |> MapSet.new()
finite = MapSet.difference(MapSet.new(coords), infinite)

finite
|> Enum.map(fn coord ->
  occurrences = Map.values(grid) |> Enum.filter(&(&1 == coord)) |> Enum.count()
  {coord, occurrences}
end)
|> Enum.max_by(&elem(&1, 1))
|> elem(1)
|> IO.inspect()
