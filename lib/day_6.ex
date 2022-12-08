defmodule DaySix do
  @input_file "resources/day_six_input.dat"

  def part_one(input \\ File.read!(@input_file)) do
    String.graphemes(input)
    |> find_marker_start("", 0, 4)
  end

  def part_two(input \\ File.read!(@input_file)) do
    String.graphemes(input)
    |> find_marker_start("", 0, 14)
  end

  def find_marker_start([head | tail], curr, index, marker_length) do
    if is_start(head <> curr, marker_length) do
      index + 1
    else
      find_marker_start(
        tail,
        head <> String.slice(curr, 0, marker_length - 2),
        index + 1,
        marker_length)
    end
  end

  def is_start(input, length) do
    String.graphemes(input)
    |> MapSet.new()
    |> MapSet.size() == length
  end
end
