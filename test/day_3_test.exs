defmodule DayThreeTest do
  use ExUnit.Case

  describe "get_priority_sum" do
    test "returns 16 for incorrect p" do
      input = ["vJrwpWtwJgWrhcsFMMfFFhFp"]
      assert DayThree.get_priority_sum(input) == 16
    end

    test "returns 38 for incorrect L" do
      input = ["jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL"]
      assert DayThree.get_priority_sum(input) == 38
    end
  end

  describe "find_incorrect_item" do
    test "returns p" do
      input = "vJrwpWtwJgWrhcsFMMfFFhFp"
      assert DayThree.find_incorrect_item(input) == "p"
    end

    test "returns L" do
      input = "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL"
      assert DayThree.find_incorrect_item(input) == "L"
    end
  end

  describe "convert_to_number" do
    test "returns 1 for a" do
      assert DayThree.convert_to_number("a") == 1
    end

    test "returns 26 for z" do
      assert DayThree.convert_to_number("z") == 26
    end

    test "returns 27 for A" do
      assert DayThree.convert_to_number("A") == 27
    end

    test "returns 52 for Z" do
      assert DayThree.convert_to_number("Z") == 52
    end
  end
end
