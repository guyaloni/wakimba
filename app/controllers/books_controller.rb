class BooksController < ApplicationController
  before_action :set_book, only: [:show, :edit, :update, :destroy, :upload_cover_image, :delete_cover_image]

  # GET /books
  # GET /books.json
  def index
    @books = Book.all
  end

  # GET /books/1
  # GET /books/1.json
  def show
  end

  # GET /books/new
  def new
    @book = Book.new
  end

  # GET /books/1/edit
  def edit
    @book_cover_image_uploader_info = {
      :id => 'book_cover_image',
      :label => "Book cover image",
      :hint => "Some hint",
      :current_image => @book.cover_image,
      :current_image_url => @book.cover_image.url(:thumb),
      :delete_image_url => book_delete_cover_image_path(@book),
      :delete_confirmation => "Delete warning",
      :object => @book,
      :image_attr => :cover_image,
      :upload_url => book_upload_cover_image_path(@book),
    }

  end

  # POST /books
  # POST /books.json
  def create
    @book = Book.new(book_params)

    respond_to do |format|
      if @book.save
        format.html { redirect_to @book, notice: 'Book was successfully created.' }
        format.json { render :show, status: :created, location: @book }
      else
        format.html { render :new }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    respond_to do |format|
      if @book.update(book_params)
        format.html { redirect_to @book, notice: 'Book was successfully updated.' }
        format.json { render :show, status: :ok, location: @book }
      else
        format.html { render :edit }
        format.json { render json: @book.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /books/1
  # DELETE /books/1.json
  def destroy
    @book.destroy
    respond_to do |format|
      format.html { redirect_to books_url, notice: 'Book was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  def upload_cover_image
    @book.cover_image = params[:book][:cover_image]

    respond_to do |format|
      if @book.save
        format.html do
          render :json => @book.cover_image.url(:thumb).to_json,
                 :content_type => 'text/html',
                 :layout => false
        end
        format.json { render json: {file: @book.cover_image.url(:thumb)}, status: :created}
      else
        # delete duplicated file size error message
        if @book.errors[:cover_image_file_size] == @book.errors[:cover_image]
          @book.errors.delete(:cover_image)
        end

        format.html { render action: "new" }
        format.json { render json: @book.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def delete_cover_image
    @book.cover_image = nil
    if @book.save
      render json: 'cover image deleted', status: status
    else
      render json: 'Failed to delete cover image', status: :internal_server_error
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_book
      @book = Book.find(params[:book_id]) 
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def book_params
      params.require(:book).permit(:title, :author)
    end
end
