defmodule DaySixTest do
  use ExUnit.Case

  describe "find_start_packet" do
    test "finds the correct packet" do
      assert DaySix.find_start_packet("mjqjpqmgbljsphdztnvjfqwrcgsmlb") === 7
      assert DaySix.find_start_packet("bvwbjplbgvbhsrlpgdmjqwftvncz") === 5
      assert DaySix.find_start_packet("nppdvjthqldpwncqszvftbrmjlhg") === 6
      assert DaySix.find_start_packet("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg") === 10
      assert DaySix.find_start_packet("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw") === 11
    end
  end

  describe "is_start_of_packet" do
    test "returns true for valid start" do
      assert DaySix.is_start_of_packet("abcd") == true
    end

    test "returns false if too short" do
      assert DaySix.is_start_of_packet("bcd") == false
    end

    test "returns false if duplicates exist" do
      assert DaySix.is_start_of_packet("bcdb") == false
    end
  end
end
