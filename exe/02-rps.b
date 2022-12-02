#!/usr/bin/env bundle exec ruby

require "advent_of_code"
data = AdventOfCode::DataLoader.read("02")

class RPSMove
  WIN_SCORE = 6
  DRAW_SCORE = 3
  LOSE_SCORE = 0

  def initialize(opponent_move:, me_move:)
    @opponent_move = opponent_move
    @me_move = me_move
  end

  def play_score
    {
      rock: 1,
      paper: 2,
      scissors: 3
    }[@me_move]
  end

  def result_score
    case @me_move
    when :rock
      {rock: DRAW_SCORE, paper: LOSE_SCORE, scissors: WIN_SCORE}[@opponent_move]
    when :paper
      {rock: WIN_SCORE, paper: DRAW_SCORE, scissors: LOSE_SCORE}[@opponent_move]
    when :scissors
      {rock: LOSE_SCORE, paper: WIN_SCORE, scissors: DRAW_SCORE}[@opponent_move]
    end
  end

  def self.map_strat_to_move(opponent_move:, strat:)
    lose_strat = {rock: :scissors, paper: :rock, scissors: :paper}
    win_strat = {rock: :paper, paper: :scissors, scissors: :rock}

    case strat
    when "X"
      lose_strat[opponent_move]
    when "Y"
      opponent_move
    when "Z"
      win_strat[opponent_move]
    end
  end

  def score
    play_score + result_score
  end

  def self.from_line(line)
    o, strat = line.split
    omove = map_to_move(o)
    mmove = map_strat_to_move(opponent_move: omove, strat: strat)
    new(opponent_move: omove, me_move: mmove)
  end

  def self.map_to_move(char)
    {
      "A" => :rock,
      "B" => :paper,
      "C" => :scissors
    }[char]
  end
end

class RPSGame
  attr_reader :moves

  def initialize
    @moves = []
  end
end

game = RPSGame.new
data.each { |line| game.moves << RPSMove.from_line(line) }
puts game.moves.map(&:score).sum
