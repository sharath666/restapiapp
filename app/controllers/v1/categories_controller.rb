class V1::CategoriesController < ::V1::ApplicationController
    before_action :authenticate_request
    before_action :set_category, only: [:update,:show,:destroy]
  before_action :check_category, only: [:create,:update]

    def index
        @categories = Category.all
        render json:@categories
    end
    
    def create
        if @errors.empty?
    
            @category = Category.new(category_params)
            if @category.save
                render json:@category
                  else
                render json: @category.errors, status: :unprocessable_entity
            end
          else
            render json:@errors
          end
    end

    def update
            if @errors.empty?
                if @category.present?
            @category.update(category_params)
              render json: (@category)
                else
                    render json:{message:"The category is not present in the db"}
                end
            else
              render json: @errors, status: :unprocessable_entity
            end
    end

    def show
        if @category.present?
    render json:@category
    else
        render json:{message:"The category is not present in the db"}
    end
    end

    def destroy
        if @category.present?
        @category.destroy
        render json: {message:"The Category has been deleted"}
        else
        render json: {message:"The category has already been deleted"}
        end
    end

private
  def set_category
    @category = Category.find_by_id(params[:id])
  end

    def check_category
    @errors = {}
        if params[:name].nil? || params[:name].empty?
        @errors[:name] = "Category name is required"
        else
        name = params[:name]
        end
    end

def category_params
    params.permit(:name)

end
    
end