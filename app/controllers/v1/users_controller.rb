class V1::UsersController < ::V1::ApplicationController
    before_action :authenticate_request, except: [:sign_up,:login]

def login
    user = User.find_by(email: params[:email]) 
    if user.present?  
     if user.valid_password?(params[:password])
       render json: user.as_json(only: [:email,:authentication_token])
     else
       head("Invalid Credentials")
     end
    else
        render json:{message:"The email is not registered"}
    end
 end

 def sign_up
    validate_user
    user = User.new(user_params)
    if @errors.empty? && user.valid?
      user.save
      render json: user
    else
      render json: @errors.merge(user.errors), status: :unprocessable_entity
    end
  end

 def validate_user
    @errors = {}
    if params[:email].nil? || params[:email].empty?
      @errors[:email] = "Email field is requried"
    else
       if User.find_by_email(params[:email]).present?
        @errors[:email] = "Email already exist"
      end
    end
    if params[:password].nil? || params[:password].empty?
      @errors[:password] = "Password field is requried"
    end
    if params[:confirm_password].nil? || params[:confirm_password].empty?
      @errors[:confirm_password] = "confirm_password field is requried"
    elsif params[:password] != params[:confirm_password]
      @errors[:confirm_password] = "Password doesn't match"
    end 
  end


  def user_params
    params.permit(:email,:username,:password,:first_name,:last_name, :mobile,:role, :customer_type, :adhar_no,:adhar_image, :pan_no, :pan_image,:gst_no, :gst_image, :contact_person,:designation, :company_name)
  end
end
