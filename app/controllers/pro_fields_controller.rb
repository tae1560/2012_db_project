class ProFieldsController < ApplicationController
  def index
    @pro_field = ProField.all

    respond_to do |format|
      format.json { render json: @pro_field }
    end
  end

  def show
    @pro_field = ProField.find(params[:id])

    respond_to do |format|
      #format.html # show.html.erb
      format.json { render json: @pro_field }
    end
  end

  def create
    @pro_field = ProField.new(params[:pro_field])

    respond_to do |format|
      if @current_user.sw_developer
        @pro_field.sw_developer = @current_user.sw_developer

        uploaded_ios = params[:files]

        folder_path = "public/data"
        FileUtils.mkdir_p(folder_path) unless File.exists?(folder_path)

        uploaded_ios.each do |uploaded_io|
          uploaded_io.each do |uploaded_file|
            if uploaded_file.class.name.include? ("UploadedFile")
              filename = Time.now.to_formatted_s(:number) + "_" + uploaded_file.original_filename
              path = File.join(folder_path, filename)
              File.open(path, "wb") { |f| f.write(uploaded_file.read) }

              result_file = ResultFile.new(:path => filename)
              @pro_field.result_files << result_file
            end
          end
        end



        if @pro_field.save
          format.json { redirect_to :back }
        end
      else
        format.json { render json: @pro_field.errors, status: :unprocessable_entity }
      end
    end

  end

  def destroy
    @pro_field = ProField.find(params[:id])
    @pro_field.destroy

    respond_to do |format|
      #format.html { redirect_to pro_fields_url }
      format.json { head :no_content }
    end
  end
end
