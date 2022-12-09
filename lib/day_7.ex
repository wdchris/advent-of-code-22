defmodule Day7 do
  defmodule Directory do
    defstruct [
      :name,
      :path
    ]
  end

  defmodule File do
    defstruct [
      :name,
      :path,
      :parent,
      size: 0
    ]
  end

  @input_file "resources/day_7_input.dat"

  def part_one(input \\ File.read!(@input_file)) do

  end

  def create_folder_map([], folder_map, _), do: folder_map
  def create_folder_map([head | tail], folder_map, current_dir) do
    cond do
      head == "$ cd /" -> create_folder_map(tail, folder_map, "/")
      head == "$ ls" -> create_folder_map(tail, folder_map, current_dir)
      String.starts_with?(head, "dir") ->
        %{"name" => name } = Regex.named_captures(~r/dir (?<name>\w+)/, head)
        updated_map =
          Map.put(
            folder_map,
            current_dir <> name,
            %Directory{
              name: name,
              path: current_dir
          })
        create_folder_map(tail, updated_map, current_dir)
    end
  end
end
