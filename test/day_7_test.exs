defmodule DaySevenTest do
  use ExUnit.Case

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

      input_map = %{
        "/" => %Day7.Directory{
          name: "/",
          path: "",
        }
      }

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

      assert Day7.create_folder_map(input, input_map, "") == result
    end

    # test "adds nested directories" do
    #   input = [
    #     "$ cd /",
    #     "$ ls",
    #     "dir a",
    #     "$ cd a",
    #     "$ ls",
    #     "dir e"
    #   ]

    #   input_map = %{
    #     "/" => %Day7.Directory{
    #       name: "/",
    #       path: "",
    #     }
    #   }

    #   result = %{
    #     "/" => %Day7.Directory{
    #       name: "/",
    #       path: "",
    #     },
    #     "/a" => %Day7.Directory{
    #       name: "a",
    #       path: "/",
    #     }
    #   }

    #   assert Day7.create_folder_map(input, input_map, "") == result
    # end
  end
end
