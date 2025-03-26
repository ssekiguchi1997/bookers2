class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id

    if @book.save
      flash[:notice] = "Book was successfully created"
      redirect_to books_path
    else
      flash[:notice] = "error"
      @books= Book.all
      render :index
    end
  end

  def index
    @books = Book.page(params[:page])
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @createbook = Book.new
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  def edit
    @book = Book.find(params[:id])
  end
  
  def update
    @book = Book.find(params[:id])
    if 
      @book.update(book_params)
      flash[:notice] = "Your Editing was successfully updated"
      redirect_to book_path(@book.id)
    else
      flash[:notice] = "error"
      render :edit
    end

  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

end
