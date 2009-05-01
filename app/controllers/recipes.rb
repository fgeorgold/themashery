class Recipes < Application
  # provides :xml, :yaml, :js

  # GET /recipes
  def index
    @recipes = Recipe.all
    display @recipes
  end

  # GET /recipes/:id
  def show
    @recipe = Recipe[params[:id]]
    raise NotFound unless @recipe
    display @recipe
  end

  # GET /recipes/new
  def new
    only_provides :html
    @recipe = Recipe.new(params[:recipe])
    render
  end

  # POST /recipes
  def create
    @recipe = Recipe.new(params[:recipe])
    if @recipe.save
      redirect url(:recipe, @recipe)
    else
      render :new
    end
  end

  # GET /recipes/:id/edit
  def edit
    only_provides :html
    @recipe = Recipe[params[:id]]
    raise NotFound unless @recipe
    render
  end

  # PUT /recipes/:id
  def update
    @recipe = Recipe[params[:id]]
    raise NotFound unless @recipe
    if @recipe.update(params[:recipe])
      redirect url(:recipe, @recipe)
    else
      raise BadRequest
    end
  end

  # DELETE /recipes/:id
  def destroy
    @recipe = Recipe[params[:id]]
    raise NotFound unless @recipe
    if @recipe.destroy
      redirect url(:recipes)
    else
      raise BadRequest
    end
  end

end
