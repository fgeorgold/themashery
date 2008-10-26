class Yeasts < Application
  # provides :xml, :yaml, :js

  def index
    @yeasts = Yeast.all
    display @yeasts
  end

  def show(id)
    @yeast = Yeast.get(id)
    raise NotFound unless @yeast
    display @yeast
  end

  def new
    only_provides :html
    @yeast = Yeast.new
    display @yeast
  end

  def edit(id)
    only_provides :html
    @yeast = Yeast.get(id)
    raise NotFound unless @yeast
    display @yeast
  end

  def create(yeast)
    @yeast = Yeast.new(yeast)
    if @yeast.save
      redirect resource(@yeast), :message => {:notice => "Yeast was successfully created"}
    else
      message[:error] = "Yeast failed to be created"
      render :new
    end
  end

  def update(id, yeast)
    @yeast = Yeast.get(id)
    raise NotFound unless @yeast
    if @yeast.update_attributes(yeast)
       redirect resource(@yeast)
    else
      display @yeast, :edit
    end
  end

  def destroy(id)
    @yeast = Yeast.get(id)
    raise NotFound unless @yeast
    if @yeast.destroy
      redirect resource(:yeasts)
    else
      raise InternalServerError
    end
  end

end # Yeasts
