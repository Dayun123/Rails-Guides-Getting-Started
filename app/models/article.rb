class Article < ApplicationRecord
  # sets up the ActiveRecord association between Articles and Comments. This shows that Comments belong to an Article and an Article has many Comments. In the comments.rb file, there will be a belongs_to :article line as the other end of this association.
  has_many :comments

  # the :title attribute of the Article must exist and must be at least 5 characters long or it will not be stored in the db.
  validates :title, presence: true,
                    length: { minimum: 5 }
end
