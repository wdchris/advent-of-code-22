defmodule AdventOfCode do
  def day_one(part) do
    with input <- "resources/day_one_input.dat" do
      case part do
        1 -> DayOne.get_highest_calories(input, 1)
        2 -> DayOne.get_highest_calories(input, 3)
      end
    end
  end

  def day_two(part) do
    with input <- DayTwo.read_file("resources/day_two_input.dat") do
      case part do
        1 -> DayTwo.get_score(input, &DayTwo.map_to_rps/1)
        2 -> DayTwo.get_score(input, &DayTwo.map_to_result/1)
      end
    end
  end

  def day_three(part) do
    with input <- DayThree.read_file("resources/day_three_input.dat") do
      case part do
        1 -> DayThree.get_priority_sum(input)
        2 -> DayThree.get_badge_priority_sum(input)
      end
    end
  end

  def day_four(part) do
    with input <- DayFour.read_file("resources/day_four_input.dat") do
      case part do
        1 -> DayFour.calculate(input, &DayFour.contains_range/2)
        2 -> DayFour.calculate(input, &DayFour.overlaps/2)
      end
    end
  end
end
