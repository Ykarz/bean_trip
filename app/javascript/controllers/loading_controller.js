import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="loading"
export default class extends Controller {
  // loadingコントローラーのターゲット(DOM要素)を定義
  static targets = [ "spinner" ]

  // コントローラーが接続されたときに実行されるメソッド
  connect() {
    this.hide()
  }

  // ローディングアニメーションを表示するメソッド
  show() {
    this.spinnerTarget.classList.remove("hidden")
}
  // ローディングアニメーションを非表示にするメソッド
  hide() {
    this.spinnerTarget.classList.add("hidden")
  }
}
