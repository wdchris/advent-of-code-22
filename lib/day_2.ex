defmodule DayTwo do
  @input_file "resources/day_2_input.dat"

  def part_one() do
    read_file(@input_file)
    |> get_score(&map_to_rps/1)
  end

  def part_two() do
    read_file(@input_file)
    |> get_score(&map_to_result/1)
  end

  def get_score([head | tail], f) do
    score =
      f.(head)
      |> calculate_score()

    score + get_score(tail, f)
  end

  def get_score([], _), do: 0

  def map_to_rps([player, us]) do
    one = case player do
      "A" -> :rock
      "B" -> :paper
      "C" -> :scissors
    end

    two = case us do
      "X" -> :rock
      "Y" -> :paper
      "Z" -> :scissors
    end

    [one, two]
  end

  def map_to_result([player, us]) do
    one = case player do
      "A" -> :rock
      "B" -> :paper
      "C" -> :scissors
    end

    two = case us do
      "X" -> result_for_loss(one)
      "Y" -> result_for_draw(one)
      "Z" -> result_for_win(one)
    end

    [one, two]
  end

  defp result_for_draw(:rock), do: :rock
  defp result_for_draw(:paper), do: :paper
  defp result_for_draw(:scissors), do: :scissors

  defp result_for_loss(:rock), do: :scissors
  defp result_for_loss(:paper), do: :rock
  defp result_for_loss(:scissors), do: :paper

  defp result_for_win(:rock), do: :paper
  defp result_for_win(:paper), do: :scissors
  defp result_for_win(:scissors), do: :rock


  defp calculate_score([:rock, :rock]), do: 4
  defp calculate_score([:rock, :paper]), do: 8
  defp calculate_score([:rock, :scissors]), do: 3
  defp calculate_score([:paper, :rock]), do: 1
  defp calculate_score([:paper, :paper]), do: 5
  defp calculate_score([:paper, :scissors]), do: 9
  defp calculate_score([:scissors, :rock]), do: 7
  defp calculate_score([:scissors, :paper]), do: 2
  defp calculate_score([:scissors, :scissors]), do: 6

  def read_file(path) do
    File.read!(path)
    |> String.split("\n")
    |> Enum.map(&String.split/1)
  end
end
