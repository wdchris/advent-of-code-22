defmodule DaySix do
  @input_file "resources/day_six_input.dat"

  def part_one() do
    File.read!(@input_file)
    |> find_start_packet()
  end

  def find_start_packet(input) do
    String.graphemes(input)
    |> find_start_packet("",0)
  end

  def find_start_packet([head | tail], curr, index) do
    if is_start_of_packet(head <> curr) do
      index + 1
    else
      find_start_packet(tail, head <> String.slice(curr,0,2), index + 1)
    end
  end

  def is_start_of_packet(input) do
    String.graphemes(input)
    |> MapSet.new()
    |> MapSet.size() == 4
  end
end
