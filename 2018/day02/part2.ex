defmodule Part2 do
  def differ_by_one_char(<<a>> <> rest1, <<a>> <> rest2), do: differ_by_one_char(rest1, rest2)
  def differ_by_one_char(<<_>> <> rest,  <<_>> <> rest),  do: true
  def differ_by_one_char(_, _), do: false

  def without_differing_chars(<<a>> <> rest1, <<a>> <> rest2), do: <<a>> <> without_differing_chars(rest1, rest2)
  def without_differing_chars(<<_>> <> rest1, <<_>> <> rest2), do:          without_differing_chars(rest1, rest2)
  def without_differing_chars(_, _), do: ""
end

boxes = System.argv() |> File.read() |> elem(1) |> String.split("\n")
[ {box1, box2} | _ ] = (for a <- boxes, b <- boxes, Part2.differ_by_one_char(a, b), do: {a, b})
IO.puts Part2.without_differing_chars(box1, box2)
