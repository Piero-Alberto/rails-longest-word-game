require "open-uri"

class GamesController < ApplicationController
   def new
    vowels = ['A', 'E', 'I', 'O', 'U']
    consonants = ('A'..'Z').to_a - vowels
    @letters = (vowels.sample(5) + consonants.sample(5)).shuffle
  end
  def score
    @letters = params[:letters].split
    @word = (params[:word] || "").upcase
    @included = included?(@word, @letters)
    @english_word = english_word?(@word)
  end

  private

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = URI.open("https://dictionary.lewagon.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
