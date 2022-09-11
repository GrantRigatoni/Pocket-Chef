<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" import="j.Recipe, j.RecipeDataParser, java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Past Recipes</title>

 <%
        //TODO perform search
        Cookie[] cookies  = request.getCookies(); // get the cookies
        	String user_email = null;
        	
        	if(cookies != null) {
	        	for (Cookie aCookie : cookies)
	    		{
	    			if(aCookie.getName().equals("user_email")) {
	    				user_email = aCookie.getValue();
	    			}
	        	}
        	}
        	
        	
        	ArrayList<Recipe> recipes = null;
        	if(user_email == null) {
				System.out.println("Smth wrong with the past recipe form, cookies no info");
        	}
        	else {
        		recipes = j.RecipeDataParser.getPastRecipes(user_email); //THIS ARRAY CAN BE USED TO DISPLAY THE PASR RECIPE RESULTS
        	}
        //TODO check if logged in
    %>
</head>
<body>
	
</body>
</html>