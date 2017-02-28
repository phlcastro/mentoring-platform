class ApiConstraints
  def initialize(options)
    @version = options[:version]
    @default = options[:default]
  end

  def matches?(req)
    (!req.headers['Accept'].include?('application/mentoring-platform') && @default) ||
      req.headers['Accept'].include?("application/mentoring-platform-v#{@version}")
  end
end
