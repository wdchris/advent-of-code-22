defmodule Day8Test do
  use ExUnit.Case

  describe "part_one" do
    test "returns correct amount of trees" do
      input = "30373\n25512\n65332\n33549\n35390"

      assert Day8.part_one(input) == 21
    end
  end

  describe "part_two" do
    test "returns correct scenic scores" do
      input = "30373\n25512\n65332\n33549\n35390"

      assert Day8.part_two(input) == 8
    end
  end

  describe "find_visible left to right" do
    test "finds edge trees" do
      input = [2,0,2]

      assert Day8.find_visible(input) == [1,0,0]
    end

    test "finds edge and middle trees" do
      input = [2,3,2]

      assert Day8.find_visible(input) == [1,1,0]
    end

    test "finds trees in complex list" do
      input = [2,3,0,1,4,0,2]

      assert Day8.find_visible(input) == [1,1,0,0,1,0,0]
    end
  end

  describe "find_scenic_score left" do
    test "finds zero for one element" do
      input = [2]

      assert Day8.find_scenic_score(input) == [0]
    end

    test "finds one for one element" do
      input = [2,3]

      assert Day8.find_scenic_score(input) == [0,1]
    end

    test "finds for multiple elements in height order" do
      input = [2,3,4]

      assert Day8.find_scenic_score(input) == [0,1,2]
    end

    test "finds for multiple elements in random order" do
      input = [3,0,3,7,3]

      assert Day8.find_scenic_score(input) == [0,1,2,3,1]
    end
  end
end
