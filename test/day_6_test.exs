defmodule DaySixTest do
  use ExUnit.Case

  describe "part_one" do
    test "finds the correct packet" do
      assert DaySix.part_one("mjqjpqmgbljsphdztnvjfqwrcgsmlb") === 7
      assert DaySix.part_one("bvwbjplbgvbhsrlpgdmjqwftvncz") === 5
      assert DaySix.part_one("nppdvjthqldpwncqszvftbrmjlhg") === 6
      assert DaySix.part_one("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg") === 10
      assert DaySix.part_one("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw") === 11
    end
  end

  describe "part_two" do
    test "finds the correct message" do
      assert DaySix.part_two("mjqjpqmgbljsphdztnvjfqwrcgsmlb") === 19
      assert DaySix.part_two("bvwbjplbgvbhsrlpgdmjqwftvncz") === 23
      assert DaySix.part_two("nppdvjthqldpwncqszvftbrmjlhg") === 23
      assert DaySix.part_two("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg") === 29
      assert DaySix.part_two("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw") === 26
    end
  end

  describe "is_start_of_packet" do
    test "returns true for valid start" do
      assert DaySix.is_start("abcd", 4) == true
    end

    test "returns false if too short" do
      assert DaySix.is_start("bcd", 4) == false
    end

    test "returns false if duplicates exist" do
      assert DaySix.is_start("bcdb", 4) == false
    end
  end
end
