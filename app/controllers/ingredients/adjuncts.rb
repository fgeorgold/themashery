class Adjuncts < Application
  # provides :xml, :yaml, :js

  def index
    @adjuncts = Adjunct.all
    display @adjuncts
  end

  def show(id)
    @adjunct = Adjunct.get(id)
    raise NotFound unless @adjunct
    display @adjunct
  end

  def new
    only_provides :html
    @adjunct = Adjunct.new
    display @adjunct
  end

  def edit(id)
    only_provides :html
    @adjunct = Adjunct.get(id)
    raise NotFound unless @adjunct
    display @adjunct
  end

  def create(adjunct)
    @adjunct = Adjunct.new(adjunct)
    if @adjunct.save
      redirect resource(@adjunct), :message => {:notice => "Adjunct was successfully created"}
    else
      message[:error] = "Adjunct failed to be created"
      render :new
    end
  end

  def update(id, adjunct)
    @adjunct = Adjunct.get(id)
    raise NotFound unless @adjunct
    if @adjunct.update_attributes(adjunct)
       redirect resource(@adjunct)
    else
      display @adjunct, :edit
    end
  end

  def destroy(id)
    @adjunct = Adjunct.get(id)
    raise NotFound unless @adjunct
    if @adjunct.destroy
      redirect resource(:adjuncts)
    else
      raise InternalServerError
    end
  end

end # Adjuncts
