class Admin::VolunteersController < ApplicationController
  before_filter :authenticate
  
  # GET /admin/volunteers
  # GET /admin/volunteers.xml
  def index
    @volunteers = Volunteer.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @volunteers }
    end
  end

  # DELETE /admin/volunteers/1
  # DELETE /admin/volunteers/1.xml
  def destroy
    @volunteer = Volunteer.find(params[:id])
    @volunteer.destroy

    respond_to do |format|
      format.html { redirect_to(admin_volunteers_url) }
      format.xml  { head :ok }
    end
  end
  
  
  def export
    volunteers = Volunteer.all
    sessions = Session.all
    csv_string = FasterCSV.generate do |csv| 
      headers = ["Name", "Email", "Phone"]
      sessions.each do |s|
        headers << s.name
      end
      csv << headers
      volunteers.each do |volunteer|
        row = [volunteer.name, volunteer.email, volunteer.phone]
        sessions.each do |s| 
          if volunteer.sessions.include? s
            row << "Yes"
          else
            row << ""
          end
        end
        csv << row
      end
    end
    send_data csv_string, :type => "text/plain", :filename=> "volunteers.csv", :disposition => 'attachment'
  end
end
