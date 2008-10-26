class Hops < Application
  # provides :xml, :yaml, :js

  def index
    @hops = Hop.all
    display @hops
  end

  def show(id)
    @hop = Hop.get(id)
    raise NotFound unless @hop
    display @hop
  end

  def new
    only_provides :html
    @hop = Hop.new
    display @hop
  end

  def edit(id)
    only_provides :html
    @hop = Hop.get(id)
    raise NotFound unless @hop
    display @hop
  end

  def create(hop)
    @hop = Hop.new(hop)
    if @hop.save
      redirect resource(@hop), :message => {:notice => "Hop was successfully created"}
    else
      message[:error] = "Hop failed to be created"
      render :new
    end
  end

  def update(id, hop)
    @hop = Hop.get(id)
    raise NotFound unless @hop
    if @hop.update_attributes(hop)
       redirect resource(@hop)
    else
      display @hop, :edit
    end
  end

  def destroy(id)
    @hop = Hop.get(id)
    raise NotFound unless @hop
    if @hop.destroy
      redirect resource(:hops)
    else
      raise InternalServerError
    end
  end

end # Hops
