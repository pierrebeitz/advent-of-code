defmodule Day07 do
  def parse_line("Step " <> <<dep>> <> " must be finished before step " <> <<subject>> <> " can begin.") do
    {subject, dep}
  end

  def possible_steps(graph), do: for({k, vs} <- graph, vs == [], do: k) |> Enum.sort()

  def to_graph(entries) do
    # We want to have every step in the map.
    graph =
      Enum.concat(for({a, b} <- entries, do: [a, b]))
      |> Enum.map(&{&1, []})
      |> Map.new()

    Enum.reduce(entries, graph, fn {subject, dep}, acc ->
      Map.update(acc, subject, [dep], fn deps -> [dep | deps] end)
    end)
  end

  def graph_without_step(step, graph) do
    Enum.reduce(graph |> Map.delete(step), %{}, fn {step_, deps}, new_graph ->
      Map.put(new_graph, step_, List.delete(deps, step))
    end)
  end

  # PART 1

  def part1(lines) do
    Enum.map(lines, &parse_line/1) |> to_graph |> solve1
  end

  def solve1(graph), do: solve1(graph, possible_steps(graph))
  def solve1(_graph, []), do: ''

  def solve1(graph, [current_step | _]) do
    [current_step] ++ solve1(graph_without_step(current_step, graph))
  end

  # Part 2
  @workers 5
  @delay 60
  def part2(lines), do: Enum.map(lines, &parse_line/1) |> to_graph |> solve2

  def solve2(graph),
    do: solve2(graph, %{waiting: MapSet.new(), running: MapSet.new(), finished: MapSet.new()}, 0)

  def solve2(graph, queue, second) do
    newly_finished = MapSet.new(for({step, ^second} <- queue.running, do: {step, second}))
    still_running = MapSet.difference(queue.running, newly_finished)

    new_graph = Enum.reduce(for({step, _} <- newly_finished, do: step), graph, &graph_without_step/2)

    possible_steps =
      Enum.filter(possible_steps(new_graph), fn e -> !Enum.member?(for({s, _} <- queue.running, do: s), e) end)

    waiting = MapSet.union(queue.waiting, MapSet.new(possible_steps))

    to_start = MapSet.to_list(waiting) |> Enum.sort() |> Enum.take(@workers - Enum.count(still_running)) |> MapSet.new()
    now_running = MapSet.union(still_running, to_start |> Enum.map(&{&1, &1 + second - 64 + @delay}) |> MapSet.new())
    finishing_times = for({_, finishes_at} <- now_running, do: finishes_at)

    if finishing_times == [] do
      second
    else
      solve2(
        new_graph,
        %{
          waiting: MapSet.difference(waiting, to_start),
          running: now_running,
          finished: MapSet.union(queue.finished, newly_finished)
        },
        finishing_times |> Enum.min()
      )
    end
  end
end
