class GameController < ApplicationController

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
        @player1 = Player.find_by(id: params[:params][:id])
        @player1.color = "#EC7063"
        @player1.piece = "X"
        @board.players << @player1
        if (@board.save && @player1.save)
            render status: 200, json: { message: "Se creo la partida exitosamente", board: @board, players: @board.players }
        else
            render status: 500, json: { message: "Hubo un error creando la partida", error: @board.errors.details }
        end
    end

    def join_game
        @board = Board.find_by(token: params[:params][:token])
        if @board.players.length == 2
            render status: 500, json: { message: "Ya hay dos jugadores en esta partida", board: @board, players: @board.players } and return
        end
        @player2 = Player.find_by(id: params[:params][:id])
        @player2.color = "#5DADE2"
        @player2.piece = "O"
        @board.players << @player2
        if (@board.save && @player2.save)
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
                render status: 500, json: { message: "Hubo un error haciendo el movimiento", error: @board.errors.details }
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

    def player_params
        params.require(:params).permit(:name)
    end

    def move_params
        params.require(:params).permit(:player, :move, :game_piece)
    end
end
