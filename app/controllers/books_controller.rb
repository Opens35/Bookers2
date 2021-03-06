class BooksController < ApplicationController
    
  def new
      @book = Book.new
  end

  def create
      @book = Book.new(book_params)
      @books = Book.all
      @book.user_id = current_user.id
      if @book.save
        redirect_to book_path(@book.id)
        flash[:notice] = "successfully"
      else
        @user = current_user
        render :index
      end
  end

  def index
      @books = Book.all
      @book = Book.new
      @user = current_user
      @users = User.all
  end
  
  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render "edit"
    else
      redirect_to books_path
    end
  end
  
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book)
      flash[:notice] = "successfully"
    else
      render:edit
    end
  end

  def show
      @book = Book.find(params[:id])
      @users = User.all
      @user = current_user
      @book_comment = BookComment.new
  end

  def destroy
      @book = Book.find(params[:id])
      @book.destroy
      redirect_to books_path
  end
  
  def users
    @user = User.find(params[:id])
  end
    
  private
  
  def book_params
      params.require(:book).permit(:title, :body)
  end
  
end