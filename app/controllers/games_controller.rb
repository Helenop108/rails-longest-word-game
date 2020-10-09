require "open-uri"

class GamesController < ApplicationController
  def new
    source=("A".."Z").to_a
    @letters =""
    10.times{ @letters += source[rand(source.size)] }
  end

  def score
    @input = params[:word].upcase
    @grid = params[:letters].split
    @valid = comparation?(@input, @grid)
    @high_score = points_of_input(@input)
  end

  def comparation?(input, grid)
    input.chars.all? { |char| input.count(char) <= grid.count(char) }
  end

  def points_of_input(input)
    response = open("https://wagon-dictionary.herokuapp.com/#{input}")
    json = JSON.parse(response.read)
    json['found']
  end
end

# @letters = ("A".."Z").to_a.sample(10)
