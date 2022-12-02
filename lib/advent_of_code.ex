defmodule AdventOfCode do
  @moduledoc """
  Documentation for `AdventOfCode`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> AdventOfCode.hello()
      :world

  """
  def hello do
    :world
  end

  def day_one(part) do
    case part do
    1 ->
      DayOne.execute("resources/day_one_input.dat", 1)
    2 ->
      DayOne.execute("resources/day_one_input.dat", 3)
    end
  end
end
