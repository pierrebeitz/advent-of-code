require Day04

naps = System.argv() |> File.read() |> elem(1) |> String.split("\n", trim: true) |> Day04.to_naps()
sleeper = Day04.find_sleepy_head(naps)

naps
|> Enum.reduce(%{}, &Day04.sleep_stats/2)
|> Enum.filter(fn {{id, _}, _} -> id == sleeper end)
|> Enum.max_by(fn {{_, _}, nap_mins} -> nap_mins end)
|> (fn {{id, min}, _} -> id * min end).()
|> IO.puts()
