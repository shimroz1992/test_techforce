# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApiController
      swagger_controller :users, 'User Management'

      def self.add_common_params(api)
        api.param :form, 'user[name]', :string, :optional, 'Name'
        api.param :form, 'user[email]', :string, :optional, 'Email'
      end

      swagger_api :index do
        summary 'Fetches all User items'
        notes 'This lists all the active users'
      end

      swagger_api :show do
        summary 'Fetches user by id'
        notes 'Find user by id'
        param :path, :id, :integer, :optional, 'User Id'
        response :unauthorized
        response :not_acceptable, 'The request you made is not acceptable'
        response :requested_range_not_satisfiable
      end

      swagger_api :create do |api|
        summary 'Create a new User item'
        notes 'Notes for creating a new User item'
        Api::V1::UsersController.add_common_params(api)
        response :unauthorized
        response :not_acceptable
        response :unprocessable_entity
      end

      # GET /v1/users
      def index
        render json: User.all
      end

      def show
        user = User.find(params[:id])
        if user.present?
          render json: user
        else
          render json: { message: "User can't be found!" }
        end
      end

      # POST /users
      def create
        @user = User.new(user_params)
        # debugger
        if @user.save
          @user.update(password: params[:password])
          render json: @user, status: :created
        else
          render json: { errors: @user.errors.full_messages },
                 status: :unprocessable_entity
        end
      end

      def sign_in
        user = User.find_by(email: params[:user][:email])
        if user.blank?

          render json: { message: "User can't be found!" }
          return
        end
        unless user.valid_password?(params[:password])
          render json: { message: 'Invalid password' }
          return
        end
        token = JsonWebToken.encode(user_id: user.id)
        time = Time.now + 24.hours.to_i
        redirect_path = user.is_admin? ? 'admin' : 'home'
        render json: { token:, exp: time.strftime('%m-%d-%Y %H:%M'),
                       user:, redirect_url: redirect_path }, status: :ok
      end

      private

      # Use callbacks to share common setup or constraints between actions.
      def set_user
        @user = User.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def user_params
        params.require(:user).permit(:email, :password, :last_name, :first_name, :user_name, :password_confirmation)
      end
    end
  end
end
