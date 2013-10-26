module Emojimmy
  module Mixin
    def self.inject_methods(model, attributes)
      attributes.each do |attribute|
        model.class_eval <<-RUBY, __FILE__, __LINE__ + 1
          # Before saving the record, convert the attribute value
          before_save do
            self.#{attribute} = Emojimmy.emoji_to_text(self.#{attribute})
          end

          # When calling the attribute name, convert its value
          def #{attribute}
            Emojimmy.text_to_emoji(read_attribute(#{attribute.inspect}))
          end
        RUBY
      end
    end
  end
end
