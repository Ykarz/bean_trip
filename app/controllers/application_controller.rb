class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :configure_permitted_parameters, if: :devise_controller?

  # deviseのコントローラにストロングパラメータを追加するメソッド
  def configure_permitted_parameters
    # ユーザー登録時のストロングパラメータとして'name'を追加
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
