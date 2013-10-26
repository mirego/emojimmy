class ActiveRecord::Base
  def self.stores_emoji_characters(options = {})
    return unless table_exists?

    options[:in] ||= []
    Emojimmy::Mixin.inject_methods(self, options[:in])
  end
end
