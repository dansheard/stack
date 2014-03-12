class Story < ActiveRecord::Base
  # lets make the code know that there's a relationship
  # between the story and comment
  has_many :comments

  # another relationship between story and votes
  has_many :votes


  # make sure the data in the database is exactly what we want it to be
  validates :title, presence: true, 
    length: { minimum: 5, message: "must be over 5 characters long" }
  validates :link,  presence: true, uniqueness: true

end
