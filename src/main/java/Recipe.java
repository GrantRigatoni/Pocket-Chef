import java.util.List;

import com.google.gson.annotations.Expose;
import com.google.gson.annotations.SerializedName;

public class Recipe {

	public Recipe() {
		// TODO Auto-generated constructor stub
	}
	
	public Recipe(String id_, String nameOfRecipe_, String imageUrl_, String url_, String products_, String categories_, String instructions_) {
		id = id_;
		nameOfRecipe = nameOfRecipe_;
		imageUrl = imageUrl_;
		url = url_;
		products = products_;
		categories = categories_;
		instructions = instructions_;
	}
	
	String products, categories, instructions;
	
	public String getProducts() {
		return products;
	}
	
	public String getCategories() {
		return categories;
	}
	
	public String getInstructions() {
		return instructions;
	}
	
	@SerializedName("id")
	@Expose
	private String id;
	@SerializedName("name_of_recipe")
	@Expose
	private String nameOfRecipe;
	@SerializedName("image_url")
	@Expose
	private String imageUrl;
	@SerializedName("url")
	@Expose
	private String url;
	@SerializedName("ingredients")
	@Expose
	private List<String> ingredients = null;
	@SerializedName("filters")
	@Expose
	private List<String> filters = null;
	@SerializedName("steps")
	@Expose
	private String steps;

	public String getId() {
	return id;
	}

	public void setId(String id) {
	this.id = id;
	}

	public String getNameOfRecipe() {
	return nameOfRecipe;
	}

	public void setNameOfRecipe(String nameOfRecipe) {
	this.nameOfRecipe = nameOfRecipe;
	}

	public String getImageUrl() {
	return imageUrl;
	}

	public void setImageUrl(String imageUrl) {
	this.imageUrl = imageUrl;
	}

	public String getUrl() {
	return url;
	}

	public void setUrl(String url) {
	this.url = url;
	}

	public List<String> getIngredients() {
	return ingredients;
	}

	public void setIngredients(List<String> ingredients) {
	this.ingredients = ingredients;
	}

	public List<String> getFilters() {
	return filters;
	}

	public void setFilters(List<String> filters) {
	this.filters = filters;
	}

	public String getSteps() {
	return steps;
	}

	public void setSteps(String steps) {
	this.steps = steps;
	}
}
