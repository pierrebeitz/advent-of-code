require Day05

input = System.argv() |> File.read() |> elem(1) |> String.trim
Day05.react(input) |> String.length |> IO.puts()
