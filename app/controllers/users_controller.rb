class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]
  before_filter :correct_user, only: [:edit, :update]

  def new
  	@user = User.new
  end

  def create
  	@user = User.new(params[:user])
  	if @user.save
      sign_in @user
  		flash[:success] = "Welcome to Socialyte!"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  def edit
   # @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
    #@events = Event.find(:all, :order => "start_time")
    @events = @user.events.find(:all, :order => "start_time")
  end

  def index
    @friends = Array.new
    if current_user.token
      @rest = Koala::Facebook::API.new(current_user.token)  
      @events = @rest.fql_query("select uid,eid,rsvp_status from event_member where uid = me()")   
      @friends = @rest.get_connections("me", "friends")
      #@profile_image = @graph.get_picture("me")
      #@fbprofile = @graph.get_object("me")
    end
  end


  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  private

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in :)"
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

end
