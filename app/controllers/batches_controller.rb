class BatchesController < ApplicationController
  require_role "user", :for_all_except => [:update, :destroy]
  require_role "admin", :for => [:update, :destroy], 
                        :unless => "current_user.id == Batch.find_by_id(params[:id]).user_id"
  # GET /batches
  # GET /batches.xml
  def index
    @own_batches = [Batch.all(:conditions => ["user_id = ?", current_user.id],
                             :order => "brewed_on DESC")].flatten.compact
    @others_batches = [Batch.all(:conditions => ["user_id != ?", current_user.id],
                                 :order => "brewed_on DESC")].flatten.compact
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @batches }
    end
  end

  # GET /batches/1
  # GET /batches/1.xml
  def show
    @batch = Batch.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @batch }
    end
  end

  # GET /batches/new
  # GET /batches/new.xml
  def new
    @batch = Batch.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @batch }
    end
  end

  # GET /batches/1/edit
  def edit
    @batch = Batch.find(params[:id])
  end

  # POST /batches
  # POST /batches.xml
  def create
    @batch = Batch.new(params[:batch])
    @batch.user = current_user
    respond_to do |format|
      if @batch.save
        flash[:notice] = 'Batch was successfully created.'
        format.html { redirect_to(@batch) }
        format.xml  { render :xml => @batch, :status => :created, :location => @batch }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @batch.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /batches/1
  # PUT /batches/1.xml
  def update
    @batch = Batch.find(params[:id])
    @batch.user = current_user
    respond_to do |format|
      if @batch.update_attributes(params[:batch])
        flash[:notice] = 'Batch was successfully updated.'
        format.html { redirect_to(@batch) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @batch.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /batches/1
  # DELETE /batches/1.xml
  def destroy
    @batch = Batch.find(params[:id])
    @batch.destroy

    respond_to do |format|
      format.html { redirect_to(batches_url) }
      format.xml  { head :ok }
    end
  end
end
