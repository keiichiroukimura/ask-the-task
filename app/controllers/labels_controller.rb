class LabelsController < ApplicationController
  before_action :set_label, only: [:destroy]
  def new
    @label = Label.new
    @labels = Label.all
  end

  def create
    @label = Label.new(label_params)
    if @label.save
      redirect_to new_label_path , notice: 'ラベルを作成'
    else
      render 'new'
    end
  end

  def destroy
    @label.destroy
    redirect_to new_label_path, notice: 'ラベルを削除しました。'
  end


  private

  def label_params
    params.require(:label).permit(:content, :task_id)
  end
  
  def set_label
    @label = Label.find(params[:format])
  end
end
