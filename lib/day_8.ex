defmodule Day8 do
  @input_file "resources/day_8_input.dat"

  def part_one(input \\ File.read!(@input_file)) do
    matrix = to_matrix(input)

    Matrix.add(
      visible_left_right(matrix),
      visible_top_bottom(matrix))
    |> List.flatten()
    |> Enum.count(fn x -> x > 0 end)
  end

  def to_matrix(input) do
    lines = String.split(input, "\n")
    {rows, cols} = {length(lines), String.length(hd(lines))}

    lines
    |> Enum.map(&to_matrix_row/1)
    |> Enum.with_index()
    |> Enum.flat_map(fn {row, x} -> Enum.map(row, fn {el, y} -> {x, y, el} end) end)
    |> Enum.reduce(Matrix.new(rows, cols), fn coord, acc ->
        {x, y, v} = coord
        Matrix.set(acc, x, y, v)
      end)
  end

  def to_matrix_row(line) do
    line
    |> String.trim()
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
    |> Enum.with_index()
  end

  def visible_top_bottom(matrix) do
    visible_left_right(Matrix.transpose(matrix))
    |> Matrix.transpose()
  end

  def visible_left_right(matrix) do
    y_offset = length(hd(matrix)) - 1

    left = visible(matrix, :left, fn y -> y end)
    right = visible(matrix, :right, fn y -> y_offset - y end)

    Matrix.add(left, right)
  end

  def visible(matrix, dir, y_func) do
    matrix
    |> Enum.with_index()
    |> Enum.reduce(Matrix.scale(matrix, 0), fn {row, x},acc ->
        row
        |> reverse_if_needed(dir)
        |> find_visible()
        |> Enum.reduce(acc, fn y,m -> Matrix.set(m, x, y_func.(y), 1) end)
    end)
  end

  def reverse_if_needed(row, dir)
    when dir == :right
    when dir == :bottom, do: Enum.reverse(row)
  def reverse_if_needed(row, _), do: row

  def find_visible(_, indexes \\ [], curr_index \\ 0, curr_max \\ -1)
  def find_visible([], indexes, _, _), do: indexes
  def find_visible([head | tail], indexes, curr_index, curr_max) when head <= curr_max,
    do: find_visible(tail, indexes, curr_index + 1, curr_max)
  def find_visible([head | tail], indexes, curr_index, curr_max) when head > curr_max,
    do: find_visible(tail, [curr_index | indexes], curr_index + 1, head)
end
