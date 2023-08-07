require "json"
require "open-uri"
class GamesController < ApplicationController

  def new
    @letters = []
    10.times do
      @letters << ('A'..'Z').to_a.sample
    end
  end

  def array_to_object(array)
    object = {}
    array.each do |letter|
      if object[letter]
        object[letter] += 1
      else
        object[letter] = 1
      end
    end
    object
  end


  def score
    url = "https://wagon-dictionary.herokuapp.com/#{params[:answer]}"
    response = URI.open(url).read
  data = JSON.parse(response)
    @letters = params[:lettersArray].downcase.split(" ")
    @letters_object = array_to_object(@letters)
    @answer_letters = params[:answer].downcase.chars
    @answers_object = array_to_object(@answer_letters)
    @answer_letters.each do |letter|
    if data["found"] == false
      @message = "sorry but #{params[:answer]} does not seem to be a valid word......"
    elsif !@letters_object[letter] || @answers_object[letter] > @letters_object[letter]
        @message = "Sorry but #{params[:answer]} can not be built on #{params[:lettersArray]}"
    else @message = "Congratulations! #{params[:answer]} is a valid English word! Score: #{params[:answer].length * params[:answer].length}"
      end
    end
  end
end
