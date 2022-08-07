require "pry"

class UsersController < ApplicationController

    def show
        user = User.find_by(id: session[:user_id])
        if user
          render json: user
        else
          render json: { error: "Not authorized" }, status: :unauthorized
        end
    end

    def create
        user = User.create(user_params)
        if user.valid?
          session[:user_id] = user.id
          render json: user, status: :created
        else
          binding.pry
          render json: { errors: [user.errors.errors] }, status: :unprocessable_entity, code: 422
        end
      end

    
    private
    
    def user_params
        params.permit(:username, :password, :image_url, :bio)
    end
end
