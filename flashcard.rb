# Main file for 
require 'csv'

module Flashcards
  
  class Card
    attr_reader :term, :definition

    def initialize(params)
      @term = params[:term]
      @definition = params[:definition]
    end

    def to_s
      "#{definition}:  #{term}"
    end 

  end

  class Deck
    attr_accessor :file, :card_deck
    
    def initialize(file = 'flash_card.csv')
      @card_deck = []
      @file = file
    end
    
    def parse
      CSV.foreach(file, :headers => true, :header_converters => :symbol, :converters => :all) do |row|
        card_deck << Card.new(Hash[row])
      end
      card_deck
    end

  end


  class Controller

  end

  class View
  end

end

d = Flashcards::Deck.new

d_parse = d.parse

puts d_parse
