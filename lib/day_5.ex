defmodule DayFive do
  @input_file "resources/day_five_input.dat"

  def part_one() do
    with file <- read_file(@input_file),
          stacks <- read_starting_stacks(file)
    do
       make_moves(file, stacks)
       |> read_top_crates()
    end
  end

  def part_two() do
  end

  def read_file(path) do
    File.read!(path)
    |> String.split("\n")
  end

  def read_starting_stacks(lines) do
    [first_line | tail] =
      lines
      |> Enum.filter(&String.contains?(&1,"["))
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

  def make_moves(lines, init_stacks) do
    lines
    |> Enum.map(&get_move/1)
    |> Enum.reject(&is_nil/1)
    |> Enum.reduce(init_stacks, &make_move/2)
  end

  def make_move(move, stacks) do
    {to_move, to_keep} =
      Enum.at(stacks, move.from - 1)
      |> Enum.split(move.count)

    new_stack =
      Enum.concat(
        Enum.reverse(to_move),
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
    |> Enum.reduce("", fn e, a -> a <> List.first(e, "") end)
  end
end
