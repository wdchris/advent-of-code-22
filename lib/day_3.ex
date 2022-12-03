defmodule DayThree do
  def get_priority_sum([head | tail]) do
    score =
      find_incorrect_item(head)
      |> convert_char_to_number()

    score + get_priority_sum(tail)
  end

  def get_priority_sum([]), do: 0

  def find_incorrect_item(rucksack) do
    compartment_size = trunc(String.length(rucksack) / 2)

    {lower, upper} =
      String.split_at(rucksack, compartment_size)
      |> Tuple.to_list()
      |> Enum.reduce(fn (a,b) ->
        {
          MapSet.new(String.graphemes(a)),
          MapSet.new(String.graphemes(b))
        }
      end)

    [item | _] =
      MapSet.intersection(lower, upper)
      |> MapSet.to_list()

    item
  end

  def get_badge_priority_sum(rucksacks) do
    rucksacks
    |> Enum.chunk_every(3)
    |> Enum.map(fn [a, b, c] ->
        get_badge(a, b, c)
        |> convert_char_to_number()
      end)
    |> Enum.sum()
  end

  def get_badge(a, b, c) do
    [item | _] =
      MapSet.intersection(
        MapSet.new(String.graphemes(a)),
        MapSet.new(String.graphemes(b)))
      |> MapSet.intersection(
        MapSet.new(String.graphemes(c)))
      |> MapSet.to_list()

    item
  end

  def convert_char_to_number(char) do
      char
      |> String.to_charlist
      |> hd
      |> downcast_codepoint()
  end

  def downcast_codepoint(char) when char <= 90, do: char - 38
  def downcast_codepoint(char) when char > 90, do: char - 96

  def read_file(path) do
    File.read!(path)
    |> String.split("\n")
  end
end
