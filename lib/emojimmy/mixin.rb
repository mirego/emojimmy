module Emojimmy
  module Mixin
    def self.inject_methods(model, attributes)
      attributes.each do |attribute|
        model.class_eval <<-RUBY, __FILE__, __LINE__ + 1
          # Before saving the record, convert the attribute value
          before_save do
            unless respond_to?("#{attribute}=")
              raise ArgumentError.new('#{model} must respond to #{attribute}= in order for Emojimmy to store emoji characters in it.')
            end

            self.#{attribute} = Emojimmy.emoji_to_token(self.#{attribute})
            true
          end

          # When calling the attribute name, convert its value
          def #{attribute}
            Emojimmy.token_to_emoji(super)
          end
        RUBY
      end
    end
  end
end
