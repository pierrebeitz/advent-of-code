lines = System.argv() |> File.read() |> elem(1) |> String.split("\n", trim: true)
lines |> Day07.part1() |> IO.puts()
