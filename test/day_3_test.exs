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

  describe "convert_char_to_number" do
    test "returns 1 for a" do
      assert DayThree.convert_char_to_number("a") == 1
    end

    test "returns 26 for z" do
      assert DayThree.convert_char_to_number("z") == 26
    end

    test "returns 27 for A" do
      assert DayThree.convert_char_to_number("A") == 27
    end

    test "returns 52 for Z" do
      assert DayThree.convert_char_to_number("Z") == 52
    end
  end

  describe "get_badge" do
    test "returns r" do
      input_a = "vJrwpWtwJgWrhcsFMMfFFhFp"
      input_b = "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL"
      input_c = "PmmdzqPrVvPwwTWBwg"
      assert DayThree.get_badge(input_a, input_b, input_c) == "r"
    end

    test "returns Z" do
      input_a = "wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn"
      input_b = "ttgJtRGJQctTZtZT"
      input_c = "CrZsJsPPZsGzwwsLwLmpwMDw"
      assert DayThree.get_badge(input_a, input_b, input_c) == "Z"
    end
  end

  describe "get_badge_priority_sum" do
    test "returns 18" do
      input = [
        "vJrwpWtwJgWrhcsFMMfFFhFp",
        "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL",
        "PmmdzqPrVvPwwTWBwg"
      ]
      assert DayThree.get_badge_priority_sum(input) == 18
    end

    test "returns 52" do
      input = [
        "wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn",
        "ttgJtRGJQctTZtZT",
        "CrZsJsPPZsGzwwsLwLmpwMDw"
      ]
      assert DayThree.get_badge_priority_sum(input) == 52
    end

    test "returns 70 for two sets" do
      input = [
        "vJrwpWtwJgWrhcsFMMfFFhFp",
        "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL",
        "PmmdzqPrVvPwwTWBwg",
        "wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn",
        "ttgJtRGJQctTZtZT",
        "CrZsJsPPZsGzwwsLwLmpwMDw"
      ]
      assert DayThree.get_badge_priority_sum(input) == 70
    end
  end
end
