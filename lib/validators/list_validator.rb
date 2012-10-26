class ListValidator < ActiveModel::EachValidator

  def initialize(options)
    options.reverse_merge!(message: 'is not valid as it contains unaccepted values')
    super(options)
  end

  def validate_each(record, attribute, values)
    contained_in = options.fetch(:in)
    if values.kind_of? Array
      if not values.all? { |value| contained_in.include?(value) } 
        record.errors.add(attribute, options.fetch(:message), value: values)
      end
    end
  end
end

module ClassMethods
  # Validates whether the value of the specified attribute is valid url.
  #
  #   class Unicorn
  #     include ActiveModel::Validations
  #     attr_accessor :types
  #     validates list: { in: %w(device type location) }
  #   end
  # Configuration options:
  # * <tt>:in</tt> - Array of accepted values)
  # * <tt>:message</tt> - A custom error message (default is: 'is not a valid URL').
  # * <tt>:allow_nil</tt> - If set to true, skips this validation if the attribute is +nil+ (default is +false+).
  # * <tt>:allow_blank</tt> - If set to true, skips this validation if the attribute is blank (default is +false+).

  def validates_list(*attr_names)
    validates_with ListValidator, _merge_attributes(attr_names)
  end
end
