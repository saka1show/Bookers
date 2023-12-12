class BooksController < ApplicationController
  def new
    @book = Book.new
  end

  def create
    @book = Book.new(book_params)
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book.id)
    else
      flash.now[:error] = "Error: Book cloud not be saved."
      @books = Book.all
      render :index
    end
  end

  def index
    @books = Book.all
    @book =Book.new
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    book = Book.find(params[:id])
    if book.update(book_params)
      flash[:notice] = "Book was successfully updated."
      redirect_to book_path(book.id)
    else
      flash.now[:notice] = "Error: Book cloud not be updated."
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    if book.destroy
      flash[:notice] = "Book was successfully destroyed."
      redirect_to '/books'
    else
      flash.now[:notice] = "Error: Book cloud not be destroyed."
      render :books
    end
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end
end
