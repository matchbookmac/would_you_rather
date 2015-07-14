class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]

  before_filter :ensure_owner!, only: [:edit, :update, :delete]

  # GET /questions
  def index
    @questions = Question.all
  end

  # GET /questions/1
  def show
  end

  # GET /questions/new
  def new
    @question = Question.new
    (1..2).each { |i| @question.options.build }
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  def create
    @question = Question.new(question_params)

    @options = []
    question_params[:options_attributes].each do |option|
      @options << Option.new(option[1])
    end

    result = Question.transaction do
      @options.each do |option|
        option.question = @question
      end
      result = @question.save
    end

    if result

      respond_to do |format|
        format.html { redirect_to questions_path, notice: 'Question was successfully created.' }
        format.js { flash[:notice] = 'Question was successfully created.' }
      end
    else
      render :new
    end
  end

  # PATCH/PUT /questions/1
  def update
    if @question.update(question_params)
      respond_to do |format|
        format.html { redirect_to questions_path, notice: 'Question was successfully updated.' }
        format.js { flash[:notice] = 'Question was successfully updated.' }
      end
    else
      render :edit
    end
  end

  # DELETE /questions/1
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url, alert: 'Question was successfully destroyed.' }
      format.js { flash[:alert] = 'Question was successfully destroyed.' }
    end
  end

private
  # Use callbacks to share common setup or constraints between actions.
  def set_question
    @question = Question.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def question_params
    params.require(:question).permit(:user_id, { options_attributes: [:id , :query] })
  end

  def ensure_owner!
    unless @question.user == current_user || current_user.admin?
      flash[:alert] = "You do not have the permissions to perform that action"
      redirect_to root_path

      return false
    end
  end
end
