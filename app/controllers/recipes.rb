class Recipes < Application
  # provides :xml, :yaml, :js
  authorize_crud_resource Recipe

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
      update_ingredients(@recipe, params[:ingredients])
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
      update_ingredients(@recipe, params[:ingredients])
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
  
  def update_ingredients(recipe, ingredients)
    if !ingredients
      return
    end
    
    ingredients.each do |key, list|
      @assignments = case key
      when "fermentables":
        recipe.fermentable_assignments
      when "hops":
        recipe.hop_assignments
      when "adjuncts":
        recipe.adjunct_assignments
      end
      
      if @assignments
        list.each_value do |ingredient|
          if ingredient[:id]
            if ingredient[:quantity] == nil || ingredient[:quantity].to_f == 0
              @assignments.get(ingredient[:id]).destroy
            else
              @assignments.get(ingredient[:id]).update_attributes(ingredient)
            end
          else
            @assignments.create(ingredient)
          end
        end
      end
    end
  end
  
  private
  def find_member
    Recipe.get(params[:id])
  end

end # Recipes
