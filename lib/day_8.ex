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

  def part_two(input \\ File.read!(@input_file)) do
    matrix = to_matrix(input)

    Matrix.emult(
      scenic_left_right(matrix),
      scenic_top_bottom(matrix))
    |> List.flatten()
    |> Enum.max()
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

  def apply_fun(matrix, dir, fun) do
    matrix
    |> Enum.with_index()
    |> Enum.reduce(Matrix.scale(matrix, 0), fn {row, x},acc ->
        row
        |> reverse_if_needed(dir)
        |> fun.()
        |> Enum.with_index()
        |> Enum.reduce(acc, fn {v, y},m ->
            y = get_y(matrix, y, dir)
            Matrix.set(m, x, y, v)
          end)
    end)
  end

  def reverse_if_needed(row, dir)
    when dir == :right
    when dir == :bottom, do: Enum.reverse(row)
  def reverse_if_needed(row, _), do: row

  def get_y(matrix, y, dir)
    when dir == :right
    when dir == :bottom do
      y_offset = length(hd(matrix)) - 1
      y_offset - y
    end
  def get_y(_, y, _), do: y

  def visible_top_bottom(matrix) do
    visible_left_right(Matrix.transpose(matrix))
    |> Matrix.transpose()
  end

  def visible_left_right(matrix) do
    left = apply_fun(matrix, :left, &find_visible/1)
    right = apply_fun(matrix, :right, &find_visible/1)

    Matrix.add(left, right)
  end

  def find_visible(_, indexes \\ [], curr_max \\ -1)
  def find_visible([], indexes, _), do: Enum.reverse(indexes)
  def find_visible([head | tail], indexes, curr_max) when head <= curr_max, do: find_visible(tail, [0 | indexes], curr_max)
  def find_visible([head | tail], indexes, curr_max) when head > curr_max, do: find_visible(tail, [1 | indexes], head)

  def scenic_top_bottom(matrix) do
    scenic_left_right(Matrix.transpose(matrix))
    |> Matrix.transpose()
  end

  def scenic_left_right(matrix) do
    left = apply_fun(matrix, :left, &find_scenic_score/1)
    right = apply_fun(matrix, :right, &find_scenic_score/1)

    Matrix.emult(left, right)
  end

  def find_scenic_score(row) do
    row
    |> Enum.with_index()
    |> Enum.reduce([], fn {v,y}, acc ->
        to_test =
          Enum.take(row, y)
          |> Enum.reverse()

        [find_scenic_score(to_test, v) | acc]
      end)
    |> Enum.reverse()
  end

  def find_scenic_score(_, _, count \\ 0)
  def find_scenic_score([], _, count), do: count
  def find_scenic_score([head | _], height, count) when head >= height, do: count + 1
  def find_scenic_score([head | tail], height, count) when head < height, do: find_scenic_score(tail, height, count + 1)
end
