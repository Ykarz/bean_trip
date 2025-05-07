class BeansController < ApplicationController
  # indexアクションとshowアクション以外は、ログインを必須にする
  before_action :authenticate_user!, only: %i[new create]

  def index
    @beans = Bean.includes(:user)
  end

  def new
    @bean = Bean.new
  end

  def create
    # 複数のモデルに対する操作を行うので、transactionメソッドを使用
    ActiveRecord::Base.transaction do
      # フォームから受け取ったパラメータの内、':country'は除外
      # それ以外のパラメータを引数として、Beanモデルのインスタンスをビルド
      @bean = current_user.beans.build(bean_params.except(:country))

      # countriesテーブルにて、国名が一致するレコードがあれば取得し、なければ作成
      country = Country.find_or_create_by!(name: bean_params[:country])
      # 取得もしくは生成したCountryモデルのインスタンスを、Beanモデルのインスタンスに関連付ける
      @bean.country = country
      @bean.store = nil

      if @bean.save
        redirect_to beans_path, notice: t('beans.create.success')
      else
        flash.now[:alert] = t('beans.create.failure')
        render :new, status: :unprocessable_entity
      end
    end

  rescue ActiveRecord::RecordInvalid => e
    flash.now[:alert] = "#{t('beans.create.failure')}: #{e.message}"
    render :new, status: :unprocessable_entity
  end

  def show; end

  def edit; end

  private

  # ストロングパラメータ
  def bean_params
    params.require(:bean).permit(:name, :country, :area, :farm, :roast_level, :blended, :bitterness, :sweetness, :acidity, :body, :aroma, :comment)
  end
end
