defmodule DayFiveTest do
  use ExUnit.Case

  describe "push_line_to_stack" do
    test "adds a letter to the stack" do
      input = "[Q]"
      assert DayFive.push_line_to_stack(input, [[]]) == [["Q"]]
    end

    test "adds two letters to the stack" do
      input = "[Q] [J]"
      assert DayFive.push_line_to_stack(input, [[],[]]) == [["Q"],["J"]]
    end

    test "adds a letter to the top of the stack" do
      input = "[Q]"
      assert DayFive.push_line_to_stack(input, [["A"]]) == [["Q", "A"]]
    end
  end

  describe "read_starting_stacks" do
    test "adds a line to a stack" do
      input = ["[Q] [J]"]
      assert DayFive.read_starting_stacks(input) == [["Q"],["J"]]
    end

    test "adds two lines to a stack" do
      input = ["[Q] [J]", "[G] [S]"]
      assert DayFive.read_starting_stacks(input) == [["Q","G"],["J","S"]]
    end

    test "filters none stack lines" do
      input = ["[Q] [J]", " 1   2 ", "   ", "move 1 from 8 to 1"]
      assert DayFive.read_starting_stacks(input) == [["Q"],["J"]]
    end

    test "skips empty stack elements" do
      input = ["[Q]     [B]", "[G] [J] [S]"]
      assert DayFive.read_starting_stacks(input) == [["Q","G"],["J"],["B","S"]]
    end
  end
end
