json.extract! race_result, :id, :racer_id, :race_id, :status, :lap_times, :created_at, :updated_at
json.url race_result_url(race_result, format: :json)