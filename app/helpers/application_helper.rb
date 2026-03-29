module ApplicationHelper
  # 適切なdaisyUIのコンポーネントを呼び出すため、フラッシュメッセージのキーの変換を行うためのメソッド
  # 'devise'のフラッシュメッセージのキーは、失敗系が:alertで、成功系が:noticeらしい
  def flash_type(key)
    case key.to_sym
    when :alert
      'warning'
    when :notice
      'success'
    end
  end

  # フラッシュメッセージのキーに応じて、svgのパスを生成するメソッドを定義
  def flash_icon_path(key)
    case key.to_sym
    when :alert
      'M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z'
    when :notice
      'M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z'
    when :error
      'M10 14l2-2m0 0l2-2m-2 2l-2-2m2 2l2 2m7-2a9 9 0 11-18 0 9 9 0 0118 0z'
    end
  end

  # SEO対策用のmetaタグを生成するためのメソッド
  def default_meta_tags
    {
      site: 'Bean Trip',
      title: 'あなたに合うコーヒー豆と出会う',
      reverse: true,
      charset: 'utf-8',
      description: 'Bean Tripは、コーヒー豆の診断や検索、投稿ができるコーヒー豆選びに特化したサービスです。',
      keywords: 'コーヒー, コーヒー豆, 焙煎所, カフェ, 診断, 検索, 投稿',
      canonical: 'https://bean-trip.onrender.com',
      separator: '|',
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: 'https://bean-trip.onrender.com',
        image: image_url('ogp.png'),
        local: 'ja_JP'
      },
      twitter: {
        card: 'summary_large_image',
        site: '@basket_blhlc',
        image: image_url('ogp.png')
      }
    }
  end

  # 本番環境のURLを返すメソッド
  def production_url
    'https://bean-trip.onrender.com'
  end

  # 各ページのタイトルを動的に生成するためのメソッド
  def page_title(title = '')
    base_title = 'Bean Trip'
    title.present? ? "#{title} | #{base_title}" : base_title
  end
end
