import com.google.gson.*;

import java.lang.reflect.Type;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

/**
 * A class that pretends to be the Yelp API
 */
public class RecipeDataParser {
    private static Boolean ready = false;

    /**
     * Initializes the DB with json data
     *
     * @param responseString the Yelp json string
     */
    public static void Init(String responseString) {
        if (ready) {
            return;
        }
        System.out.println("im hereeeeeeeeeeeeeeee");
        Connection conn;
        // first clean the tables
 		String delCategory = "DELETE FROM recipes;";
 		 try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            //TODO check if you've done the initialization
            
        	conn = DriverManager.getConnection(Constant.DBUrl, Constant.DBUserName, Constant.DBPassword);
			
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}catch (Exception e) {
			System.out.println(e.getMessage());
		}
 		PreparedStatement sql = null;
 			
 			try {
 			conn = DriverManager.getConnection(Constant.DBUrl, Constant.DBUserName, Constant.DBPassword);
 			// you have to delete the two tables that contain the foreign keys first
 			PreparedStatement ps1 = conn.prepareStatement(delCategory);
 			ps1.executeUpdate();
 			
 			System.out.println("successfully cleaned tables");
 			 String recipes = "INSERT INTO recipes (id, name_of_recipe, image_url, url, ingredients, categories, instructions) VALUES (?, ?, ?, ?, ?, ?, ?)";
 	        sql = conn.prepareStatement(recipes);
 		       
 	        
 			System.out.println("inserted successfully");
 		}
 		catch (SQLException ex) {
 			
   			System.out.println("SQLException: " + ex.getMessage());
   		}
 		
 		
        
        
       
        ready = true;
        
    
        
        Gson gson = new Gson();
        Recipe[] recipies = null;
        
