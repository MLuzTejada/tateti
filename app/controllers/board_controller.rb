class BoardController < ApplicationController
    before_action :set_board_by_player_id

    # GET /boards/1 
    def show
        if @board.nil?
            render json: { message: "Tablero no encontrado" }, status: 404
        end
        render json: @board, status: 200
    end

    private
        def set_board_by_player_id
            @board = Player.find(params[:id]).boards.last
        end
end
