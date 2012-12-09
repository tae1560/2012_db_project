class ServicesController < ApplicationController

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
end
