class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # deviseのコントローラにストロングパラメータを追加するメソッド
  def configure_permitted_parameters
    # ユーザー登録時のストロングパラメータとして'name'を追加
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end
