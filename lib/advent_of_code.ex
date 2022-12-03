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
      DayOne.get_highest_calories("resources/day_one_input.dat", 1)
    2 ->
      DayOne.get_highest_calories("resources/day_one_input.dat", 3)
    end
  end

  def day_two(part) do
    case part do
    1 ->
      DayTwo.read_file("resources/day_two_input.dat")
      |> DayTwo.get_score(&DayTwo.map_to_rps/1)
    2 ->
      DayTwo.read_file("resources/day_two_input.dat")
      |> DayTwo.get_score(&DayTwo.map_to_result/1)
    end
  end

  def day_three(part) do
    case part do
    1 ->
      DayThree.read_file("resources/day_three_input.dat")
      |> DayThree.get_priority_sum()
    # 2 ->
    #   DayTwo.read_file("resources/day_two_input.dat")
    #   |> DayTwo.get_score(&DayTwo.map_to_result/1)
    end
  end
end
