class DevelopmentResultsController < ApplicationController
  before_filter :authenticate_user

  def show
    @development_result = DevelopmentResult.find(params[:id])

    respond_to do |format|
      #format.html # show.html.erb
      format.json { render json: @development_result }
    end
  end
  
  def create
    @development_result = DevelopmentResult.new(params[:development_result])

    respond_to do |format|
      if @current_user.sw_developer
        @development_result.sw_developer = @current_user.sw_developer

        uploaded_ios = params[:files]

        #folder_path = "public/data"
	folder_path = Rails.root.join('public', 'data')
        FileUtils.mkdir_p(folder_path) unless File.exists?(folder_path)

        uploaded_ios.each do |uploaded_io|
          uploaded_io.each do |uploaded_file|
            if uploaded_file.class.name.include? ("UploadedFile")
              filename = Time.now.to_formatted_s(:number) + "_" + uploaded_file.original_filename
              path = File.join(folder_path, filename)
              File.open(path, "wb") { |f| f.write(uploaded_file.read) }

              result_file = ResultFile.new(:path => filename)
              @development_result.result_files << result_file
            end
          end
        end


        if @development_result.save
          format.json { redirect_to :back }
        end
      else
        format.json { render json: @development_result.errors, status: :unprocessable_entity }
      end
    end

  end

  def destroy
    @development_result = DevelopmentResult.find(params[:id])
    @development_result.destroy

    respond_to do |format|
      #format.html { redirect_to development_results_url }
      format.json { head :no_content }
    end
  end

end
