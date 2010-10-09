class Admin::SessionsController < ApplicationController
  before_filter :authenticate

  # GET /admin/sessions
  # GET /admin/sessions.xml
  def index
    @sessions = Admin::Session.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sessions }
    end
  end

  # GET /admin/sessions/1
  # GET /admin/sessions/1.xml
  def show
    @session = Admin::Session.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @session }
    end
  end

  # GET /admin/sessions/new
  # GET /admin/sessions/new.xml
  def new
    @session = Admin::Session.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @session }
    end
  end

  # GET /admin/sessions/1/edit
  def edit
    @session = Admin::Session.find(params[:id])
  end

  # POST /admin/sessions
  # POST /admin/sessions.xml
  def create
    @session = Admin::Session.new(params[:session])

    respond_to do |format|
      if @session.save
        format.html { redirect_to(@session, :notice => 'Session was successfully created.') }
        format.xml  { render :xml => @session, :status => :created, :location => @session }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @session.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/sessions/1
  # PUT /admin/sessions/1.xml
  def update
    @session = Admin::Session.find(params[:id])

    respond_to do |format|
      if @session.update_attributes(params[:session])
        format.html { redirect_to(@session, :notice => 'Session was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @session.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/sessions/1
  # DELETE /admin/sessions/1.xml
  def destroy
    @session = Admin::Session.find(params[:id])
    @session.destroy

    respond_to do |format|
      format.html { redirect_to(sessions_url) }
      format.xml  { head :ok }
    end
  end
  
  def rename
    if request.post?
      all_good = true
      params[:sessions].each_pair do |id, name|
        session = Session.find id
        session.name = name
        all_good = false unless session.save
      end
      if all_good
        flash[:notice] = "Renamed!"
        redirect_to admin_sessions_path
      else
        flash.now[:alert] = "Fooey.  The names can't be blank."
      end
    end
  end
  
  def export
    sessions = Session.all
    csv_string = FasterCSV.generate do |csv| 
      headers = ["session"]
      6.times do |i|
        headers << "name #{i+1}"
        headers << "email #{i+1}"
        headers << "phone #{i+1}"
      end
      csv << headers
      sessions.each do |session|
        row = [session.name]
        session.volunteers.each do |v| 
          row << v.name
          row << v.email
          row << v.phone
        end
        csv << row
      end
    end
    send_data csv_string, :type => "text/plain", :filename=> "volunteers.csv", :disposition => 'attachment'
  end
  
private
  def authenticate
    authenticate_or_request_with_http_basic do |username, password| 
      username == "admin" && password == "supertopsecret"
    end
  end
end
