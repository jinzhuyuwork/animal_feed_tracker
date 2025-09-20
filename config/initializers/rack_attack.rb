class Rack::Attack
  # 1. Throttle logins: max 5 requests per 20 seconds
  throttle('logins/ip', limit: 5, period: 20.seconds) do |req|
    if req.path == '/users/sign_in' && req.post?
      # req.ip
      # body = req.body.read
      # req.body.rewind
      # email = JSON.parse(body).dig('user', 'email') rescue nil

      email = req.get_header('HTTP_X_EMAIL')
      Rails.logger.info "Rate limtting for email: #{email}"
      email
    end
  end

  # 2. Throttle all API requests: max 60 requests per minute
  throttle('req/ip', limit: 60, period: 1.minute) do |req|
    # req.ip if req.path.start_with?('/api/v1/')
    if req.path.start_with?('/api/v1/')
      auth_header = req.get_header('HTTP_AUTHORIZATION')
      token = auth_header.split(' ').last if auth_header&.start_with?('Bearer ')
      
      Rails.logger.info "Rate limtting for token: #{token}"
      # return token or decoded user id for rate limiting key
      token
    end
  end

  # 3. Blocklisted IPs example (optional)
  # self.blocklist('block 1.2.3.4') { |req| '1.2.3.4' == req.ip }

  # Response for throttled requests:
  Rack::Attack.throttled_responder = ->(env) do
    [429,  # status
     { 'Content-Type' => 'application/json' },
     [{ error: 'Rate limit exceeded. Please try again later.' }.to_json]]
  end
end
