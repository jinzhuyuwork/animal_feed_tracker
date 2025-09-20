class ExtractEmail
  def initialize(app)
    @app = app
  end

  def call(env)
    req = Rack::Request.new(env)
    if req.path == '/users/sign_in' && req.post?
      body = req.body.read
      req.body.rewind
      data = JSON.parse(body) rescue {}
      email = data['email'] || data.dig('user', 'email')
      env['HTTP_X_EMAIL'] = email if email
    end
    @app.call(env)
  end
end
