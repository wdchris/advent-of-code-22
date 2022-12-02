defmodule DayOneTest do
  use ExUnit.Case

  describe "map_to_rps" do
    test "returns rocks" do
      input = ["A", "X"]
      assert DayTwo.map_to_rps(input) == [:rock, :rock]
    end

    test "returns papers" do
      input = ["B", "Y"]
      assert DayTwo.map_to_rps(input) == [:paper, :paper]
    end

    test "returns scissors" do
      input = ["C", "Z"]
      assert DayTwo.map_to_rps(input) == [:scissors, :scissors]
    end
  end

  describe "get_score_by_rps" do
    test "returns 4 for rocks" do
      input = [["A", "X"]]
      assert DayTwo.get_score(input, &DayTwo.map_to_rps/1) == 4
    end

    test "sums 2 rocks rows" do
      input = [["A", "X"], ["A", "X"]]
      assert DayTwo.get_score(input, &DayTwo.map_to_rps/1) == 8
    end
  end
end
