class Question < ActiveRecord::Base
  belongs_to :user
  has_many :answers ,dependent: :destroy
  validates :title ,presence: true,length:{maximum:140}

  def answerfeed question_id
    	Answer.where(question_id: question_id).order(created_at: :desc)
  end
end
