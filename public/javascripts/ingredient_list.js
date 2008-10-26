function ingredient_list(element)
{
  $(element).children().filter("div.ingredient").each(function(index) {
    if($(this).attr("id") == "") {      
      add_ingredient(element,
       $(this).children().filter("id").html(),
       $(this).children().filter("ingredient").html(),
       $(this).children().filter("quantity").html(),
       $(this).children().filter("units").html(),
       $(this).children().filter("name").html());
      $(this).remove();
    }
  });
  $(element).children().filter("select#ingredient").bind("change", function(e) {
    var ingredient = $(this).attr("value");
    var name = $(this).children().filter(function(index) {
      return $(this).attr("value") == ingredient;
    }).html();
    
    $(this).removeAttr("value");
    
    add_ingredient(element, "", ingredient, "", "", name);
  });
}
 
function bind_remove(element)
{
  $(element).children().filter("a.remove").bind("click", function(e) {
    if($(element).children().filter("input#id").length > 0) {
      $(element).children().filter("input#quantity").remove();
      $(element).hide();
    }
    else {
      $(element).remove();
    }
    e.preventDefault();
  });
}
 
function add_ingredient(ingredient_list, id, ingredient, quantity, units, name)
{
  
  var itemDiv = document.createElement("div");
  
  var itemId = 1;
  while($(ingredient_list).children().filter(".ingredient").filter(function(index) {
      return $(this).attr("id") == itemId + '';
    }).length > 0) itemId++; itemId = itemId + '';
  
  var ingredientType = $(ingredient_list).attr("id");
  
  $(itemDiv).addClass("ingredient").attr("id", itemId)
  
  if(id) {
    var idInput = document.createElement("input");
    $(idInput).attr("type", "hidden");
    $(idInput).attr("name", 'ingredients[' + ingredientType + '[' + itemId + '[id]]]');
    $(idInput).attr("value", id+'');
    $(idInput).attr("id", "id");
    $(itemDiv).append(idInput);
  }
  
  var ingredientInput = document.createElement("input");
  $(ingredientInput).attr("type", "hidden");
  $(ingredientInput).attr("name", "ingredients[" + ingredientType + "[" + itemId + "[ingredient_id]]]");
  if(ingredient) $(ingredientInput).attr("value", ingredient + '');
  $(ingredientInput).attr("id", "ingredient");
  $(itemDiv).append(ingredientInput);
  
  var quantityInput = document.createElement("input");
  $(quantityInput).attr("type", "text");
  $(quantityInput).attr("name", "ingredients[" + ingredientType + "[" + itemId + "[quantity]]]")
  if(ingredient) $(quantityInput).attr("value", quantity + '');
  $(quantityInput).addClass("quantity");
  $(quantityInput).attr("id", "quantity");
  $(itemDiv).append(quantityInput);
  
  var unitsInput = $(ingredient_list).children().filter("select#units").clone().removeClass("hidden");
  $(unitsInput).attr("name", "ingredients[" + ingredientType + "[" + itemId + "[units]]]");
  if(units) $(unitsInput).attr("value", units);
  $(unitsInput).css("margin-left", "0px");
  $(unitsInput).attr("id", "units")
  $(itemDiv).append(unitsInput);
  
  $(itemDiv).append(' ' + name + ' ');
  
  var removeLink = document.createElement("a");
  $(removeLink).addClass("remove");
  $(removeLink).attr("href", "");
  $(removeLink).append("x");
  $(itemDiv).append(removeLink);
  
  bind_remove(itemDiv);
  
  $(ingredient_list).append(itemDiv);
}
