class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy, :moderator_question]
  before_action :log_in_user, except: [:client_monitor]

  def moderator_monitor
    @questions = Question.unselected.all.order(id: :desc)
    @selected_questions = Question.selected.all.order(id: :desc)
  end
  
  def moderator_question
    respond_to do |format|
      format.html { render partial: "moderator_question_form", 
  		  locals: {question: @question}  }
    end
  end
  
  def client_monitor
    @new_question = Question.new
    @new_question.ip = request.remote_ip
    @questions = Question.approved.all.order(id: :desc)
  end

  # GET /questions
  # GET /questions.json
  def index
    @search = QuestionSearch.new filters: params[:f], page: params[:page]
    @questions = @search.results
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
  end

  # GET /questions/new
  def new
    @question = Question.new
    @question.ip = request.remote_ip
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)
    @question.ip = request.remote_ip

    respond_to do |format|
      if @question.save
        format.html do 
          flash[:success] = t(:item_created, name: t('activerecord.models.question'))
          redirect_to edit_question_path(@question)
        end
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
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
        # format.json { render :show, status: :ok, location: @question }
        format.json { render json: @question, status: :ok, location: @question }
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
      format.html { redirect_to questions_url, notice: 'Question was successfully destroyed.' }
      format.json { head :no_content }
      format.js
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:name, :from, :banned, :selected, :approved, :sequence, :question, :translation)
    end
end
