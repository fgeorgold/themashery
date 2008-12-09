class Ingredients < Application
  # provides :xml, :yaml, :js
  
  authorize_crud_resource Ingredient

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
    @ingredient.user_id = session.user.id if session.authenticated?
    if @ingredient.save
      redirect resource(@ingredient), :message => {:notice => "Ingredient was successfully created"}
    else
      message[:error] = "Ingredient failed to be created"
      render :new
    end
  end

  def update
    @ingredient = Ingredient.get(params[:id])
    raise NotFound unless @ingredient
    if @ingredient.update_attributes(ingredient_params)
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
  
  private
  def ingredient_params
    if params.include?(:hop)
      params[:hop]
    elsif params.include?(:fermentable)
      params[:fermentable]
    elsif params.include?(:yeast)
      params[:yeast]
    elsif params.include?(:adjunct)
      params[:adjunct]
    else
      raise BadRequest
    end
  end 
  
  def find_member
    @ingredient = Ingredient.get(params[:id])
    raise NotFound unless @ingredient
    @ingredient
  end

end # Ingredients
