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

  describe "part_two" do
    test "finds the smallest dir to delete" do
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

        assert Day7.part_two(input) == 24933642
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
        "/" => %Day7.AOCDirectory{
          name: "/",
          path: "",
        },
        "/a" => %Day7.AOCDirectory{
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
        "/" => %Day7.AOCDirectory{
          name: "/",
          path: "",
        },
        "/a" => %Day7.AOCDirectory{
          name: "a",
          path: "/",
        },
        "/a/e" => %Day7.AOCDirectory{
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
        "/" => %Day7.AOCDirectory{
          name: "/",
          path: "",
        },
        "/a" => %Day7.AOCDirectory{
          name: "a",
          path: "/",
        },
        "/b" => %Day7.AOCDirectory{
          name: "b",
          path: "/",
        },
        "/a/e" => %Day7.AOCDirectory{
          name: "e",
          path: "/a",
        },
        "/b/f" => %Day7.AOCDirectory{
          name: "f",
          path: "/b",
        }
      }

      assert Day7.create_folder_map(input, "") == result
    end

    test "handles mutiple cd .. commands" do
      input = [
        "$ cd /",
        "$ ls",
        "dir a",
        "dir b",
        "$ cd a",
        "$ ls",
        "dir e",
        "$ cd e",
        "$ ls",
        "$ cd ..",
        "$ cd ..",
        "$ cd b",
        "$ ls",
        "dir f"
      ]

      result = %{
        "/" => %Day7.AOCDirectory{
          name: "/",
          path: "",
        },
        "/a" => %Day7.AOCDirectory{
          name: "a",
          path: "/",
        },
        "/b" => %Day7.AOCDirectory{
          name: "b",
          path: "/",
        },
        "/a/e" => %Day7.AOCDirectory{
          name: "e",
          path: "/a",
        },
        "/b/f" => %Day7.AOCDirectory{
          name: "f",
          path: "/b",
        }
      }

      assert Day7.create_folder_map(input, "") == result
    end

    test "adds a file" do
      input = [
        "$ cd /",
        "$ ls",
        "4060174 j"
      ]

      result = %{
        "/" => %Day7.AOCDirectory{
          name: "/",
          path: "",
        },
        "/j" => %Day7.AOCFile{
          name: "j",
          path: "/",
          size: 4060174
        }
      }

      assert Day7.create_folder_map(input, "") == result
    end

    test "adds mutiple nested files" do
      input = [
        "$ cd /",
        "$ ls",
        "dir a",
        "dir b",
        "123 x",
        "$ cd a",
        "$ ls",
        "dir e",
        "$ cd ..",
        "$ cd b",
        "$ ls",
        "dir f",
        "456 y"
      ]

      result = %{
        "/" => %Day7.AOCDirectory{
          name: "/",
          path: "",
        },
        "/a" => %Day7.AOCDirectory{
          name: "a",
          path: "/",
        },
        "/b" => %Day7.AOCDirectory{
          name: "b",
          path: "/",
        },
        "/x" => %Day7.AOCFile{
          name: "x",
          path: "/",
          size: 123
        },
        "/a/e" => %Day7.AOCDirectory{
          name: "e",
          path: "/a",
        },
        "/b/f" => %Day7.AOCDirectory{
          name: "f",
          path: "/b",
        },
        "/b/y" => %Day7.AOCFile{
          name: "y",
          path: "/b",
          size: 456
        }
      }

      assert Day7.create_folder_map(input, "") == result
    end

    test "parses aoc input" do
      input = [
        "$ cd /",
        "$ ls",
        "dir a",
        "14848514 b.txt",
        "8504156 c.dat",
        "dir d",
        "$ cd a",
        "$ ls",
        "dir e",
        "29116 f",
        "2557 g",
        "62596 h.lst",
        "$ cd e",
        "$ ls",
        "584 i",
        "$ cd ..",
        "$ cd ..",
        "$ cd d",
        "$ ls",
        "4060174 j",
        "8033020 d.log",
        "5626152 d.ext",
        "7214296 k"
      ]

      result = %{
        "/" => %Day7.AOCDirectory{
          name: "/",
          path: "",
        },
        "/a" => %Day7.AOCDirectory{
          name: "a",
          path: "/",
        },
        "/a/e" => %Day7.AOCDirectory{
          name: "e",
          path: "/a",
        },
        "/a/e/i" => %Day7.AOCFile{
          name: "i",
          path: "/a/e",
          size: 584
        },
        "/a/f" => %Day7.AOCFile{
          name: "f",
          path: "/a",
          size: 29116
        },
        "/a/g" => %Day7.AOCFile{
          name: "g",
          path: "/a",
          size: 2557
        },
        "/a/h.lst" => %Day7.AOCFile{
          name: "h.lst",
          path: "/a",
          size: 62596
        },
        "/b.txt" => %Day7.AOCFile{
          name: "b.txt",
          path: "/",
          size: 14848514
        },
        "/c.dat" => %Day7.AOCFile{
          name: "c.dat",
          path: "/",
          size: 8504156
        },
        "/d" => %Day7.AOCDirectory{
          name: "d",
          path: "/",
        },
        "/d/j" => %Day7.AOCFile{
          name: "j",
          path: "/d",
          size: 4060174
        },
        "/d/d.log" => %Day7.AOCFile{
          name: "d.log",
          path: "/d",
          size: 8033020
        },
        "/d/d.ext" => %Day7.AOCFile{
          name: "d.ext",
          path: "/d",
          size: 5626152
        },
        "/d/k" => %Day7.AOCFile{
          name: "k",
          path: "/d",
          size: 7214296
        },
      }

      assert Day7.create_folder_map(input, "") == result
    end
  end

  describe "set_dir_sizes" do
    test "gets a root dir size" do
      input = %{
        "/" => %Day7.AOCDirectory{
          name: "/",
          path: "",
        },
        "/x" => %Day7.AOCFile{
          name: "x",
          path: "/",
          size: 10
        },
        "/y" => %Day7.AOCFile{
          name: "y",
          path: "/",
          size: 20
        }
      }

      result = %{
        "/" => %Day7.AOCDirectory{
          name: "/",
          path: "",
          size: 30
        },
        "/x" => %Day7.AOCFile{
          name: "x",
          path: "/",
          size: 10
        },
        "/y" => %Day7.AOCFile{
          name: "y",
          path: "/",
          size: 20
        }
      }

      assert Day7.set_dir_sizes(input) == result
    end

    test "gets nested dir size" do
      input = %{
        "/" => %Day7.AOCDirectory{
          name: "/",
          path: "",
        },
        "/a" => %Day7.AOCDirectory{
          name: "a",
          path: "/",
        },
        "/a/x" => %Day7.AOCFile{
          name: "x",
          path: "/a",
          size: 10
        },
        "/b" => %Day7.AOCDirectory{
          name: "b",
          path: "/",
        },
        "/b/y" => %Day7.AOCFile{
          name: "y",
          path: "/b",
          size: 20
        },
        "/b/z" => %Day7.AOCFile{
          name: "z",
          path: "/b",
          size: 20
        }
      }

      result = %{
        "/" => %Day7.AOCDirectory{
          name: "/",
          path: "",
          size: 50
        },
        "/a" => %Day7.AOCDirectory{
          name: "a",
          path: "/",
          size: 10
        },
        "/a/x" => %Day7.AOCFile{
          name: "x",
          path: "/a",
          size: 10
        },
        "/b" => %Day7.AOCDirectory{
          name: "b",
          path: "/",
          size: 40
        },
        "/b/y" => %Day7.AOCFile{
          name: "y",
          path: "/b",
          size: 20
        },
        "/b/z" => %Day7.AOCFile{
          name: "z",
          path: "/b",
          size: 20
        }
      }

      assert Day7.set_dir_sizes(input) == result
    end
  end

  describe "get_space_needed" do
    test "" do
      input = %{
        "/" => %Day7.AOCDirectory{
          name: "/",
          path: "",
          size: 48381165
        },
        "/x" => %Day7.AOCFile{
          name: "x",
          path: "/",
          size: 28381165
        },
        "/y" => %Day7.AOCFile{
          name: "y",
          path: "/",
          size: 20000000
        }
      }

      assert Day7.get_space_needed(input) == 8381165
    end
  end

  describe "find_smallest_directory" do
    test "get smallest viable directory" do
      input = %{
        "/" => %Day7.AOCDirectory{
          name: "/",
          path: "",
          size: 300
        },
        "/a" => %Day7.AOCDirectory{
          name: "a",
          path: "/",
          size: 200
        },
        "/b" => %Day7.AOCDirectory{
          name: "b",
          path: "/",
          size: 50
        },
        "/c" => %Day7.AOCDirectory{
          name: "c",
          path: "/",
          size: 160
        },
        "/d" => %Day7.AOCDirectory{
          name: "d",
          path: "/",
          size: 155
        },
        "/e" => %Day7.AOCDirectory{
          name: "e",
          path: "/",
          size: 170
        }
      }

      result = %Day7.AOCDirectory{
        name: "d",
        path: "/",
        size: 155
      }

      assert Day7.find_smallest_directory(input, 150) == 155
    end
  end
end
