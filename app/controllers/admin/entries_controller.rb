class Admin::EntriesController < Admin::AdminController
  def index
    @entries = Entry.all
  end

  def show
    @entry = Entry.find(params[:id])
  end

  def edit
    @entry = Entry.find(params[:id])
  end

  def update
    @entry = Entry.find(params[:id])

    if @entry.update_attributes(entry_params)
      flash[:success] = 'Entry updated'
      redirect_to admin_entry_path(@entry.id)
    else
      flash.now[:error] = @entry.errors.full_messages.join('. ')
      render :edit
    end
  end

  def new
    @entry = Entry.new
  end

  def create
    @entry = Entry.new(entry_params)
    if @entry.save
      flash[:success] = 'Entry created'
      redirect_to admin_entry_path(@entry.id)
    else
      flash.now[:error] = @entry.errors.full_messages.join('. ')
      render :new
    end
  end

  def destroy
    @entry = Entry.find(params[:id])
    @entry.destroy
    redirect_to admin_entries_path
  end

  private

    def entry_params
      params.require(:entry).permit(:word)
    end
end