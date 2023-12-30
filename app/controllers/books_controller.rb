class BooksController < ApplicationController

  def show
    @book = Book.find(params[:id])
    @user = @book.user 
    @book_new = Book.new
  end

  def index
    @books = Book.all
    @book = Book.new
    @user = current_user
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book)
    else
      @books = Book.all
      @user = current_user
      render :index
    end
  end

  def edit
    @book = Book.find(params[:id])
    unless @book.user_id == current_user.id
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
  if @book.update(book_params)
    redirect_to book_path(@book), notice: "You have updated book successfully."
  else
    logger.error @book.errors.inspect  # エラーログの出力
    render :edit
  end
  end

  def destroy
    @book = Book.find(params[:id])
  @book.destroy
  flash[:notice] = "Book was successfully destroyed."
  redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
