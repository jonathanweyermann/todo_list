class ChartSerializer < ActiveModel::Serializer
  attributes :name, :data

  def name
    object.description
  end

  def data
    (JSON.parse (["completed": "#{((100 * object.finished_completion_units) / object.completion_units)}"].to_json)).first
  end
end
