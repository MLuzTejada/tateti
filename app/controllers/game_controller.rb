class GameController < ApplicationController
    before_action :get_player_by_id, only:[:new_game, :join_game, :make_move]
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

    def new_game
        @board = Board.new()
        @player.color = "#EC7063"
        @player.piece = "X"
        @board.players << @player
        if (@board.save && @player.save)
            render status: 200, json: { message: "Se creo la partida exitosamente", board: @board, players: @board.players }
        else
            render status: 500, json: { message: "Hubo un error creando la partida", error: @board.errors }
        end
    end

    def join_game
        @board = Board.find_by(token: params[:token])
        if @board.players.length == 2
            render status: 500, json: { message: "Ya hay dos jugadores en esta partida", board: @board, players: @board.players } and return
        end
        @player.color = "#5DADE2"
        @player.piece = "O"
        @board.players << @player
        if (@board.save && @player.save)
            render status: 200, json: { message: "Se unio al juego satisfactoriamente", board: @board, players: @board.players }
        else
            render status: 500, json: { message: "Hubo un error uniendolo al juego", error: @board.errors.details }
        end
    end

    def other_round
        @board = Board.find_by(token: params[:params][:token])
        @new_board = Board.new()
        @new_board.players << @board.players
        if @new_board.save
            render status: 200, json: { message: "Se creo otra ronda satisfactoriamente", board: @new_board, players: @new_board.players }
        else
            render status: 500, json: { message: "Hubo un error creando otra ronda", error: @new_board.errors.details }
        end  
    end

    def make_move
        @board = Board.find_by(token: params[:token])
        @player = @board.players.find_by(piece: @board.turn)
        if @board.squares[params[:game][:move]].nil?
            @board.squares[params[:game][:move]] = params[:game][:game_piece]
            @board.colors[params[:game][:move]] = @player.color
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
                player.score =+ 1
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
        def player_params
            params.require(:params).permit(:name)
        end

        def move_params
            params.require(:params).permit(:player, :move, :game_piece)
        end

        def check_token
            return if request.headers["Authorization"] == @player.token
            render json: { message: "Jugador no autorizado" }, status: 401
            false
        end

        def get_player_by_id
            puts("player", params[:id])
            @player = Player.find_by(id: params[:id])
        end
end
