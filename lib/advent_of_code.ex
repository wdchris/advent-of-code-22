defmodule AdventOfCode do
  def hello do
    :world
  end

  def day_one(part) do
    input = "resources/day_one_input.dat"
    case part do
    1 -> DayOne.get_highest_calories(input, 1)
    2 -> DayOne.get_highest_calories(input, 3)
    end
  end

  def day_two(part) do
    input = "resources/day_two_input.dat"
    case part do
    1 ->
      DayTwo.read_file(input)
      |> DayTwo.get_score(&DayTwo.map_to_rps/1)
    2 ->
      DayTwo.read_file(input)
      |> DayTwo.get_score(&DayTwo.map_to_result/1)
    end
  end

  def day_three(part) do
    input = "resources/day_three_input.dat"
    case part do
    1 ->
      DayThree.read_file(input)
      |> DayThree.get_priority_sum()
    2 ->
      DayThree.read_file(input)
      |> DayThree.get_badge_priority_sum()
    end
  end
end
