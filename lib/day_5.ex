defmodule DayFive do
  @input_file "resources/day_five_input.dat"

  def part_one() do
    file = read_file(@input_file)
    #stacks =
      read_starting_stacks(file)

    # todo: read moves, parse (regex) and update stacks
  end

  def part_two() do
  end

  def read_file(path) do
    File.read!(path)
    |> String.split("\n")
    # |> Enum.reduce([], fn line, acc ->
    #     first_char = String.at(line, 0)
    #     case first_char do
    #       "[" -> push_line_to_stack(line, acc)
    #       "m" -> IO.puts("move found")
    #       _ -> IO.puts("nothing found")
    #     end
    #   end)
  end

  def read_starting_stacks(lines) do
    [first_line | tail] =
      lines
      |> Enum.filter(fn e -> String.at(e,0) == "[" end)
      |> Enum.reverse()

    init_stacks =
      first_line
      |> String.graphemes()
      |> Enum.chunk_every(4)
      |> Enum.map(fn _ -> [] end)

    read_starting_stacks([first_line | tail], init_stacks)
  end

  def read_starting_stacks([], stack), do: stack
  def read_starting_stacks([head | tail], stack) do
    read_starting_stacks(
      tail,
      push_line_to_stack(head, stack)
    )
  end

  def push_line_to_stack(line, stack) do
    letters =
      String.graphemes(line)
      |> Enum.chunk_every(4)
      |> Enum.map(&Enum.at(&1,1))

    Enum.zip_with([stack, letters], fn [curr_stack, new_letter] ->
      if String.trim(new_letter) == "", do: curr_stack, else: [new_letter | curr_stack]
    end)
  end
end
