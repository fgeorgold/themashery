class Batches < Application
  # provides :xml, :yaml, :js

  def index
    @batches = Batch.all
    display @batches
  end

  def show(id)
    @batch = Batch.get(id)
    raise NotFound unless @batch
    display @batch
  end

  def new
    only_provides :html
    @batch = Batch.new
    display Batch
  end

  def edit(id)
    only_provides :html
    @batch = Batch.get(id)
    raise NotFound unless @batch
    display @batch
  end

  def create(batch)
    @batch = Batch.new(params[:batch])
    if @batch.save
      redirect resource(@batch), :message => {:notice => "Batch was successfully created"}
    else
      render :new
    end
  end

  def update(batch)
    @batch = Batch.get(batch[:id] )
    raise NotFound unless @batch
    if @batch.update_attributes(batch)
       redirect resource(@batch)
    else
      display @batch, :edit
    end
  end

  def destroy(id)
    @batch = Batch.get(id)
    raise NotFound unless @batch
    if @batch.destroy
      redirect resource(:batches)
    else
      raise InternalServerError
    end
  end

end # Batches
