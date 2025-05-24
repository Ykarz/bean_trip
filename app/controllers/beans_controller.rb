class BeansController < ApplicationController
  # indexアクションとshowアクション以外は、ログインを必須にする
  before_action :authenticate_user!, only: %i[new create edit update]

  def index
    # 検索パラメータのroast_levelの値が'未選択'の場合は、それをパラメータから除外し検索をかける
    if params[:q].present? && (params[:q][:roast_level_eq] == Bean.roast_levels["not_selected"].to_s)
      params[:q].delete(:roast_level_eq)
      # Ransackの検索オブジェクトを生成
      @q = Bean.ransack(params[:q])
      # 検索オブジェクトから検索結果を重複なしで取得
      @beans = @q.result(distinct: true).includes(:user, :country).order(created_at: :desc)
    else
      @q = Bean.ransack(params[:q])
      @beans = @q.result(distinct: true).includes(:user, :country).order(created_at: :desc)
    end
  end

  def new
    @bean = Bean.new
  end

  def create
    # 複数のモデルに対する操作を行うので、transactionメソッドを使用
    ActiveRecord::Base.transaction do
      # フォームから受け取ったパラメータの内、':country'、':store'、':place_id'は除外
      # それ以外のパラメータを引数として、Beanモデルのインスタンスをビルド
      @bean = current_user.beans.build(bean_params.except(:country, :store, :place_id))

      # countriesテーブルにて、国名が一致するレコードがあれば取得し、なければ作成
      country = Country.find_or_create_by!(name: bean_params[:country])
      # 取得もしくは生成したCountryモデルのインスタンスを、Beanモデルのインスタンスに関連付ける
      @bean.country = country

      # storesテーブルにて、フォームから送られてきた'place_id'と一致するレコードがあれば取得し、なければ作成
      if !bean_params[:place_id].blank?
        store = Store.find_by(place_id: bean_params[:place_id])

        if store.nil?
          store = Store.create!(get_place_detail_data(bean_params[:place_id]))
        end

        @bean.store = store
      end

      if @bean.save!
        redirect_to beans_path, notice: t('beans.create.success')
      else
        flash.now[:alert] = t('beans.create.failure')
        render :new, status: :unprocessable_entity
      end
    end

  rescue ActiveRecord::RecordInvalid => e
    flash.now[:alert] = "#{t('beans.create.failure')}\n #{e.message}"
    render :new, status: :unprocessable_entity
  end

  def show
    @bean = Bean.find(params[:id])
  end

  def edit
    # ログインしているユーザーが投稿した豆のみ編集可能にする
    @bean = current_user.beans.find(params[:id])
  end

  def update
    @bean = current_user.beans.find(params[:id])

    ActiveRecord::Base.transaction do
      # Countryモデルに対する処理
      # countriesテーブルから取得、もしくは新規作成したレコードのidと、
      # 取得したbeansテーブルのレコードに紐づいているcountriesテーブルのレコードのidが等しくなければ、更新処理を行う
      if bean_params[:country].present?
        begin
          country = Country.find_or_create_by!(name: bean_params[:country])
          @bean.country = country if @bean.country_id != country.id
        rescue => e
          @bean.errors.add(:base, e.message)
          raise ActiveRecord::Rollback
        end
      end

      # Storeモデルに対する処理
      if bean_params[:place_id].present?
        begin
          store = Store.find_or_initialize_by(place_id: bean_params[:place_id])
          # 新規に生成されたレコードならDBへの保存処理を実行
          if store.new_record?
            # Places APIを叩いて取得した情報によりカラムを更新
            store.assign_attributes(get_place_detail_data(bean_params[:place_id]))
            store.save!
          end
          @bean.store = store if @bean.store_id != store.id
        rescue => e
          @bean.errors.add(:base, e.message)
          raise ActiveRecord::Rollback
        end
      end

      if @bean.update(bean_params.except(:country, :store, :place_id))
        redirect_to bean_path(@bean), notice: t('beans.update.success')
      else
        flash.now[:alert] = t('beans.update.failure')
        render :edit, status: :unprocessable_entity
      end
    end

  rescue ActiveRecord::Rollback
    flash.now[:alert] = t('beans.update.failure')
    render :edit, status: :unprocessable_entity
  end

  def destroy
    bean = current_user.beans.find(params[:id])
    bean.destroy!
    redirect_to beans_path, notice: t('beans.destroy.success'), status: :see_other
  end

  private

  # ストロングパラメータ
  def bean_params
    params.require(:bean).permit(
      :name,
      :country,
      :area,
      :farm,
      :roast_level,
      :is_blended,
      :store,
      :place_id,
      :image,
      :image_cache,
      :bitterness,
      :sweetness,
      :acidity,
      :body,
      :aroma,
      :comment
      )
  end

  # 'place id'を元にPlaces APIを叩いて、場所の詳細情報を取得するメソッド
  def get_place_detail_data(place_id)
    require 'open-uri'
    require 'json'

    # クエリパラメータの作成
    request_query = URI.encode_www_form(
      place_id: place_id,
      language: 'ja',
      key: ENV['GOOGLE_MAPS_API_KEY']
    )

    # リクエスト用のURLを生成
    request_url = "https://maps.googleapis.com/maps/api/place/details/json?#{request_query}"
    # APIを叩いてJSON形式でデータを取得
    place_detail_json_data = URI.open(request_url).read
    # JSON形式のデータをRubyオブジェクトに変換
    place_detail_data = JSON.parse(place_detail_json_data)

    # DBのカラム名と同じキーを持つハッシュを生成し、それを使用して取得した場所データをDBに保存
    result = {}
    # place id
    result[:place_id] = place_detail_data['result']['place_id']
    # 場所の名前
    result[:name] = place_detail_data['result']['name']
    # 郵便番号
    result[:post_code] = place_detail_data['result']['address_components'].find { |c| c['types'].include?('postal_code') }&.fetch('long_name', nil)

    # 国名付きの住所を取得
    full_address = place_detail_data['result']['formatted_address']
    # 国名の部分を削除
    result[:address] = full_address.sub(/\A[^ ]+ ?/, '')

    # 電話番号
    result[:phone_number] = place_detail_data['result']['formatted_phone_number']
    # 営業時間
    result[:opening_hours] = place_detail_data['result']['opening_hours']['weekday_text'].join("\n") if place_detail_data['result']['opening_hours'].present?
    # WebサイトのURL
    result[:web_site_url] = place_detail_data['result']['website']
    # Googleのレビュー点数
    result[:rating] = place_detail_data['result']['rating']
    # 画像
    result[:image] = place_detail_data['result']['photos'].first['photo_reference'] if place_detail_data['result']['photos'].present?
    # 緯度・経度
    result[:latitude] = place_detail_data['result']['geometry']['location']['lat']
    result[:longitude] = place_detail_data['result']['geometry']['location']['lng']

    # 生成したハッシュを返す
    result
  end
end
