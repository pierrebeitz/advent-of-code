require Day03

Day03.claims()
|> Enum.reduce(%{}, &Day03.fabric_stats/2) # build a map of how many claims there are on each square inch
|> Enum.count(fn {_, v} -> v > 1 end)      # count how many fields have more than one claim
|> IO.puts()
