class Recipes < Application
  # provides :xml, :yaml, :js

  def index
    @recipes = Recipe.all
    display @recipes
  end

  def show(id)
    @recipe = Recipe.get(id)
    raise NotFound unless @recipe
    display @recipe
  end

  def new
    only_provides :html
    @recipe = Recipe.new
    display Recipe
  end

  def edit(id)
    only_provides :html
    @recipe = Recipe.get(id)
    raise NotFound unless @recipe
    display @recipe
  end

  def create(recipe)
    @recipe = Recipe.new(recipe)
    if @recipe.save
      redirect resource(@recipe), :message => {:notice => "Recipe was successfully created"}
    else
      render :new
    end
  end

  def update(recipe)
    @recipe = Recipe.get(recipe[:id] )
    raise NotFound unless @recipe
    if @recipe.update_attributes(recipe)
       redirect resource(@recipe)
    else
      display @recipe, :edit
    end
  end

  def destroy(id)
    @recipe = Recipe.get(id)
    raise NotFound unless @recipe
    if @recipe.destroy
      redirect resource(:recipes)
    else
      raise InternalServerError
    end
  end

end # Recipes
