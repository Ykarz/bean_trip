class StoresController < ApplicationController
  def index
    @q = Store.ransack(params[:q])
    @stores = @q.result(distinct: true)
  end

  def show
    @store = Store.find(params[:id])
    @beans = @store.beans.includes(:user, :country)
    @photo_reference = get_place_photo_reference(@store.place_id)
  end
end

  private

  # 店舗の写真を表示するためにAPIを叩いて、'photo_reference'を取得するメソッド
  def get_place_photo_reference(place_id)
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

    # 取得した場所データから'photo_reference'を抽出
    photo_reference = place_detail_data['result']['photos']&.first&.dig('photo_reference')

    # 取得した'photo_reference'を返す
    photo_reference
  end
end
