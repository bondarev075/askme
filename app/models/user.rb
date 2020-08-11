require 'openssl'

class User < ApplicationRecord
  attr_accessor :password

  # Параметры работы модуля шифрования паролей
  ITERATIONS = 20000
  DIGEST = OpenSSL::Digest::SHA256.new

  has_many :questions

  validates :username, :email, presence: true
  validates :username, :email, uniqueness: true
  validates :username, length: { maximum: 40 }
  validates :username, format: {
      with: /\A[A-Za-z0-9_]+\z/, message: "only allows latin letters, numbers or underscores"
    }

  validates :password, presence: true, on: :create
  validates_confirmation_of :password
  validates :email, format: { with: /\A[\w\d\.-_]+@{1}[\w\d]+\.\w+\z/ }

  before_save :encrypt_password

  def encrypt_password
    if self.password.present?
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))
      self.password_hash = User.hash_to_string(OpenSSL::PKCS5.pbkdf2_hmac(self.password, self.password_salt, ITERATIONS, DIGEST.length, DIGEST))
    end
  end

  # Преобразуем бинарную строку в 16-ричный формат для удобства хранения
  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password)
    user = find_by(email: email)

    return nil unless user.present?

    pass_hash = User.hash_to_string(OpenSSL::PKCS5.pbkdf2_hmac(password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST))

    return nil unless user.password_hash == pass_hash

    user
  end
end
