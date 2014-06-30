json.array!(@trial_days) do |trial_day|
  json.extract! trial_day, :id, :days
  json.url trial_day_url(trial_day, format: :json)
end
