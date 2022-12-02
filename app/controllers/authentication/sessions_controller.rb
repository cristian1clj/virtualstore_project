class Authentication::SessionsController < ApplicationController
    def new
    end

    def create
        @user = User.find_by("username = :login",{ login: params[:login] })

        # @user = User.new(user_params)

        # if @user.save
        #     redirect_to products_path, notice: 'Usuario creado'
        # else
        #     render :new, status: :unprocessable_entity
        # end
    end
end