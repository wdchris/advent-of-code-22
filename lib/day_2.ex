defmodule DayTwo do
  def get_score_by_rps([head | tail]) do
    score =
      map_to_rps(head)
      |> calculate_score()

    score + get_score_by_rps(tail)
  end

  def get_score_by_rps([]), do: 0

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

  def get_score_by_result([head | tail]) do
    score =
      map_to_result(head)
      |> calculate_score()

    score + get_score_by_result(tail)
  end

  def get_score_by_result([]), do: 0

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
