class Ingredients < Application
  # provides :xml, :yaml, :js

  def index
    @ingredients = Ingredient.all
    display @ingredients
  end

  def show(id)
    @ingredient = Ingredient.get(id)
    raise NotFound unless @ingredient
    display @ingredient
  end

  def new
    only_provides :html
    @ingredient = Ingredient.new
    display @ingredient
  end

  def edit(id)
    only_provides :html
    @ingredient = Ingredient.get(id)
    raise NotFound unless @ingredient
    display @ingredient
  end

  def create(ingredient)
    @ingredient = Ingredient.new(ingredient)
    if @ingredient.save
      redirect resource(@ingredient), :message => {:notice => "Ingredient was successfully created"}
    else
      message[:error] = "Ingredient failed to be created"
      render :new
    end
  end

  def update(id, ingredient)
    @ingredient = Ingredient.get(id)
    raise NotFound unless @ingredient
    if @ingredient.update_attributes(ingredient)
       redirect resource(@ingredient)
    else
      display @ingredient, :edit
    end
  end

  def destroy(id)
    @ingredient = Ingredient.get(id)
    raise NotFound unless @ingredient
    if @ingredient.destroy
      redirect resource(:ingredients)
    else
      raise InternalServerError
    end
  end

end # Ingredients
