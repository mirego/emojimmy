class ActiveRecord::Base
  def self.stores_emoji_characters(*attributes)
    return unless table_exists?

    Emojimmy::Mixin.inject_methods(self, attributes)
  end
end
