module ModelMacros
  # Create a new Emojimmy-powered model
  def spawn_emojimmy_model(klass_name, options = {}, &block)
    spawn_model klass_name do
      stores_emoji_characters options
      instance_exec(&block) if block
    end
  end

  protected

  # Create a new model class
  def spawn_model(klass_name, parent_klass = ActiveRecord::Base, &block)
    Object.instance_eval { remove_const klass_name } if Object.const_defined?(klass_name)
    Object.const_set(klass_name, Class.new(parent_klass))
    Object.const_get(klass_name).class_eval(&block) if block_given?
  end
end
