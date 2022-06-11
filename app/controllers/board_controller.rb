class BoardController < ApplicationController
    before_action :set_board_by_id

     # GET /boards/1 
    def show
        if @board.nil?
            render json: @board.errors, status: 404
        end
        render json: @board, status: 200
    end

    private
        def set_board_by_id
            @board = Board.find(params[:id])
        end
end
