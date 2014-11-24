class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # sometokenの所に元々のトークンをセット（よくわからない）
  # TestApp::Application.config.secret_key_base = ENV['SECRET_KEY_BASE'] || 'sometoken'

end
