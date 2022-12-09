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
  end

  defmodule AOCFile do
    defstruct [
      :name,
      :path,
      size: 0
    ]
  end

  @input_file "resources/day_7_input.dat"

  def part_one(input \\ File.read!(@input_file)) do
    input
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
    |> create_folder_map("")
    |> set_dir_sizes()
    |> calculate_sum()
  end

  def create_folder_map(_, _, folder_map \\ AOCDirectory.root())
  def create_folder_map([head | tail], current_dir, folder_map) do
    cond do
      head == "$ cd /" ->
        create_folder_map(tail, "/", folder_map)

      head == "$ cd .." ->
        create_folder_map(
          tail,
          Regex.replace(~r/\w+\/$/, current_dir, ""),
          folder_map
        )

      head |> String.starts_with?("$ cd") ->
        create_folder_map(tail, change_dir(head, current_dir), folder_map)

      head == "$ ls" ->
        create_folder_map(tail, current_dir, folder_map)

      head |> String.starts_with?("dir") ->
        new_map = add_dir(head, current_dir, folder_map)
        create_folder_map(tail, current_dir, new_map)

      true ->
        new_map = add_file(head, current_dir, folder_map)
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
      %AOCDirectory{
        name: name,
        path: path
    })
  end

  def add_file(head, current_dir, folder_map) do
    %{"name" => name, "size" => size } =
      Regex.named_captures(~r/(?<size>\d+) (?<name>.+)/, head)

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
end
