lines = System.argv() |> File.read() |> elem(1) |> String.split("\n", trim: true)
lines |> Day07.part2() |> IO.inspect()
