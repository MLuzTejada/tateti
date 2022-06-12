class Board < ApplicationRecord
    serialize :squares, Array
    serialize :colors, Array

    validates :token, uniqueness: true

    before_create :set_token

    has_and_belongs_to_many :players


    def set_token
        self.token = SecureRandom.hex(10)
    end
end
