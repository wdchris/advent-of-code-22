defmodule DayFourTest do
  use ExUnit.Case

  describe "contains_range" do
    test "returns true if wholly in range" do
      container = {1,10}
      range = {2,5}
      assert DayFour.contains_range(container, range) == true
    end

    test "returns true if inclusively in range" do
      container = {1,10}
      range = {1,10}
      assert DayFour.contains_range(container, range) == true
    end
  end

  describe "line_to_tuples" do
    test "returns tuple with a valid line" do
      input = "57-93,9-57"
      assert DayFour.line_to_tuples(input) == [{57,93}, {9,57}]
    end
  end

  describe "get_fully_contained_ranges" do
    test "counts if wholly in range" do
      input = ["1-10,2-5"]
      assert DayFour.calculate(input, &DayFour.contains_range/2) == 1
    end

    test "counts in reverse order" do
      input = ["2-5,1-10"]
      assert DayFour.calculate(input, &DayFour.contains_range/2) == 1
    end

    test "counts only wholly in range" do
      input = ["1-10,2-5","1-10,20-50"]
      assert DayFour.calculate(input, &DayFour.contains_range/2) == 1
    end

    test "counts multiple wholly in range" do
      input = ["1-10,2-5","1-10,4-5"]
      assert DayFour.calculate(input, &DayFour.contains_range/2) == 2
    end
  end

  describe "overlaps" do
    test "returns false if no overlap" do
      container = {2,4}
      range = {6,8}
      assert DayFour.overlaps(container, range) == false
    end

    test "returns true if overlap" do
      container = {5,7}
      range = {7,9}
      assert DayFour.overlaps(container, range) == true
    end
  end
end
