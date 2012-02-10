class UsersController < ApplicationController
  oauthenticate :except => [:new, :create]
  #before_filter :test
  authorize_resource

  def test
    puts "Im in UsersController"
    puts current_user
    puts current_token.inspect
    puts current_client_application.inspect
  end

  def index
    @users = User.all
  end

  def show
    params[:id] = current_user.id if current_user and params[:id] == 'me'
    @user = User.find(params[:id])

    respond_to do |format|
      format.html
      format.json do
        u = {
          :login => @user.login, :uid => @user.id,
          :email => @user.email,
          :groups => @user.groups.map {|g| g.name}
        }
        render :json => u
      end
    end

  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to @user, :notice => "Successfully created user."
    else
      render :action => 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      redirect_to @user, :notice  => "Successfully updated user."
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_url, :notice => "Successfully destroyed user."
  end
end
