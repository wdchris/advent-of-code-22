defmodule Day7 do
  defmodule AOCDirectory do
    defstruct [
      :name,
      :path,
      size: 0
    ]

    def root() do
      %{
        "/" => %AOCDirectory{
          name: "/",
          path: "",
        }
      }
    end

    def parent_path(current_dir), do: Regex.replace(~r/\w+\/$/, current_dir, "")

    def change_dir_path(dir_command, current_dir) do
      %{"name" => name } =
        Regex.named_captures(~r/\$ cd (?<name>\w+)/, dir_command)

      current_dir <> name <> "/"
    end

    def add_to_map(dir_command, current_dir, folder_map) do
      %{"name" => name } =
        Regex.named_captures(~r/dir (?<name>\w+)/, dir_command)

      path =
        if String.length(current_dir) <= 1 do current_dir
        else String.trim_trailing(current_dir, "/") end

      Map.put(
        folder_map,
        current_dir <> name,
        %AOCDirectory{
          name: name,
          path: path
      })
    end
  end

  defmodule AOCFile do
    defstruct [
      :name,
      :path,
      size: 0
    ]

    def add_to_map(file_command, current_dir, folder_map) do
      %{"name" => name, "size" => size } =
        Regex.named_captures(~r/(?<size>\d+) (?<name>.+)/, file_command)

      path =
        if String.length(current_dir) <= 1 do current_dir
        else String.trim_trailing(current_dir, "/") end

      Map.put(
        folder_map,
        current_dir <> name,
        %AOCFile{
          name: name,
          path: path,
          size: String.to_integer(size)
      })
    end
  end

  @input_file "resources/day_7_input.dat"

  def part_one(input \\ File.read!(@input_file)) do
    input
    |> setup_directories()
    |> calculate_sum()
  end

  def part_two(input \\ File.read!(@input_file)) do
    input
    |> setup_directories()
    |> find_smallest_directory()
  end

  def setup_directories(input) do
    input
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
    |> create_folder_map("")
    |> set_dir_sizes()
  end

  def create_folder_map(_, _, folder_map \\ AOCDirectory.root())
  def create_folder_map([head | tail], current_dir, folder_map) do
    cond do
      head == "$ cd /" ->
        create_folder_map(tail, "/", folder_map)

      head == "$ cd .." ->
        create_folder_map(tail, AOCDirectory.parent_path(current_dir), folder_map)

      head |> String.starts_with?("$ cd") ->
        create_folder_map(tail, AOCDirectory.change_dir_path(head, current_dir), folder_map)

      head == "$ ls" ->
        create_folder_map(tail, current_dir, folder_map)

      head |> String.starts_with?("dir") ->
        new_map = AOCDirectory.add_to_map(head, current_dir, folder_map)
        create_folder_map(tail, current_dir, new_map)

      true ->
        new_map = AOCFile.add_to_map(head, current_dir, folder_map)
        create_folder_map(tail, current_dir, new_map)
    end
  end

  def create_folder_map([], _, folder_map), do: folder_map

  def set_dir_sizes(folder_map, current_dir \\ "/") do
      new_map =
        folder_map
        |> Map.filter(fn
              {_, %AOCDirectory{path: p}} -> p == current_dir
              _ -> false
            end)
        |> Enum.reduce(folder_map, fn {key, _}, acc ->
              set_dir_sizes(acc, key)
            end)

      size =
        new_map
        |> Map.filter(fn {_, v} -> v.path == current_dir end)
        |> Enum.reduce(0, fn {_, v}, acc -> acc + v.size end)

      {_, new_map} =
        new_map
        |> Map.get_and_update!(current_dir, fn val ->
              {val, %{val | size: size}}
            end)

      new_map
  end

  def calculate_sum(folder_map) do
    folder_map
    |> Map.filter(fn
          {_, %AOCDirectory{size: s}} -> s <= 100000
          _ -> false
        end)
    |> Enum.reduce(0, fn {_, v}, acc -> acc + v.size end)
  end

  def get_space_needed(folder_map) do
    %AOCDirectory{size: size} = Map.get(folder_map, "/")
    30000000 - (70000000 - size)
  end

  def find_smallest_directory(folder_map), do:
    find_smallest_directory(folder_map, get_space_needed(folder_map))

  def find_smallest_directory(folder_map, space_required) do
    {_, dir} =
      folder_map
      |> Map.filter(fn
            {_, %AOCDirectory{size: s}} -> s >= space_required
            _ -> false
          end)
      |> Enum.sort(fn {_, a}, {_, b} -> a.size < b.size end)
      |> Enum.at(0)

    dir.size
  end
end
