class DiagnosesController < ApplicationController
  # 何も回答されていない状態でフォームが送信された場合の例外処理
  rescue_from ActionController::ParameterMissing, with: :diagnosis_params_is_missing

  # 診断フォームを表示
  def new; end

  # 診断フォームが送信された時の処理
  def create
    if diagnosis_params[:q1].blank? || diagnosis_params[:q2].blank? || diagnosis_params[:q3].blank?
      flash.now[:alert] = t('diagnoses.create.failure')
      render :new, status: :unprocessable_entity
    else
      answer = diagnosis_params[:q1] + diagnosis_params[:q2] + diagnosis_params[:q3]
      flash[:notice] = t('diagnoses.create.success')
      redirect_to diagnosis_path(answer)
    end
  end

  # 診断結果を表示
  def show
    @answer = params[:id]
  end

  private

  def diagnosis_params
    params.require(:diagnosis).permit(:q1, :q2, :q3)
  end

  # 'ActionController::ParameterMissing'エラーが発生した時に、呼び出されるメソッド
  def diagnosis_params_is_missing
    flash[:alert] = t('diagnoses.create.failure')
    redirect_to new_diagnosis_path
  end
end
