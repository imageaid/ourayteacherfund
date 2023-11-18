module Admin
  # managing users
  class UsersController < AdminController
    include UserSearchable

    before_action :set_user, only: %i[show edit update destroy]

    def index
      filters = params[:user].present? ? params[:user].slice(:first_name, :last_name, :email) : {}
      @pagy, @users = pagy(search_scope(filters: filters, model_name: 'User', order: 'last_name'), items: 12)

      respond_to do |format|
        format.html
        format.turbo_stream
      end
    end

    def show; end

    def new
      @user = User.new
    end

    def edit; end

    def create
      @user = User.new(user_params)

      if @user.save
        redirect_to admin_user_url(@user), notice: 'User was successfully created.'
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      if @user.update(user_params)
        redirect_to admin_user_url(@user), notice: 'User was successfully updated.'
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      @user.destroy
      redirect_to admin_users_url, notice: 'User was successfully destroyed.'
    end

    private

      def set_user
        @user = User.friendly.find(params[:id])
      end

      def user_params
        params.require(:user).permit(
          %i[email password password_confirmation first_name last_name role active theme_preference]
        )
      end
  end
end
