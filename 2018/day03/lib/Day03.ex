defmodule Day03 do
  def claims, do: System.argv() |> File.read() |> elem(1) |> String.split("\n", trim: true) |> Enum.map(&Day03.parse_claim/1)

  def parse_claim(line) do
    ["#" <> id, x, y, dx, dy] = String.split(line, [" @ ", ",", ": ", "x"])

    %{
      id: id,
      x: String.to_integer(x),
      y: String.to_integer(y),
      dx: String.to_integer(dx),
      dy: String.to_integer(dy)
    }
  end

  def fabric_stats(claim, claims) do
    for(dx <- Range.new(0, claim.dx - 1), dy <- Range.new(0, claim.dy - 1), do: {dx, dy})
    |> Enum.reduce(claims, fn {dx, dy}, acc ->
      Map.update(acc, {claim.x + dx, claim.y + dy}, 1, &(&1 + 1))
    end)
  end
end
