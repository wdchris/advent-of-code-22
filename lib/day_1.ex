defmodule DayOne do
  @input_file "resources/day_one_input.dat"

  def part_one() do
    read_file(@input_file)
    |> get_highest_calories(1)
  end

  def part_two() do
    read_file(@input_file)
    |> get_highest_calories(3)
  end

  def get_highest_calories(elves, no_of_elves) do
    Enum.map(elves, fn input ->
          read_elf(input)
          |> Enum.sum()
        end)
    |> Enum.sort(:desc)
    |> Enum.take(no_of_elves)
    |> Enum.sum()
  end

  defp read_elf(input_str) do
    String.split(input_str, "\n")
    |> Enum.map(&String.to_integer/1)
  end

  def read_file(path) do
    File.read!(path)
    |> String.split("\n\n")
  end
end
