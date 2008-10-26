class Fermentables < Application
  # provides :xml, :yaml, :js

  def index
    @fermentables = Fermentable.all
    display @fermentables
  end

  def show(id)
    @fermentable = Fermentable.get(id)
    raise NotFound unless @fermentable
    display @fermentable
  end

  def new
    only_provides :html
    @fermentable = Fermentable.new
    display @fermentable
  end

  def edit(id)
    only_provides :html
    @fermentable = Fermentable.get(id)
    raise NotFound unless @fermentable
    display @fermentable
  end

  def create(fermentable)
    @fermentable = Fermentable.new(fermentable)
    if @fermentable.save
      redirect resource(@fermentable), :message => {:notice => "Fermentable was successfully created"}
    else
      message[:error] = "Fermentable failed to be created"
      render :new
    end
  end

  def update(id, fermentable)
    @fermentable = Fermentable.get(id)
    raise NotFound unless @fermentable
    if @fermentable.update_attributes(fermentable)
       redirect resource(@fermentable)
    else
      display @fermentable, :edit
    end
  end

  def destroy(id)
    @fermentable = Fermentable.get(id)
    raise NotFound unless @fermentable
    if @fermentable.destroy
      redirect resource(:fermentables)
    else
      raise InternalServerError
    end
  end

end # Fermentables
