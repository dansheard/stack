class Comment < ActiveRecord::Base

  # let the comment know about the story its attached to
  belongs_to :story

  validates :body, presence: true

end
