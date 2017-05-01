class ListsController < ApplicationController
  expose :list
  expose(:lists) { List.all }

  def index
    respond_to :html, :json
  end

  def create
    if list.save
      render json: list
    else
      render json: list.errors, status: :unprocessable_entity
    end
  end

  private

  def list_params
    params.require(:list).permit(:description,:completion_units)
  end
end
