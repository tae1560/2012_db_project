class ServicesController < ApplicationController

  def index
    @services = Service.all

    respond_to do |format|
      format.json { render :json => @services }
    end
  end

  def create
    @service = Service.new(params[:service])

    uploaded_ios = params[:service_file]

    last_uploaded_file = nil

    if uploaded_ios
      uploaded_ios.each do |uploaded_io|
        uploaded_io.each do |uploaded_file|
          if uploaded_file.class.name.include? ("UploadedFile")
            last_uploaded_file = uploaded_file
            filename = Time.now.to_formatted_s(:number) + "_" + uploaded_file.original_filename
            @service.service_file_path = filename
          end
        end
      end
    end

    respond_to do |format|
      if @service.save
        folder_path = Rails.root.join('public', 'data')
        FileUtils.mkdir_p(folder_path) unless File.exists?(folder_path)

        if last_uploaded_file
          path = File.join(folder_path, @service.service_file_path)
          File.open(path, "wb") { |f| f.write(last_uploaded_file.read) }
        end


        format.html { redirect_to :back, :notice => "Service was added"}
      else
        format.html { redirect_to :back, :notice => @service.errors.full_messages }
        #format.html { redirect_to :back, :notice => @result }
      end


    end
  end

  def add_service_pro_field
    @pro_field_fields = params[:pro_field_fields]
    @service = Service.find(params[:service][:id])

    @pro_field_fields.each do |pro_field_field|
      pro_field_id = pro_field_field[0].to_i
      number_of_developers = pro_field_field[1].to_i

      pro_field = ProField.find(pro_field_id)

      if number_of_developers > 0
        service_pro_field = @service.service_pro_fields.where(:pro_field_id => pro_field.id).first
        unless service_pro_field
          service_pro_field = @service.service_pro_fields.new
          service_pro_field.pro_field = pro_field
        end

        service_pro_field.number_of_developers = number_of_developers
        service_pro_field.save
      end
    end

    redirect_to :back
  end
end
