class UsersController < ApplicationController
  def index
    user = User.find(current_user.id)
    @books = user.books.includes(:publisher, :authors, :evaluations)
    render 'books/index'
  end
end
