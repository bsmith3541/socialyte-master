class EventsController < ApplicationController
  before_filter :signed_in_user#, [:create, :destroy]
  before_filter :correct_user, only: :destroy
  

  def new
  	@event = Event.new
  end

  def create
  	@event = current_user.events.build(params[:event])
    #@event = Event.new(params[:event])
  	if @event.save
      flash[:success] = "Event created!"
      redirect_to root_url
    else
      render 'static_pages/newhome'
    end
  end

  def index
  	@events = Event.find(:all, :order => "start_time")
  end

  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html
      format.js
    end

    #render layout: false if request.xhr?
  end

  def destroy
  end

  private
  
    def correct_user
      @event = current_user.events.find_by_id(params[:id])
      redirect_to root_path if @event.nil?
    end
end
