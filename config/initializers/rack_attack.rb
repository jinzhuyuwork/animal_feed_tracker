class Rack::Attack
  # 1. Throttle logins by IP address: max 5 requests per 20 seconds
  throttle('logins/ip', limit: 3, period: 20.seconds) do |req|
    if req.path == '/users/sign_in' && req.post?
      # req.ip
      # req.get_header('action_dispatch.remote_ip')
      # ActionDispatch::Request.new(req.env).remote_ip
      req.get_header('HTTP_X_REAL_IP') || req.get_header('action_dispatch.remote_ip')
    end
  end

  # 2. Throttle all API requests by IP address: max 60 requests per minute
  throttle('req/ip', limit: 60, period: 1.minute) do |req|
    req.ip if req.path.start_with?('/api/v1/')
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
