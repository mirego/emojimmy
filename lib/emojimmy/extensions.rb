class ActiveRecord::Base
  def self.stores_emoji_characters(*attributes)
    return unless table_exists?

    options = attributes.last.is_a?(Hash) ? attributes.pop : {}
    Emojimmy::Mixin.inject_methods(self, attributes, options)
  end
end
