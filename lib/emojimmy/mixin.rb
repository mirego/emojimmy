module Emojimmy
  module Mixin
    def self.inject_methods(model, attributes, options={})
      attributes.each do |attribute|
        model.class_eval <<-RUBY, __FILE__, __LINE__ + 1
          # Before saving the record, convert the attribute value
          before_save do
            unless respond_to?("#{attribute}=")
              raise ArgumentError.new('#{model} must respond to #{attribute}= in order for Emojimmy to store emoji characters in it.')
            end

            self.#{attribute} = Emojimmy.emoji_to_token(self.#{attribute})
          end
        RUBY

        if options[:read_attribute] != false
          alias_attribute   = 'super'
          unicode_attribute = attribute.to_s

          if options[:read_attribute].is_a?(Hash) && options[:read_attribute][:suffix]
            alias_attribute = attribute
            unicode_attribute << "_#{options[:read_attribute][:suffix]}"
          end

          model.class_eval <<-RUBY, __FILE__, __LINE__ + 1
            # When calling the attribute name, convert its value
            def #{unicode_attribute}
              Emojimmy.token_to_emoji(#{alias_attribute})
            end
          RUBY
        end
      end
    end
  end
end
