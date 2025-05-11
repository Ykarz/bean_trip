class BeanImageUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick

  # CarrierWaveで'MiniMagick'を扱うための設定
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  # ローカルストレージを使うなら、'storage :file'を選択
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # 画像がアップロードされていない場合のデフォルト画像を設定
  # 'app/assets/images'配下にファイルを配置し、そのファイル名を記述
  def default_url(*args)
    'coffee_bean_sample'
  end

  # Process files as they are uploaded:
  process resize_to_fit: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # 画像のリサイズを'version'という単位で管理できる
  # 投稿カードに表示するユーザーアイコンのサイズ
  version :icon_on_card do
    process resize_to_fit: [40, 40]
  end

  # 投稿カードに表示する画像のサイズ
  version :image_on_card do
    process resize_to_fit: [300, 200]
  end

  # Add an allowlist of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # 許容する拡張子を設定
  def extension_allowlist
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
end
