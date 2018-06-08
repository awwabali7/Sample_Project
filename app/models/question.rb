class Question < ActiveRecord::Base
  has_many   :answers,dependent: :destroy
  belongs_to :user
  validates  :title,presence: true
  enum category: { cs: "cs" , ee: "ee" }

  def self.get_question_answers_count
  	joins("LEFT OUTER JOIN answers on questions.id=answers.question_id").group("questions.id").select("questions.*, count(answers.id) as total_answers")
  end
  
  def self.search_questions_with_title( search_title )
  	where("title LIKE ?","%#{search_title}%")
  end

  def self.filter( options )
    @questions = Question.all.get_question_answers_count
    where_hash = Hash.new
    where_hash[:title] = options[:search] if options[:search].present?
    where_hash[:category] = options[:category] if options[:category].present?
    @questions = @questions.where(where_hash)
    @questions = @questions.order("#{options[:sort_by]} #{options[:sorting_order]}") if options[:sort_by].present? && options[:sorting_order].present?
    @questions = @questions.having("total_answers=?",options[:answer_count])
  end

end
