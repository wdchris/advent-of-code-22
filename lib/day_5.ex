defmodule DayFive do
  @input_file "resources/day_5_input.dat"

  def part_one() do
    with file <- read_file(@input_file),
          stacks <- read_starting_stacks(file)
    do
      make_moves(file, stacks, true)
      |> read_top_crates()
    end
  end

  def part_two() do
    with file <- read_file(@input_file),
          stacks <- read_starting_stacks(file)
    do
      make_moves(file, stacks, false)
      |> read_top_crates()
    end
  end

  def read_file(path) do
    File.read!(path)
    |> String.split("\n")
  end

  def read_starting_stacks(lines) do
    stack_lines =
      lines
      |> Enum.filter(&String.contains?(&1,"["))
      |> Enum.reverse()

    init_stacks =
      List.first(stack_lines)
      |> String.graphemes()
      |> Enum.chunk_every(4)
      |> Enum.map(fn _ -> [] end)

    stack_lines
    |> Enum.reduce(init_stacks, &push_line_to_stack/2)
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

  def make_moves(lines, init_stacks, reverse) do
    lines
    |> Enum.map(&get_move/1)
    |> Enum.reject(&is_nil/1)
    |> Enum.reduce(init_stacks, &make_move(&1,&2,reverse))
  end

  def make_move(move, stacks, reverse) do
    {to_move, to_keep} =
      Enum.at(stacks, move.from - 1)
      |> Enum.split(move.count)

    to_move =
      if reverse do Enum.reverse(to_move)
      else to_move end

    new_stack =
      Enum.concat(
        to_move,
        Enum.at(stacks, move.to - 1))

    stacks
    |> List.replace_at(move.to - 1, new_stack)
    |> List.replace_at(move.from - 1, to_keep)
  end

  def get_move(line) do
    with %{"count" => c, "from" => f, "to" => t } <-
        Regex.named_captures(
          ~r/move (?<count>\d+) from (?<from>\d+) to (?<to>\d+)/,
          line)
      do
        %{
          count: String.to_integer(c),
          from: String.to_integer(f),
          to: String.to_integer(t)
        }
      else
        _ -> nil
      end
  end

  def read_top_crates(stacks) do
    stacks
    |> Enum.reduce("", fn stack, acc -> acc <> List.first(stack, "") end)
  end
end
