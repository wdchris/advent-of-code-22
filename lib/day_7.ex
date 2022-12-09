defmodule Day7 do
  defmodule Directory do
    defstruct [
      :name,
      :path
    ]

    def root() do
      %{
        "/" => %Directory{
          name: "/",
          path: "",
        }
      }
    end
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

  def create_folder_map(_, _, folder_map \\ Directory.root())
  def create_folder_map([head | tail], current_dir, folder_map) do
    cond do
      head == "$ cd /" ->
        create_folder_map(tail, "/", folder_map)

      head == "$ cd .." ->
        create_folder_map(
          tail,
          Regex.replace(~r/\w\/$/, current_dir, ""),
          folder_map
        )

      head |> String.starts_with?("$ cd") ->
        create_folder_map(tail, change_dir(head, current_dir), folder_map)

      head == "$ ls" ->
        create_folder_map(tail, current_dir, folder_map)

      head |> String.starts_with?("dir") ->
        new_map = add_dir(head, current_dir, folder_map)
        create_folder_map(tail, current_dir, new_map)
    end
  end

  def create_folder_map([], _, folder_map), do: folder_map

  def change_dir(head, current_dir) do
    %{"name" => name } =
      Regex.named_captures(~r/\$ cd (?<name>\w+)/, head)

    current_dir <> name <> "/"
  end

  def add_dir(head, current_dir, folder_map) do
    %{"name" => name } =
      Regex.named_captures(~r/dir (?<name>\w+)/, head)

    path =
      if String.length(current_dir) <= 1 do current_dir
      else String.trim_trailing(current_dir, "/") end

    Map.put(
      folder_map,
      current_dir <> name,
      %Directory{
        name: name,
        path: path
    })
  end
end
