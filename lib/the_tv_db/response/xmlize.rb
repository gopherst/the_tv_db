module TheTvDB
  class Response::Xmlize < Response
    dependency 'multi_xml'
    
    define_parser do |body|
      ::MultiXml.parser = :ox
      ::MultiXml.parse body
    end

    def parse(body)
      case body
      when ''
        nil
      when 'true'
        true
      when 'false'
        false
      when Hash
        body.each { |k, v| body[k] = self.class.parser.call(v) }
      else
        self.class.parser.call body
      end
    end
    
  end # Response::Xmlize
end # TheTvDB