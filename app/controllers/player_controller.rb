class PlayerController < ApplicationController
    before_action :set_player_by_name_password, only:[:login]
    before_action :set_player_by_id, only:[:logout, :show]
    before_action :check_token, only:[:logout]

    # POST /register
    def register
        @player = Player.new(player_params)
        if @player.save
        render json: @player, status: :created
        else
        render json: @player.errors, status: :unprocessable_entity
        end
    end

    # POST /login
    def login
        if !@player.nil?
            cookies[:player_id] = @player.id
            render json: @player, status: 200
        else
            render json: { message: "Jugador no encontrado" }, status: 404
        end
    end

    # GET /logout/3
    def logout
        cookies[:player_id] = nil
        render json: { message: "Cerro sesion satisfactoriamente" }, status: 200
    end

    # GET /players/1
    def show
        if !@player.nil?
            render json: @player
        else
            render json: { message: "Jugador no encontrado" }, status: 404
        end
    end

    private
        def set_player_by_name_password
            @player = Player.find_by(name: params[:name], password: params[:password])
        end

        def player_params
            params.require(:player).permit(:name, :password)
        end

        def set_player_by_id
            @player = Player.find(params[:id]) 
        end

        def check_token
            return if request.headers["Authorization"] == @player.token
            render json: { message: "Player unauthorize" }, status: 401
            false
        end
end
