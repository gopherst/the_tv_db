module TheTvDB

  # Generic TheTvDB exception class.
  class TheTvDBError < StandardError
  end

  # Raised when a connection to the api can't be established.
  class ConnectionNotEstablished < StandardError
  end

  # Raised when the record was not found given an id or set of ids.
  class RecordNotFound < StandardError
  end
end
