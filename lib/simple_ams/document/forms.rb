require 'simple_ams'

module SimpleAMS
  class Document::Forms < Document::Generics
    def initialize(options)
      @options = options
      @members = options.forms
    end

    class Form < Document::Generics::Generic
    end
  end
end
