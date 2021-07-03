class CalendarsController < ApplicationController
  before_action :authenticate_user!

  def index; end
  def new
    @calendar = Calendar.new
  end

  def edit
    @calendar = Calendar.where(user: current_user, id: params[:id]).first
  end

  def create
    Calendar.create!(calendar_params)
    render action: :index
  end

  def update
    @calendar = Calendar.where(user: current_user, id: params[:id]).first
    @calendar.update!(calendar_params)
    render action: :index
  end

  def retrieve
    @calendar = Calendar.where(user: current_user, id: params[:calendar_id]).first
    history = CalendarHistory.create!(calendar: @calendar, status: :pending, log: 'Fetching...')
    RetrieveIcsJob.perform_later(history)
    redirect_to action: :show, id: params[:calendar_id]
  end

  def show
    @calendar = Calendar.where(user: current_user, id: params[:id]).first
    @calendar_histories = @calendar.calendar_histories.order('created_at DESC')
  end

  def destroy
    ActiveRecord::Base.transaction do
      @calendar = Calendar.where(user: current_user, id: params[:id]).first
      @calendar.calendar_events.destroy_all
      @calendar.calendar_histories.destroy_all
      @calendar.destroy!
    end
    redirect_to action: :index
  end

  private
  def calendar_params
    params.require(:calendar).permit(:display_as, :url, :status, :color).merge(user_id: current_user.id)
  end
end
