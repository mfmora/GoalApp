class GoalsController < ApplicationController
  before_action :require_user
  before_action :verify_user, only: [:edit, :update, :delete]

  def new
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id
    if @goal.save
      redirect_to user_url(@goal.user)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def edit
    @goal = Goal.find(params[:id])
  end

  def update
    @goal = Goal.find(params[:id])
    if @goal.update_attributes(goal_params)
      redirect_to user_url(@goal.user)
    else
      flash.now[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def delete
    @goal = Goal.find(params[:id])
    @goal.destroy
    redirect_to user_url(@goal.user)
  end

  private
  def goal_params
    params.require(:goal).permit(:title, :description, :private)
  end

  def verify_user
    @goal = Goal.find(params[:id])
    redirect_to user_url(current_user) unless @goal.user_id == current_user.id
  end

end
