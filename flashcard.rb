# Main file for 
module Flashcards
  
  class Card
    attr_reader :term, :definition

    def intialize(term, definition)
      @term = term
      @definition = definition
    end


  end

  class Deck
    attr_accessor :file 
    
    def initialize(file = 'flashcard_sample.txt')
      @file = File.open(file)
    end
    
    def parse
      file.read
    end

  end


  class Controller

  end

  class View
  end

end

d = Deck
