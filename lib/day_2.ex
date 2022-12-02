defmodule DayTwo do
  def get_score([head | tail]) do
    score =
      map_to_rps(head)
      |> calculate_score()

    score + get_score(tail)
  end

  def get_score([]), do: 0

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

  defp calculate_score([:rock, :rock]) do 4 end
  defp calculate_score([:rock, :paper]) do 8 end
  defp calculate_score([:rock, :scissors]) do 3 end
  defp calculate_score([:paper, :rock]) do 1 end
  defp calculate_score([:paper, :paper]) do 5 end
  defp calculate_score([:paper, :scissors]) do 9 end
  defp calculate_score([:scissors, :rock]) do 7 end
  defp calculate_score([:scissors, :paper]) do 2 end
  defp calculate_score([:scissors, :scissors]) do 6 end

  def read_file(path) do
    File.read!(path)
    |> String.split("\n")
    |> Enum.map(&String.split/1)
  end
end
