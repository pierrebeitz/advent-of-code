require Day03

fabric_map = Day03.claims() |> Enum.reduce(%{}, &Day03.fabric_stats/2)

Enum.find(Day03.claims(), fn c ->
  for(
    dx <- Range.new(c.x, c.x + c.dx - 1),
    dy <- Range.new(c.y, c.y + c.dy - 1),
    do: {dx, dy}
  )
  |> Enum.all?(&(fabric_map[&1] == 1))
end).id
|> IO.puts()
