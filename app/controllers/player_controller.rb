class PlayerController < ApplicationController
    before_action :set_player_by_name_password, only:[:login]
    # before_action :check_token, only:[:show]

    def register
        @player = Player.new(player_params)
        if @player.save
        render json: @player, status: :created
        else
        render json: @player.errors, status: :unprocessable_entity
        end
    end

    def login
        # session[:player_id] = @player.id
        # puts("session login: ", session[:player_id])
        if !@player.nil?
            puts("player: ", @player)
            render json: @player, status: 200
        else
            render json: @player.errors, status: 404
        end
    end

    def logout
        session[:player_id] = nil #ver como hacer esto
        render json: {message: "Cerro sesion satisfactoriamente"}, status: 200
    end

    # GET /players/1
    def show
        @player = Player.find(params[:id])
        render json: @player
    end

    private
        def set_player_by_name_password
            @player = Player.find_by(name: params[:name], password: params[:password])
        end

        def player_params
            params.require(:player).permit(:name, :password)
        end

        def check_token
            return if request.headers["Authorization"] == @player.token
            render json: { message: "Player unauthorize" }, status: 401
            false
        end
end