        try {
	        recipies = gson.fromJson(responseString, Recipe[].class);
        } catch (JsonSyntaxException e) {
			System.err.println(e.getMessage());
			System.out.println("restaurant file is ill formatted.");
		}
        //TODO iterate the businessHelper array and insert every business into the DB
        Integer detailsId = 1, ratingId = 1;
        for (int i=0; i<recipies.length; i++) {
        	Recipe recipe = recipies[i];
        	List<String> ingredients = recipe.getIngredients();
        	List<String> filters = recipe.getFilters();
        	String ing = "", filt = "";
        	
        	for(int j=0; j<ingredients.size(); j++) {
        		ing += ingredients.get(j) + " ";
        	}
        	
        	for(int k=0; k<filters.size(); k++) {
        		filt += filters.get(k) + " ";
        	}
        	
        	// add the recipe
        	try {
        		sql.setString(1, recipe.getId());
        		sql.setString(2, recipe.getNameOfRecipe());
        		sql.setString(3, recipe.getImageUrl());
        		sql.setString(4, recipe.getUrl());
        		sql.setString(5, ing);
        		sql.setString(6, filt);
        		sql.setString(7, recipe.getSteps());
        		
        		int row = sql.executeUpdate(); //the number of rows affected
        	} catch (SQLException e) {
    			// TODO Auto-generated catch block
        		System.out.println(e.getMessage());
    			System.out.println("could not add the recipe details");
    		}
        }
    }

    public static Recipe getRecipe(String id) {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            String sql = "SELECT id, name_of_recipe, image_url, url, ingredients, categories, instructions FROM finalproject.recipes WHERE id = '" + id + "';";
            
            Connection conn = DriverManager.getConnection(Constant.DBUrl, Constant.DBUserName, Constant.DBPassword);
			Statement s = conn.createStatement();
			ResultSet rs = s.executeQuery(sql);
			String rest_id = null, name_of_recipe = null, image_url = null, url = null, ingredients = null, categories = null, instructions = null;
			
			if(rs.next()) {
				rest_id = rs.getString("id");
				name_of_recipe = rs.getString("name_of_recipe");
				image_url = rs.getString("image_url");
				url = rs.getString("url");
				ingredients = rs.getString("ingredients");
				categories = rs.getString("categories");
				instructions = rs.getString("instructions"); 
			}
			
			Recipe recipe = new Recipe(rest_id, name_of_recipe, image_url, url, ingredients, categories, instructions);
			return recipe;

        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
			// TODO Auto-generated catch block
        	System.out.println(e.getMessage());
        	System.out.println("could not find a recipe in getRecipe function");
		}
        //TODO return business based on id
        return null;
    }

    /**
     * @param keyWord    the search keyword
     * @param sort       the sort option (price, review count, rating)
     * @param searchType search in category or name
     * @return the list of business matching the criteria
     */
    public static ArrayList<Recipe> getRecipes(String ingredients, String filters) {
        ArrayList<Recipe> recipes = new ArrayList<Recipe>();
        String sql = "";
        
        String[] ing_array = ingredients.split(" ");
        String[] filt_array = new String[] {""};
        if(filters != null) {
        	filt_array = filters.split(" ");
        }
        
        sql = "SELECT r.id FROM finalproject.recipes r WHERE (r.ingredients LIKE '%" + ing_array[0] + "%' ";
        
        for (int i=1; i<ing_array.length-1; i++) {
        	sql += "OR r.ingredients LIKE '%" + ing_array[i] + "%' ";
        }
        sql += "OR r.ingredients LIKE '%" + ing_array[ing_array.length-1] + "%') ";
        
        sql += "AND (r.categories LIKE '%" + filt_array[0] + "%' ";
        for (int i=1; i<filt_array.length-1; i++) {
        	sql += "OR r.categories LIKE '%" + filt_array[i] + "%' ";
        }
        sql += "OR r.categories LIKE '%" + filt_array[filt_array.length-1] + "%');";
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(Constant.DBUrl, Constant.DBUserName, Constant.DBPassword);
			Statement s = conn.createStatement();
			ResultSet rs = s.executeQuery(sql);
			
			while(rs.next()) {
				String id = rs.getString("id");
				//System.out.println(rest_id);
				recipes.add(getRecipe(id));
			}
			
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
			// TODO Auto-generated catch block
        	System.out.println(e.getMessage());
        	System.out.println("could not find recipes in getRecipes function");
		}
        //TODO get list of business based on the param
        if(recipes.isEmpty()) {
        	System.out.println("did not find any recipes");
        	return null;
        }
        return recipes;

    }
    
    public static void insertPastRecipe(String recipe_id, String user_email) {
    	String stmt = "INSERT INTO past_recipes (id, recipe_id, user_email) VALUES (?, ?, ?)";
    	Random rand = new Random();
    	int id = rand.nextInt(500);
    	
    	 Connection conn;
         PreparedStatement sql = null;
         
         try {
             Class.forName("com.mysql.cj.jdbc.Driver");
             //TODO check if you've done the initialization
             
         	conn = DriverManager.getConnection(Constant.DBUrl, Constant.DBUserName, Constant.DBPassword);
 			sql = conn.prepareStatement(stmt);
 			sql.setInt(1, id);
 			sql.setString(2, recipe_id);
    		sql.setString(3, user_email);
    		
    		int row = sql.executeUpdate(); //the number of rows affected
         } catch (ClassNotFoundException e) {
             e.printStackTrace();
         } catch (SQLException e) {
 			// TODO Auto-generated catch block
 			e.printStackTrace();
 			System.out.println(e.getMessage());
 		}catch (Exception e) {
 			System.out.println(e.getMessage());
 		}
    }
    
    public static ArrayList<Recipe> getPastRecipes(String user_email) {
    	ArrayList<Recipe> recipes = new ArrayList<Recipe>();
    	String sql = "SELECT recipe_id FROM finalproject.past_recipes WHERE user_email = '" + user_email + "';";
    	
    	try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(Constant.DBUrl, Constant.DBUserName, Constant.DBPassword);
			Statement s = conn.createStatement();
			ResultSet rs = s.executeQuery(sql);
			
			while(rs.next()) {
				String id = rs.getString("recipe_id");
				//System.out.println(rest_id);
				recipes.add(getRecipe(id));
			}
			
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
			// TODO Auto-generated catch block
        	System.out.println(e.getMessage());
        	System.out.println("could not find recipes in getPastRecipes function");
		}
    	
        if(recipes.isEmpty()) {
        	System.out.println("did not find any past recipes");
        	return null;
        }
        return recipes;
    }
    
    public static Boolean checkRecipe(String recipe_id) {
    	String sql = "SELECT recipe_id FROM finalproject.past_recipes WHERE recipe_id = '" + recipe_id + "';";
    	
    	try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(Constant.DBUrl, Constant.DBUserName, Constant.DBPassword);
			Statement s = conn.createStatement();
			ResultSet rs = s.executeQuery(sql);
			
			if(rs.next()) {
				return true;
			}
			
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        } catch (SQLException e) {
			// TODO Auto-generated catch block
        	System.out.println(e.getMessage());
        	System.out.println("could not find recipes in getPastRecipes function");
		}
    	
    	return false;
    }
}

//Code adapted from https://stackoverflow.com/questions/23070298/get-nested-json-object-with-gson-using-retrofit
class BusinessDeserializer implements JsonDeserializer<Recipe[]> {
    @Override
    public Recipe[] deserialize(JsonElement je, Type type, JsonDeserializationContext jdc) throws JsonParseException {
        JsonElement content = je.getAsJsonObject();
        return new Gson().fromJson(content, Recipe[].class);
    }
}