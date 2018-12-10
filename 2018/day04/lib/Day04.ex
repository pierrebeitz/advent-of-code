defmodule Day04 do
  @doc """
  Reduce the input to a list noting who slept when:

  #  guard from to
  [
    {2657, 25,  52},
    {2657, 57,  59},
    {2711, 33,  51},
    {2711, 54,  56}
  ]
  """
  def to_naps(input) do
    Enum.sort(input)
    |> Enum.map(&parse/1)
    |> Enum.reduce(%{id: nil, sleeps_since: nil, data: []}, &to_naps/2)
    |> Map.get(:data)
  end

  defp to_naps({:change, id}, acc), do: %{acc | id: id}
  defp to_naps({:sleep, at}, acc), do: %{acc | sleeps_since: at}
  defp to_naps({:wake, wakeup}, acc), do: %{acc | data: [{acc.id, acc.sleeps_since, wakeup - 1} | acc.data]}


  @doc """
  Build a map expressing how many times a guard slept to which minute.

  # {guard, min} => times asleep
  %{
    {1,     25}  => 4,
    {1,     26}  => 4,
    {1,     27}  => 5,
    {2,     12}  => 8
  }
  """
  def sleep_stats({id, from, to}, naps) do
    nap_mins = for min <- Range.new(from, to), do: {id, min}

    Enum.reduce(nap_mins, naps, fn {id, minute}, acc ->
      Map.update(acc, {id, minute}, 1, &(&1 + 1))
    end)
  end

  @doc """
  Find the guard that sleeps most.
  """
  def find_sleepy_head(naps) do
    naps
    |> Enum.group_by(fn {id, _, _} -> id end, fn {_, from, to} -> to - from end)
    |> Enum.max_by(fn {_, nap_mins} -> Enum.sum(nap_mins) end)
    |> elem(0)
  end

  defp parse(<<_::binary-size(15), minute::binary-size(2), "] ">> <> rest) do
    case rest do
      "falls asleep" -> {:sleep, String.to_integer(minute)}
      "wakes up" -> {:wake, String.to_integer(minute)}
      guardChange -> {:change, String.to_integer(String.replace(guardChange, ~r/[^\d]/, ""))}
    end
  end
end
