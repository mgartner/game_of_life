require 'spec_helper'

describe Board do

  describe "#[](i, j)" do
    let(:board) { Board.new(2, 2) }
    it "should return a cell at each possible position" do
      board[0,0].is_a?(Cell).should be_true
      board[0,1].is_a?(Cell).should be_true
      board[1,0].is_a?(Cell).should be_true
      board[1,1].is_a?(Cell).should be_true
    end
  end

  describe "#each_neighbor" do
    let(:board) { Board.new(3, 3) }
    it "should yield each neighbor" do
      cells = board.instance_variable_get("@cell_matrix").to_a.flatten
      neighbors = []
      board.each_neighbor(1, 1) do |cell|
        neighbors << cell
      end
      neighbors.size.should eq(cells.size - 1)
      cells.each_with_index do |cell, i|
        if i != 4
          neighbors.include?(cell).should be_true
        end
      end
    end
  end

  describe "#neighbor_count" do
    let(:board) { Board.new(3, 3) }
    context "when no cells live" do
      it "should return 0" do
        board.neighbor_count(0,0).should eq(0)
        board.neighbor_count(2,2).should eq(0)
        board.neighbor_count(1,1).should eq(0)
        board.neighbor_count(1,0).should eq(0)
      end
    end
    context "when one cell lives" do
      it "should return 1 when a cell is neighbors to the live cell" do
        board[0, 0].revive
        board.neighbor_count(0,0).should eq(0)
        board.neighbor_count(0,1).should eq(1)
        board.neighbor_count(1,1).should eq(1)
        board.neighbor_count(1,0).should eq(1)
        board.neighbor_count(2,1).should eq(0)
      end
    end
    context "when multiple cells live" do
      it "should return the correct count of live neighbors" do
        board[0, 0].revive
        board[2, 2].revive
        board[1, 0].revive
        board.neighbor_count(0,0).should eq(1)
        board.neighbor_count(0,1).should eq(2)
        board.neighbor_count(1,1).should eq(3)
        board.neighbor_count(1,0).should eq(1)
        board.neighbor_count(2,1).should eq(2)
      end
    end
  end

  describe "#advance" do
    let(:board) { Board.new(3, 3) }
    context "with a dead board" do
      it "should not change" do
        board.advance
        board.each_cell do |cell|
          cell.alive?.should be_false
        end
      end
    end
    context "with a seeded board" do
      it "should advance appropriately" do
        board[0,0].revive
        board[1,1].revive
        board[2,1].revive
        board.advance
        i = 0
        board.each_cell do |cell|
          if i == 3 || i == 4
            cell.alive?.should be_true
          else
            cell.alive?.should be_false
          end
          i += 1
        end
      end
    end
  end

  describe "#to_s" do
    let(:board) { Board.new(3, 3) }
    it "should print appropriately" do
      board[0,0].revive
      board[1,1].revive
      board[2,1].revive
      board.to_s.should eq("-----\n|X  |\n| X |\n| X |\n-----")
    end
  end

end
