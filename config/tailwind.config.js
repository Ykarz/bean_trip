const defaultTheme = require('tailwindcss/defaultTheme')

module.exports = {
  // tailwindでスタイルを当てるファイルを指定
  content: [
    './public/*.html',
    './app/helpers/**/*.rb',
    './app/javascript/**/*.js',
    './app/views/**/*.{erb,html}'
  ],
  // 動的に生成されるクラスはデフォルトだと、適切にビルドされないので、'safelist'に記述しておく
  safelist: [
    'alert-success',
    'alert-error',
    'alert-warning',
    'alert-info',
  ],
  theme: {
    colors: {
      'black': '#2a1e16',
      'white': '#faf8f5',
    },
    extend: {
      // フォントサイズを設定（1rem=16px）、text-{フォントサイズのクラス名}でフォントサイズを指定
      fontSize: {
        '3xl': '1.75rem',  // 28px
        '4xl': '2rem',  // 32px
        '5xl': '2.5rem', // 40px
      },
      // フォントファミリーを設定、font-{フォントファミリーのクラス名}で指定
      fontFamily: {
        'body': ['Roboto'],  // 本文用のフォント
        'heading': ['Montserrat'],  // 見出し用のフォント
      },
    },
  },
  // daisyUIの設定
  daisyui: {
    darkTheme: false,
    themes: [
      {
        mytheme: {
          'primary': '#5a3825',  // メインカラー
          'primary-content': '#faf8f5',
          'secondary': '#2f4e5a',  // セカンダリーカラー：メインカラーと色相環で反対に位置する色
          'accent': '#4b674c',  // アクセントカラー
          'accent-content': '#faf8f5',
          'neutral': '#d4c9bc',  // ニュートラルカラー：無彩色（黒・白・グレー）のこと
          'base-100': '#f5e8d7',  // ベースカラー
          'base-content': '#2a1e16',
          'info': '#5f7d95',
          'info-content': '#faf8f5',
          'success': '#6d9e75',
          'success-content': '#faf8f5',
          'warning': '#b85c38',
          'warning-content': '#faf8f5',
          'error': '#8b2f2f',
          'error-content': '#faf8f5',
        },
      },
    ],
  },
  plugins: [
    require('daisyui')  // daisyUIをTailwindにインストール
    // require('@tailwindcss/forms'),
    // require('@tailwindcss/typography'),
    // require('@tailwindcss/container-queries'),
  ]
}
