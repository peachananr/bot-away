request = (defined?(Rails::VERSION) && Rails::VERSION::STRING >= "3.0") ? 
          ActionDispatch::Request : # Rails 3.0
          ActionController::Request # Rails 2.3

request.module_eval do
  def parameters_with_deobfuscation
    @deobfuscated_parameters ||= begin
      BotAway::ParamParser.new(ip, parameters_without_deobfuscation.dup).params
    end 
  end

  alias_method_chain :parameters, :deobfuscation
  alias_method :params, :parameters
end