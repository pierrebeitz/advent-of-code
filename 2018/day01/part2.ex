File.stream!(System.argv())
# Loop the device!
|> Stream.cycle()
# Transform to a stream of integers
|> Stream.map(&elem(Integer.parse(&1), 0))
# Transform to a stream carrying along already seen frequencies.
#
#    [
#      {0, #MapSet<[]>},
#      {-12, #MapSet<[0]>},
#      {-18, #MapSet<[-12, 0]>},
#      {-30, #MapSet<[-18, -12, 0]>},
#      ...
#
|> Stream.transform(
  {0, MapSet.new()},
  fn freqChange, {current, seen} ->
    {[{current, seen}], {current + freqChange, MapSet.put(seen, current)}}
  end
)
|> Stream.take_while(fn {frequency, seen} ->
  !MapSet.member?(seen, frequency)
end)
# Take the last entry of the stream, which is the one that carries the duplicate frequency.
|> Enum.at(-1)
|> elem(0)
|> IO.inspect()
