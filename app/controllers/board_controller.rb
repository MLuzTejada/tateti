class BoardController < ApplicationController

     # GET /boards/1 
     def show
        @board = Board.find(params[:id])
        render json: @board
    end
end
