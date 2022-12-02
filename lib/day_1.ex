defmodule DayOne do
  def execute(path, no_of_elves) do
    read_elves(path)
    |> Enum.map(fn input ->
          read_elf(input)
          |> Enum.sum()
        end)
    |> Enum.sort(:desc)
    |> Enum.take(no_of_elves)
    |> Enum.sum()
  end

  defp read_elves(path) do
    File.read!(path)
    |> String.split("\n\n")
  end

  defp read_elf(input_str) do
    String.split(input_str, "\n")
    |> Enum.map(&String.to_integer/1)
  end
end
