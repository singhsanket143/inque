class QuestionsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_question, only: [:show, :edit, :update, :destroy]


  # GET /questions/1  # GET /questions/1.json

  # GET /questions/new
def show
  respond_to do |format|
    format.html{
      @question=Question.find(params[:id])
       @answer = Answer.new(question_id: params[@question.id])
      @answerfeed=@question.answerfeed @question.id

    }
    format.js{  }
  end
end
  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)
    @question.user_id = current_user.id

    respond_to do |format|
      if @question.save
         UserMailer.added_question(current_user,@question).deliver_now
        format.html { redirect_to '/', notice: 'Question was successfully created.' }
        format.js{  }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render 'home/index' }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to '/', notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:title, :content, :user_id)
    end
end
