# Rating of an Expert by a Client
class ExpertRating < Rating
  def ratings
    ExpertRating.where(expert_id: expert_id).average(:rate).to_f
  end
end
