class Article < ApplicationRecord
  # the :title attribute of the Article must exist and must be at least 5 characters long or it will not be stored in the db.
  validates :title, presence: true,
                    length: { minimum: 5 }
end
