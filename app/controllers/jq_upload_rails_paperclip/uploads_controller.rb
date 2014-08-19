module JqUploadRailsPaperclip
  class UploadsController < ApplicationController
    before_action :authenticate_user!

    def create
      @upload = current_user.uploads.build

      @upload.assign_attributes upload_params
      @upload.file = params[:files].first

      if @upload.save
        render :show
      else
        render json: { error: 'failure', errors: @upload.errors.full_messages }, status: 422
      end
    end

    private

    def upload_params
      params.require(:survey).permit :target_type, :target_attr
    end
  end
end
