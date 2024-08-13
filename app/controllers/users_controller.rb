class UsersController < ApplicationController
  before_action :set_user, only: [ :show, :edit, :update, :destroy ]
  before_action :require_user, only: [ :edit, :update, :destroy ]
  before_action :require_same_user, only: [ :edit, :update, :destroy ]

  # GET /users or /users.json
  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end

  # GET /users/1 or /users/1.json
  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 5)
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users or /users.json
  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Hello #{@user.username}, welcome to the Alpha Blog, you have successfuly signed up"
      redirect_to home_path
    else
      render "new", status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1 or /users/1.json
  def update
    if @user.update(user_params)
      flash[:notice] = "You have successfuly updated your information"
      redirect_to @user # or user_path(@user)
    else
      render "edit", status: :unprocessable_entity
    end
  end

  # DELETE /users/1 or /users/1.json
  def destroy
    @user.destroy
    session[:user_id] = nil if @user == current_user
    flash[:notice] = "Account and all associated articles successfuly deleted"
    redirect_to articles_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end

    def require_same_user
      if current_user != @user && !current_user.admin?
        flash[:alert] = "you can only edit and delete your own account"
        redirect_to @user
      end
    end
end
