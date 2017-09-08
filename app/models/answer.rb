class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :user
  has_many :comments ,dependent: :destroy
  validates :content ,presence: true,length:{maximum:200}

  def commentfeed answer_id
    	Comment.where(answer_id: answer_id).order(created_at: :desc)
  end
end
