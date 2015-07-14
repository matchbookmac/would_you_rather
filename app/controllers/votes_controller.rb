class VotesController < ApplicationController
  before_action :set_vote, only: [:show, :edit, :update, :destroy]



  # POST /votes
  def create
    @vote = Vote.new(vote_params)
    if @vote.save
      respond_to do |format|
        format.html { redirect_to @vote, notice: 'Your vote has been cast!' }
        format.js { flash[:notice] = 'Your vote has been cast!' }
      end
    else
      render :new
    end
  end

  # PATCH/PUT /votes/1
  def update
    if @vote.update(vote_params)
      redirect_to @vote, notice: 'Vote was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /votes/1
  def destroy
    @vote.destroy
    redirect_to votes_url, notice: 'Vote was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_vote
      @vote = Vote.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def vote_params
      params.require(:vote).permit(:user_id, :votable_id, :votable_type)
    end
end
