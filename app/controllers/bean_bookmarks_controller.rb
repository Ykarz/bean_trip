class BeanBookmarksController < ApplicationController
  # 豆投稿のブックマークを行うアクション
  def create
    # リンクから送られてきた'bean_id'をもとに、Beanモデルのインスタンス（該当する豆投稿）を取得
    bean = Bean.find(params[:bean_id])
    current_user.bookmark_bean(bean)
    redirect_to beans_path, notice: t('.success')
  end

  # 豆投稿のブックマークを解除するアクション
  def destroy
    # リンクから送られてきた'id（bean_bookmarksテーブルのid）'をもとに、BeanBookmarkモデルのインスタンスを取得し、
    # そこから関連付けられたBeanモデルのインスタンス（該当する豆投稿）を取得
    bean = current_user.bean_bookmarks.find(params[:id]).bean
    current_user.unbookmark_bean(bean)
    redirect_to beans_path, notice: t('.success'), status: :see_other
  end
end
