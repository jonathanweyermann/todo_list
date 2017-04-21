class ListsController < ApplicationController
  expose :list

  def index
    respond_to :html, :json
  end

  def create

    binding.pry
    list.save
  end

  private

  def list_params
    params.require(:list).permit(:name,:completion_units)
  end
end
