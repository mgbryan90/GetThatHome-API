class SavedPropertiesController < ApplicationController
  before_action :authenticate_user!
  def index
    return render status: :unprocessable_entity unless current_user.role_name == "Homeseeker"
    @saved_properties = SavedProperty.where(user: current_user) # array
    render json: @saved_properties
  end

  def update
    return render status: :unprocessable_entity unless current_user.role_name == "Homeseeker"
    @saved_property = SavedProperty.find_by(user: current_user,id: params[:id]) 

    if @saved_property.update(saved_properties_params)
      render status: :ok
    else
      render json: @saved_property.errors, status: :unprocessable_entity
    end
  end
  
  private

  def saved_properties_params
    params.permit(:favorite, :contacted)
  end
end
