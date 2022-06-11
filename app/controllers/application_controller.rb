class ApplicationController < ActionController::Base
    skip_before_action :verify_authenticity_token
    # before_action :set_current_user

    # def set_current_user
    #     puts("application controller: ", session[:player_id])
    #     if session[:player_id]
    #         Current.player = Player.find_by(session[:player_id])
    #     end
    # end
end
