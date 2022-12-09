defmodule DaySevenTest do
  use ExUnit.Case

  @tag :skip
  describe "part_one" do
    test "sums up dirs <= 100000 correctly" do
      input =
        "$ cd /
        $ ls
        dir a
        14848514 b.txt
        8504156 c.dat
        dir d
        $ cd a
        $ ls
        dir e
        29116 f
        2557 g
        62596 h.lst
        $ cd e
        $ ls
        584 i
        $ cd ..
        $ cd ..
        $ cd d
        $ ls
        4060174 j
        8033020 d.log
        5626152 d.ext
        7214296 k"

        assert Day7.part_one(input) == 95437
    end
  end

  describe "create_folder_map" do
    test "adds a directory" do
      input = [
        "$ cd /",
        "$ ls",
        "dir a"
      ]

      result = %{
        "/" => %Day7.Directory{
          name: "/",
          path: "",
        },
        "/a" => %Day7.Directory{
          name: "a",
          path: "/",
        }
      }

      assert Day7.create_folder_map(input, "") == result
    end

    test "adds nested directories" do
      input = [
        "$ cd /",
        "$ ls",
        "dir a",
        "$ cd a",
        "$ ls",
        "dir e"
      ]

      result = %{
        "/" => %Day7.Directory{
          name: "/",
          path: "",
        },
        "/a" => %Day7.Directory{
          name: "a",
          path: "/",
        },
        "/a/e" => %Day7.Directory{
          name: "e",
          path: "/a",
        }
      }

      assert Day7.create_folder_map(input, "") == result
    end

    test "adds mutiple nested directories" do
      input = [
        "$ cd /",
        "$ ls",
        "dir a",
        "dir b",
        "$ cd a",
        "$ ls",
        "dir e",
        "$ cd ..",
        "$ cd b",
        "$ ls",
        "dir f"
      ]

      result = %{
        "/" => %Day7.Directory{
          name: "/",
          path: "",
        },
        "/a" => %Day7.Directory{
          name: "a",
          path: "/",
        },
        "/b" => %Day7.Directory{
          name: "b",
          path: "/",
        },
        "/a/e" => %Day7.Directory{
          name: "e",
          path: "/a",
        },
        "/b/f" => %Day7.Directory{
          name: "f",
          path: "/b",
        }
      }

      assert Day7.create_folder_map(input, "") == result
    end
  end
end
