# Main file for 
require 'csv'

module Flashcards
  
  class Card
    attr_reader :term, :definition

    def initialize(params)
      @term = params[:term]
      @definition = params[:definition]
    end

    # def to_s
    #   "#{definition}:  #{term}"
    # end 

  end

  class Deck
    attr_reader :file, :flashcards
    
    def initialize(file = 'flash_card.csv')
      @flashcards = []
      @file = file
      parse
    end
    
    def parse
      CSV.foreach(file, :headers => true, :header_converters => :symbol, :converters => :all) do |row|
        flashcards << Card.new(row)
      end
      flashcards
    end

  end


    class Controller
    attr_reader :deck, :view
    def initialize(deck = Deck.new, view = View.new)
      @deck = deck
      @view = view
      @guess = nil
    end

    def play
      @view.welcome_message

      while @deck.flashcards.any?
        @view.diplay_definition(definition)
        get_guess

        until matching_term == @guess
          @view.display_error(@guess)
          get_guess
        end

        @view.display_correct(@guess)
        delete_correct
      end

      @view.display_game_over
    end

    def get_guess
      @view.request_response
      @guess = gets.chomp.downcase!
    end

    def index
      rand(@deck.flashcards.size)
    end

    def definition
      @deck.flashcards[index].definition
    end

    def matching_term
      @deck.flashcards[index].term
    end

    def delete_correct
      @deck.flashcards.delete(matching_term.to_sym)
    end

  end

  class View
    def welcome_message
      puts "Welcome to Ruby Flash Cards. To play, just enter the correct term for each definition."
      puts "(type \"exit\" at any point to end the game)"
    end

    def display_definition(definition)
      puts definition
    end

    def request_response
      puts "What is your guess?"
    end

    def display_error(guess)
      puts "Guess: #{guess}"
      puts "Incorrect!  Try again."
    end

    def display_correct(guess)
      puts "Guess: #{guess}"
      puts "Correct!!"
    end

    def display_game_over
      puts "\nCongratulations! You have completed all flashcards.\nThanks for playing!"
    end
  end

end

game = Flashcards::Controller.new
puts game.matching_term

