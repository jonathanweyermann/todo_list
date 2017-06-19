class ListsController < ApplicationController
  expose :list
  expose(:lists) { List.all }
  expose(:chart_data) { List.all.map { |m| ChartSerializer.new(m, {root: false}).serializable_hash }.sort_by {|n| n[:name] } }

  def index
    respond_to do |format|
      format.html {}
      format.json { render json: chart_data }
    end
  end

  def create
    if list.save
      render json: list
    else
      flash[:alert] = list.errors
      render json: list.errors, status: :unprocessable_entity
    end
  end

  def update
    if list.update(list_params)
      render json: list
    else
      flash[:alert] = list.errors
      render json: list.reload
    end
  end

  def destroy
    list.destroy
    head :no_content
  end


  private

  def list_params
    params.require(:list).permit(:description, :completion_units, :finished_completion_units)
  end
end
