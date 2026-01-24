class StoreBookmarksController < ApplicationController
  # 店舗のブックマークを行うアクション
  def create
    # リンクから渡された'store_id'をもとに、Storeモデルのインスタンス（該当する店舗）を取得
    store = Store.find(params[:store_id])
    current_user.bookmark_store(store)
    redirect_to store_path(store), notice: t('.success')
  end

  # 店舗のブックマークを解除するアクション
  def destroy
    # リンクから渡された'id（store_bookmarksテーブルのid）'をもとに、StoreBookmarkモデルのインスタンスを取得
    # そこから関連付けられたStoreモデルのインスタンス（該当する店舗）を取得
    store = current_user.store_bookmarks.find(params[:id]).store
    current_user.unbookmark_store(store)
    redirect_to store_path(store), notice: t('.success'), status: :see_other
  end
end
