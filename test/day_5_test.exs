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

    test "works with no first stack" do
      input = ["    [Q] [B]", "[G] [J] [S]"]
      assert DayFive.read_starting_stacks(input) == [["G"],["Q","J"],["B","S"]]
    end
  end

  describe "get_move" do
    test "finds correct numeric elements" do
      input = "move 1 from 8 to 1"
      result =
        %{
            count: 1,
            from: 8,
            to: 1
          }

      assert DayFive.get_move(input) == result
    end

    test "returns nil if not a move" do
      input = "[F] [N] [F] [V] [Q] [Z] [Z] [T] [Q]"
      assert DayFive.get_move(input) == nil
    end
  end

  describe "make_moves" do
    test "move an element between stacks" do
      input_moves = ["move 1 from 3 to 1"]
      input_stacks = [["Q","G"],["J"],["B","S"]]
      result = [["B","Q","G"],["J"],["S"]]

      assert DayFive.make_moves(input_moves, input_stacks) == result
    end

    test "move two elements between stacks" do
      input_moves = ["move 2 from 3 to 1"]
      input_stacks = [["Q","G"],["J"],["B","S"]]
      result = [["S","B","Q","G"],["J"],[]]

      assert DayFive.make_moves(input_moves, input_stacks) == result
    end

    test "makes two moves" do
      input_moves = ["move 1 from 3 to 1", "move 1 from 2 to 3"]
      input_stacks = [["Q","G"],["J"],["B","S"]]
      result = [["B","Q","G"],[],["J","S"]]

      assert DayFive.make_moves(input_moves, input_stacks) == result
    end
  end

  describe "read_top_crates" do
    test "takes the top crate" do
      input = [["B","Q","G"]]
      result = "B"

      assert DayFive.read_top_crates(input) == result
    end

    test "takes multiple top crate" do
      input = [["B","Q","G"],["Q","G"],["A","B","C"]]
      result = "BQA"

      assert DayFive.read_top_crates(input) == result
    end

    test "handles empty crates" do
      input = [["B","Q","G"],[],["A","B","C"]]
      result = "BA"

      assert DayFive.read_top_crates(input) == result
    end
  end
end
