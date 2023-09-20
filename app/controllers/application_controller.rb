class ApplicationController < ActionController::Base
  before_action :basic_auth
  before_action :configure_pernitted_paramerers, if: :devise_controller?

  private
  def configure_pernitted_paramerers
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nick_name, :first_name, :last_name, :first_kana, :last_kana, :birthday])
  end
  
  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV["BASIC_AUTH_USER"] && password == ENV["BASIC_AUTH_PASSWORD"] # 環境変数を読み込む記述に変更
    end
  end
end