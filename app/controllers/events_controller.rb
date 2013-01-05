class EventsController < ApplicationController
  def index
  end

  def new
  	@event = Event.new
  end

  def create
  	@event = Event.new(params[:event])
  	@event.save
  end

  def index
  	@events = Event.all
  end

  def show
    @event = Event.find(params[:id])

    respond_to do |format|
      format.html
      format.js
    end

    #render layout: false if request.xhr?
  end
end
