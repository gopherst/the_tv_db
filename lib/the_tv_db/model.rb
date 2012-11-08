module TheTvDB
  module Model
    
    attr_accessor :klass
    
    def initialize(params=nil, &block)
      @klass = self.class
      self.attributes = params
      
      self.instance_eval(&block) if block_given?
    end
    
    def attributes=(params=nil)
      params.each do |attr, value|
        begin
          self.public_send("#{attributes_map.key(attr)}=", value)
        rescue NoMethodError
          raise UnknownAttributeError, "unknown attribute: #{attr}"
        end
      end if params
    end
    
    def attributes
      attrs = {}
      class_attributes.each do |name|
        attrs[name] = send(name)
      end
      attrs
    end
    
    def inspect
      inspection = unless id.nil?
        class_attributes.collect { |name|
          "#{name}: #{attribute_for_inspect(name)}"
        }.compact.join(", ")
       else
         "not initialized"
       end
      "#<#{self.class} #{inspection}>"
    end
    
    def attribute_for_inspect(attr_name)
      value = send(attr_name)

      if value.is_a?(String) && value.length > 50
        "#{value[0..50]}...".inspect
      elsif value.is_a?(Date) || value.is_a?(Time)
        %("#{value.to_s(:db)}")
      else
        value.inspect
      end
    end
    
    def attributes_map
      klass::ATTRS_MAP
    end
    
    def class_attributes
      attributes_map.keys
    end
    
  end # Model
end # TheTvDB