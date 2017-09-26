class Admin::DefinitionsController < Admin::AdminController
  def index
    @definitions = Definition.all
  end

  def show
    @definition = Definition.find(params[:id])
  end

  def new
    @definition = Definition.new
  end

  def create
    @definition = Definition.new(definition_params)
    if @definition.save
      flash[:success] = 'Definition created'
      redirect_to admin_definition_path(@definition.id)
    else
      flash[:error] = @definition.errors.full_messages.join('. ')
      render :new
    end
  end

  def edit
    @definition = Definition.find(params[:id])
  end

  def update
    @definition = Definition.find(params[:id])
    if @definition.update_attributes(definition_params)
      flash[:success] = 'Definition updated'
      redirect_to admin_definition_path(@definition.id)
    else
      flash[:error] = @definition.errors.full_messages.join('. ')
      render :edit
    end
  end

  def destroy
    @definition = Definition.find(params[:id])
    @definition.destroy
    redirect_to admin_definitions_path
  end

  private

    def definition_params
      params.require(:definition).permit(:text)
    end
end