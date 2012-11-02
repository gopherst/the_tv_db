module TheTvDB
  class Response::RaiseError < Faraday::Response::Middleware

    def on_complete(env)
      status_code = env[:status].to_i
      raise TheTvDB::RecordNotFound.new(env) if (400...600).include? status_code
    end

  end # Response::RaiseError
end # TheTvDB