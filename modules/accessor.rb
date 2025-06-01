module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      var_name = "@#{name}".to_sym
      history_var = "@#{name}_history".to_sym

      define_method(name) { instance_variable_get(var_name) }

      define_method("#{name}=") do |value|
        history = instance_variable_get(history_var) || []
        instance_variable_set(history_var, history << instance_variable_get(var_name))
        instance_variable_set(var_name, value)
      end

      define_method("#{name}_history") { instance_variable_get(history_var) || [] }
    end
  end

  def strong_attr_accessor(name, klass)
    var_name = "@#{name}".to_sym

    define_method(name) { instance_variable_get(var_name) }

    define_method("#{name}=") do |value|
      raise "Invalid type. Expected #{klass}, got #{value.class}" unless value.is_a?(klass)
      instance_variable_set(var_name, value)
    end
  end
end