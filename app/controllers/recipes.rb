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
  
  def update_ingredients(recipe, ingredients)
    if !ingredients
      return
    end
    
    ingredients.each do |key, list|
      case key
      when "fermentables":
        @assignments = recipe.fermentable_assignments
        @ingredient_id = :fermentable_id
      when "hops":
        @assignments = recipe.hop_assignments
        @ingredient_id = :hop_id
      when "adjuncts":
        @assignments = recipe.adjunct_assignments
        @ingredient_id = :adjunct_id
      end
      
      if @assignments
        list.each_value do |value|
          value[@ingredient_id] = value[:ingredient_id]
          value.delete :ingredient_id
          if ingredient[:id]
            if ingredient[:quantity] == nil || ingredient[:quantity].to_f == 0
              @assignments.get(value[:id]).destroy
            else
              @assignments.get(value[:id]).update_attributes(value)
            end
          else
            @assignments.create(value)
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
