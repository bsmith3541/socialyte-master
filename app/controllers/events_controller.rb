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
end
