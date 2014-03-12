class Vote < ActiveRecord::Base
  # let the vote know about the story its attached to
  # and let the story keep track of how many votes it has
  belongs_to :story, counter_cache: true

  # what we want to do is check that the IP address is
  # unique for that story
  validates :ip_address, uniqueness: { scope: :story_id }

  # if we had just uniqueness is true that would mean 1 vote
  # accross the whole site per IP address. This way we can do
  # 1 vote per story per IP address

end
