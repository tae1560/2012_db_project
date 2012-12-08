class DevelopmentResultsController < ApplicationController
  before_filter :authenticate_user

  def index
    @development_result = DevelopmentResult.all

    respond_to do |format|
      format.json { render json: @development_result }
    end
  end

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

        folder_path = "public/data"
        FileUtils.mkdir_p(folder_path) unless File.exists?(folder_path)

        if uploaded_ios
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
        end

        if @development_result.save
          format.json { redirect_to :back }
        end
      else
        format.json { render json: @development_result.errors, status: :unprocessable_entity }
      end
    end

  end

  def update
    @development_result = DevelopmentResult.find(params[:id])
    @pro_fields = params[:pro_field]

    @pro_fields.each do |pro_field|
      id = pro_field[0].to_i
      selected = pro_field[1].to_i
      is_contains = @development_result.pro_fields.exists?(:id => id)

      if selected == 1 and !is_contains
        ins_pro_field = ProField.find(id)
        @development_result.pro_fields << ins_pro_field
      elsif selected == 0 and is_contains
        ins_pro_field = ProField.find(id)
        @development_result.pro_fields.delete(ins_pro_field)
      end
    end

    respond_to do |format|
      format.json { redirect_to :back }
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
