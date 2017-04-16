class ActiveRecord::Base
  def self.stores_emoji_characters(*attributes)
    begin
      return unless table_exists?
    rescue ActiveRecord::NoDatabaseError
      return
    end

    Emojimmy::Mixin.inject_methods(self, attributes)
  end
end
