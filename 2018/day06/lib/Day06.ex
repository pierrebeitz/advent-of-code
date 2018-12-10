defmodule Day06 do
  def distance({x, y}, {a, b}), do: abs(a - x) + abs(b - y)

  def parse_coords(lines) do
    Enum.map(lines, &String.split(&1, ", "))
    |> Enum.map(fn [x, y] -> {String.to_integer(x), String.to_integer(y)} end)
  end

  def to_distance_map(coords) do
    fn coord, map ->
      distances = for(other <- coords, do: {Day06.distance(other, coord), other})
      {min_dist, min_coord} = Enum.min_by(distances, &elem(&1, 0))

      isDot = Enum.count(Enum.filter(distances, &(elem(&1, 0) == min_dist))) > 1
      Map.put(map, coord, if(isDot, do: nil, else: min_coord))
    end
  end

  def mins_and_maxs(coords) do
    {xs, ys} = {Enum.map(coords, &elem(&1, 0)), Enum.map(coords, &elem(&1, 1))}

    {
      %{min: Enum.min(xs), max: Enum.max(xs)},
      %{min: Enum.min(ys), max: Enum.max(ys)}
    }
  end

  def boundary_coords(coords) do
    {x, y} = mins_and_maxs(coords)

    for(
      i <- x.min..x.max,
      j <- y.min..y.max,
      i == x.min || i == x.max || j == y.min || j == y.max,
      do: {i, j}
    )
  end

  def grid_coords(coords) do
    {x, y} = mins_and_maxs(coords)
    for(i <- x.min..x.max, j <- y.min..y.max, do: {i, j})
  end
end
