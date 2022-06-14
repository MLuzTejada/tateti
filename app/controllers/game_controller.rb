class GameController < ApplicationController
    before_action :get_player_by_id, only:[:new_game, :join_game, :make_move, :other_round]
    before_action :check_token

    WINNING_POSITIONS = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [6,4,2]
    ]

    # POST /new_game 
    def new_game
        @board = Board.new()
        @player.color = "#EC7063"
        @player.piece = "X"
        @player.score = 0
        @board.players << @player
        if (@board.save && @player.save)
            render status: 200, json: { message: "Se creo la partida exitosamente", board: @board, players: @board.players }
        else
            render status: 500, json: { message: "Hubo un error creando la partida", error: @board.errors || @player.errors }
        end
    end

    # POST /join_game
    def join_game
        @board = Board.find_by(token: params[:token])
        if @board.players.length == 2
            render status: 500, json: { message: "Ya hay dos jugadores en esta partida", board: @board, players: @board.players } and return
        end
        @player.color = "#5DADE2"
        @player.piece = "O"
        @player.score = 0
        @board.players << @player
        if (@board.save && @player.save)
            render status: 200, json: { message: "Se unio al juego satisfactoriamente", board: @board, players: @board.players }
        else
            render status: 500, json: { message: "Hubo un error uniendolo al juego", error: @board.errors || @player.errors }
        end
    end

    # POST /other_round
    def other_round
        @board = Board.find_by(token: params[:token])
        @new_board = Board.new()
        @new_board.turn = "X"
        @new_board.players << @board.players
        if @new_board.save
            render status: 200, json: { message: "Se creo otra ronda satisfactoriamente", board: @new_board, players: @new_board.players }
        else
            render status: 500, json: { message: "Hubo un error creando otra ronda", error: @new_board.errors }
        end  
    end

    # POST /make_move
    def make_move
        @board = Board.find_by(token: params[:token])
        if @board.squares[params[:move]].nil?
            @board.squares[params[:move]] = params[:game_piece]
            @board.colors[params[:move]] = @player.color
            return if check_winner(@board, @player)
            if @board.save
                render status: 200, json: { message: "Su movimiento se realizo con exito", board: @board }
            else
                render status: 500, json: { message: "Hubo un error haciendo el movimiento", error: @board.errors }
            end
        else
            render status: 500, json: { message: "Movimiento invalido", board: @board }
        end
    end

    def check_winner(board, player)
        WINNING_POSITIONS.each do |a,b,c|
            if(board.squares[a] && board.squares[a] == board.squares[b] && board.squares[a] == board.squares[c])
                board.turn = nil
                player.score += 1
                board.winner = player.id
                if (board.save && @player.save)
                    render status: 200, json: { message: "El jugador #{player.name} gano!", board: board }
                    return true
                end
            end

        end

        if (!board.squares.any?(nil) && board.squares.length == 9)
            board.tie = true
            board.turn = nil
            if board.save
                render status: 200, json: { message: "Es un empate", board: board}
                return true
            end
        end

        board.turn = params[:game][:game_piece] == 'X' ? 'O' : 'X'
        false
    end


    private
        def check_token
            return if request.headers["Authorization"] == @player.token
            render json: { message: "Jugador no autorizado" }, status: 401
            false
        end

        def get_player_by_id
            @player = Player.find_by(id: params[:id])
        end
end
