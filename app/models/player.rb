class Player < ApplicationRecord
    validates :name, presence: true
    validates :password, presence: true, format: { with: /(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}/, message: "Must be a valid password" }

    has_and_belongs_to_many :boards

    before_create :set_token

    def set_token
        self.token = SecureRandom.uuid
    end
end
