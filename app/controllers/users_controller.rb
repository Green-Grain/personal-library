class UsersController < ApplicationController
  def index
    @books = Book.get_all_by_user(current_user.id)
    render 'books/index'
  end
end
