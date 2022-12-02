defmodule DayTwo do
  def get_score(path) do
    read_file(path)
    |> Enum.map(&calculate_score/1)
    |> Enum.sum()
  end

  # a / x = rock        1
  # b / y = paper       2
  # c / z = scissors    3

  defp calculate_score(["A", "X"]) do 4 end
  defp calculate_score(["A", "Y"]) do 8 end
  defp calculate_score(["A", "Z"]) do 3 end
  defp calculate_score(["B", "X"]) do 1 end
  defp calculate_score(["B", "Y"]) do 5 end
  defp calculate_score(["B", "Z"]) do 9 end
  defp calculate_score(["C", "X"]) do 7 end
  defp calculate_score(["C", "Y"]) do 2 end
  defp calculate_score(["C", "Z"]) do 6 end


  defp read_file(path) do
    File.read!(path)
    |> String.split("\n")
    |> Enum.map(&String.split/1)
  end
end
