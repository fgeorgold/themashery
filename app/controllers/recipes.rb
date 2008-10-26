class Recipes < Application
  # provides :xml, :yaml, :js
  
  before :ensure_authorized

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
    display @recipe
  end

  def edit(id)
    only_provides :html
    @recipe = Recipe.get(id)
    raise NotFound unless @recipe
    display @recipe
  end

  def create(recipe)
    @recipe = Recipe.new(recipe)
    @recipe.user_id = session.user.id if session.authenticated?
    if @recipe.save
      redirect resource(@recipe), :message => {:notice => "Recipe was successfully created"}
    else
      message[:error] = "Recipe failed to be created"
      render :new
    end
  end

  def update(id, recipe)
    @recipe = Recipe.get(id)
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
