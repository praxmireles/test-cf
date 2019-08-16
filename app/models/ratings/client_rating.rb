# Rating of a user (client) by an Expert
class ClientRating < Rating
  def ratings
    ClientRating.where(user_id: user_id).average(:rate).to_f
  end
end
