class SearchesController < ApplicationController
  def show
    @entry = Entry.new
  end

  def create
    # debugger
    @entry = Entry.lookup(word: entry_params[:word])
    respond_to do |format|
      format.js
    end
  end

  private

    def entry_params
      params.require(:entry).permit(:word)
    end
end