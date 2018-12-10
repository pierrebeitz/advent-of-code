defmodule Day05 do
  # ! reverses the polymer !
  def react(<<p>> <> prefix , <<s>> <> suffix) do
    new_prefix = if abs(p - s) == 32, do: prefix, else: <<s, p>> <> prefix
    react(new_prefix, suffix)
  end

  def react(_, <<s>> <> suffix), do: react(<<s>>, suffix)
  def react(prefix, ""), do: prefix
  def react(string), do: react("", string)
end
