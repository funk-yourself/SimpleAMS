require 'spec_helper'

#TODO: Add better instrumentation
class UserSerializer
  class << self
    def with_overrides(array = [])
      undefine_all
      if array.is_a?(Array)
        array.each do |meth|
          self.send(:define_method, meth) {
            if object.send(meth).respond_to?('*')
              object.send(meth)*2
            else
              'Something else'
            end
          }
        end
      elsif array.is_a?(Hash)
        array.each do |meth, value|
          self.send(:define_method, meth) {
            value
          }
        end
      else
        raise 'wrong type'
      end
    end

    def undefine_all
      model_klass = Object.const_get(self.to_s.gsub("Serializer",""))
      model_klass.model_attributes.each { |meth|
        begin
          self.send(:remove_method, meth)
        rescue NameError => _
        end
      }
    end
  end
  include SimpleAMS::DSL
end
class MicropostSerializer < UserSerializer; end
class AddressSerializer < UserSerializer; end

class Api
  class V1
    class UserSerializer < UserSerializer
    end

    class MicropostSerializer < MicropostSerializer
    end

    class AddressSerializer < AddressSerializer
    end
  end
end
