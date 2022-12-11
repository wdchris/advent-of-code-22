defmodule Day8Test do
  use ExUnit.Case

  # @tag :skip
  describe "part_one" do
    test "returns correct amount of trees" do
      input = "30373\n25512\n65332\n33549\n35390"

      assert Day8.part_one(input) == 21
    end
  end

  describe "find_visible left to right" do
    test "finds edge trees" do
      input = [2,0,2]

      assert Day8.find_visible(input) == [0]
    end

    test "finds edge and middle trees" do
      input = [2,3,2]

      assert Day8.find_visible(input) == [1,0]
    end

    test "finds trees in complex list" do
      input = [2,3,0,1,4,0,2]

      assert Day8.find_visible(input) == [4,1,0]
    end
  end
end
