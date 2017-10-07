json.extract! race_result, :id, :racer_id, :race, :status, :lap_times, :created_at, :updated_at, :finish_time, :points
json.url race_result_url(race_result, format: :json)
