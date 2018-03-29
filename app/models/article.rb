class Article < ApplicationRecord
  # sets up the ActiveRecord association between Articles and Comments. This shows that Comments belong to an Article and an Article has many Comments. In the comments.rb file, there will be a belongs_to :article line as the other end of this association. When we delete an article, we want all associated comments to be deleted as well, so we pass the option dependent: :destroy to let rails know to delete any comments associated with this article if the article is deleted.
  has_many :comments, dependent: :destroy

  # the :title attribute of the Article must exist and must be at least 5 characters long or it will not be stored in the db.
  validates :title, presence: true,
                    length: { minimum: 5 }
end
