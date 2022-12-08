defmodule DayFour do
  @input_file "resources/day_4_input.dat"

  def part_one() do
    read_file(@input_file)
    |> count_ranges_with(&contains_range/2)
  end

  def part_two() do
    read_file(@input_file)
    |> count_ranges_with(&overlaps/2)
  end

  def count_ranges_with(ranges, f) do
    ranges
    |> Enum.map(&line_to_tuples/1)
    |> Enum.count(fn p ->
        left = Enum.at(p, 0)
        right = Enum.at(p, 1)

        f.(left, right) ||
        f.(right, left)
      end)
  end

  def contains_range(container, range) do
    elem(range,0) >= elem(container,0) &&
    elem(range,1) <= elem(container,1)
  end

  def overlaps(container, range) do
    elem(range,0) >= elem(container,0) &&
    elem(range,0) <= elem(container,1)
  end

  def line_to_tuples(line) do
    String.split(line, ",")
    |> Enum.map(fn pair ->
        numbers = String.split(pair, "-")
        {first, _} = Integer.parse(Enum.at(numbers, 0))
        {second, _} = Integer.parse(Enum.at(numbers, 1))

        {first,second}
      end)
  end

  def read_file(path) do
    File.read!(path)
    |> String.split("\n")
  end
end
