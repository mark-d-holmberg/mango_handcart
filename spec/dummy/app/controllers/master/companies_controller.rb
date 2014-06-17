class Master::CompaniesController < MasterController
  before_action :set_company, only: [:show, :edit, :update, :destroy]

  def index
    @companies = Company.ordered.page(params[:page])
  end

  def show
  end

  def new
    @company = Company.new
  end

  def edit
  end

  def create
    @company = Company.new(safe_params)

    if @company.save
      redirect_to @company, notice: 'Company was successfully created.'
    else
      render :new
    end
  end

  def update
    if @company.update(safe_params)
      redirect_to @company, notice: 'Company was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @company.destroy
    redirect_to companies_url, notice: 'Company was successfully removed.'
  end


  private

  def set_company
    @company = Company.find(params[:id])
  end

  def safe_params
    safe_attributes =[:name, :dns_record_id, :active]
    params.require(:company).permit(safe_attributes)
  end

end
