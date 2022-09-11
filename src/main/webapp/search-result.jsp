<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" import="java.Recipe, RecipeDataParser, java.util.ArrayList" %>

<%@ page import="java.io.*"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="javax.servlet.http.HttpServlet"%>
<%@ page import="javax.servlet.http.HttpServletRequest"%>
<%@ page import="javax.servlet.http.HttpServletResponse"%>
<%@ page import="java.util.ArrayList,java.util.Arrays,java.util.List "%>

<!DOCTYPE html>
<html>
    <head>
        <title>Pocket Chef Home</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" type="text/css" href="index.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
		<link href="https://fonts.googleapis.com/css2?family=Inter:wght@700&display=swap" rel="stylesheet">
		<script src="https://kit.fontawesome.com/3204349982.js"
	crossorigin="anonymous"></script>
    </head>
    <style>


.checkboxes {
  text-align:center;
}
.checkboxes input{
  margin: 0px 0px 0px 0px;
}

.checkboxes label{
  margin: 0px 25px 0px 3px;
  color: #5B7C7D;
  <style>
.logo a {
	font-family: lobster;
	color: red;
	margin-left: 40px;
	font-size: 30px
}

.topnav a {
	margin-top: 15px;
	text-decoration: none;
}

.topnav-righthome {
	float: right;
	font-size: 15px;
	margin-right: 30px;
	margin-top: 15px;
}

.topnav-rightlogin {
	float: right;
	font-size: 15px;
	margin-right: 40px;
	margin-top: 15px;
}

.topnav-left {
	float: left;
	font-size: 15px;
}

.bottomnav a {
	margin-bottom: 30px;
	text-decoration: none;
}

.bottomnav-right {
	float: right;
	margin-right: 300px;
}

.bottomnav-text {
	width: 100 px;
}

.button {
	background-color: #8b0000;
	border: none;
	color: white;
	padding: 15px 32px;
	text-align: center;
	text-decoration: none;
	display: inline-block;
	font-size: 10px;
	margin: 10px 10px;
	cursor: pointer;
}

img {
	margin-left: 10px;
	margin-right: 10px;
	max-width: 98%;
}

.login-left {
	float: left;
	margin-top: 150px;
	margin-left: 300px;
}

.login-right {
	float: right;
	margin-top: 100px;
	margin-right: 300px;
}

.img {
	float: left;
	padding-right: 10px;
	margin-left: 50px;
	border-radius: 10%;
	max-width: 98%;
}

.format {
	margin-left: 140px;
}

.container {
	width: 1000px;
	margin: auto;
}
</style>

    <body>
	<% Cookie[] cookies  = request.getCookies(); 
        	String ingredients = null;
        	String filters = null;
        	
        	if(cookies != null) {
	        	for (Cookie aCookie : cookies)
	    		{
	    			if(aCookie.getName().equals("ingredients")) {
	    				String temp = aCookie.getValue();
	    				ingredients = temp.replace("=", "");
	    				ingredients = ingredients.replace("*", " ");
	    			}
	    			else if(aCookie.getName().equals("filters")) {
	    				String temp = aCookie.getValue();
	    				filters = temp.replace("=", "");
	    				filters = filters.replace("*", " ");
	    			}
	        	}
        	}
        	ArrayList<Recipe> recipes = null;
        	if(ingredients == null || filters == null) {
				System.out.println("Smth wrong with the search form, cookies no info");
        	}
        	else {
        		System.out.println("WE ARE IN ELSE");
        		 RecipeDataParser dataparser = new RecipeDataParser();
        		recipes = dataparser.getRecipes(ingredients, filters); 
        		
        		
        	}
        	//System.out.println(recipes.toString());
 		%>
	
		<!-- HEADER -->
        	<nav class="navbar navbar-expand-lg" style="background-color: #5b7b7d">
			<div class="container-fluid" >
	        	<a href="index.jsp">
	        		<img src="image 2 (Traced).png" class="img-fluid" alt="Pocket Chef" style="max-width: 50%">
	        	</a>
	        
	       		<%
				//can put this code into a separate java file if u want and just include it
				//this is for if u want the user's name to show up across all pages (would be better to move this code into whatever file handles the tab navigator to reuse the code)
					Cookie cookies1[]=request.getCookies();
					Boolean loggedin=false;
					int nameIndex = -1;
					for(int i=1; cookies1!=null && i<cookies1.length; i++)
					{
						if(cookies1[i].getName() != null)
						{
							if((cookies1[i].getName()).equals("name"))
							{
								//System.out.println(cookies[i].getValue());
								nameIndex = i;
							}
						}
					}
				%>
				<%if(cookies1.length > 1 && nameIndex != -1) { 
				  	String name = cookies1[nameIndex].getValue();
				  	name = name.replace("*", " ");%>
				  	
				  		<p class="nav-item my-auto" style="color:#FFFFFF; font-family: 'Inter', sans-serif;">Hi, <%= name %></p>
				  	
				<%loggedin=true;}%>
				
			
				<%if(!loggedin) { %>
					<ul class="navbar-nav ml-auto" style="font-family: 'Inter', sans-serif;">
		        		<li style="padding-right: 2vw;" class="nav-item"><a href="login-register.jsp" style="color:#FFFFFF;">Login/Register</a></li>
		        		<li class="nav-item"><a href="search.jsp"style="color:#FFFFFF;">Get Started</a></li>
		        	</ul>
				<%} else { %>
					<ul class="navbar-nav ml-auto" style="font-family: 'Inter', sans-serif;">
						<li class="nav-item" style="padding-right: 2vw;"><a href="history.jsp" style="color:#FFFFFF;">History</a><li>
		        		<li style="padding-right: 2vw;" class="nav-item"><a href="LogoutDispatcher" style="color:#FFFFFF;">Logout</a></li>
		        		<li class="nav-item"><a href="search.jsp"style="color:#FFFFFF;">Get Started</a></li>
		        	</ul>
				  	
				<%} %> 
	        
        	</div>
        	</nav>
        	<form action="SearchDispatcher" action="POST">
        	<div id="center-text" style=" position: absolute; top: 25%; left: 50%; transform: translate(-50%, -50%); font-family: 'Inter', sans-serif;">
        		
     			 <div style="white-space: nowrap;"> 
     			 
	     			 <label for="text "> <input type="text" id="ingredients"
						name="ingredients" style="width: 500px; margin: 5px; border-radius: 10px;">
					</label>
		
					<button class="btn" style = "background-color: #72B8C9; border: none; color: white; padding: 5px 8px; text-align: center; text-decoration: none; display: inline-block; overflow: hidden; padding-right: .5em;">
						<i class="fa fa-search"></i>
					</button>
				
				</div>
				
				<div class = "checkboxes"> 
					<input type="checkbox" name="vegetarian" value="vegetarian" style = "color: #5B7C7D"/> <label> Vegetarian </label>
					<input type="checkbox" name="vegan" value="vegan" /> <label> Vegan </label>
					<input type="checkbox" name="pesc" value="pescatarian" /> <label> Pescatarian </label>
					<br> <br>
					<input type="checkbox" name="asian" value="asian" style = "color: #5B7C7D"/> <label> Asian </label>
					<input type="checkbox" name="mediterra" value="Mediterranean" /> <label> Mediterranean </label>
				</div>
     			 
        		
        	</div>
        	</form>
        	<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
        	
        	<!--  RESULT NUM-->
        	<div class="container" style="font-size: 16px; font-family: 'Inter', sans-serif; color: #5B7C7D; background: none; margin: auto; padding-left: 20px;">
        	<%if(recipes ==null){ %>
        		<h3>Uh-oh! Nothing found.</h3>
        	<% }
        	 else if (recipes.size()==1){%>
        		<h3> <%=recipes.size()%> result: </h3>
        		
        	<% }
        	else if(recipes.size()>=2){%>
        		<h3> <%=recipes.size()%> results: </h3>
        	<% }%>
        	
        	
        	
        	</div>
        	<!-- RESULTS -->
        	<div class="container" style="width: 1000px; margin: auto;">
        	<%if(recipes == null) { %>
        		
        	<%}else{ %>
        	<% for (Recipe r: recipes){%>
			        		
			    <br>
				<br>
				<div class=format>
				<!--  TO BE CHANGED -->
						<form action="DetailsDispatcher" method="GET"> 
						<% //System.out.println(r.getProducts());
							String ing = r.getProducts();
							String ingNew = "";
							if(ing != null)
							{
								ingNew = ing.replace(" ", "=");
							}
							String res = r.getNameOfRecipe();
								String resNew = "";
							if(res != null)
							{
								resNew = res.replace(" ", "=");
							}
							String cats = r.getCategories();
							String newCats = "";
							if(cats != null)
							{
								newCats = cats.replace(" ", "=");
							}
						String instructions = r.getInstructions();
						//System.out.println(instructions);
						String newInstructions = "";
						if(instructions != null)
						{
							newInstructions = instructions.replace(" ", "=");
							
						}
						String url = r.getUrl();
						//System.out.println(url);
						String newurl = "";
						if(url != null)
						{
							newurl = url.replace(" ", "=");
						}
						
						%>
        		<div class ="img" style="float: left; padding-right: 30px;">
						<input type="image" src="<%=r.getImageUrl() %>"style="border-radius:10%; width:150px; height:150px;  margin-left: 20px; object-fit: cover;" >
						
				</div>
				<div >
					<button value=<%=r.getId()%> name="recipe_id" action="DetailsDispatcher" method="GET" style="font-size: 18px; font-family: 'Inter', sans-serif; color: #5B7C7D; background: none; border: none;padding: 0;" >
							<%= r.getNameOfRecipe() %>
					</button>
					<p style=" padding-left:50px;font-size: 16px; font-family: 'Inter', sans-serif; color: #656565; ">Ingredients: <%= r.getProducts()%></p><br />
					
				</div>	
	
							<button value=<%=r.getId()%> name="recipe_id" action="DetailsDispatcher" method="GET" style="font-size: 14px; font-family: 'Inter', sans-serif; color: #5B7C7D; background: none; border: none;padding: 0;text-decoration: underline; padding-left: 20px;" >
							<%= " " %>
							</button>
							<input style="display:none;" name="name_res" value=<%= resNew %>>
							  <input style="display:none;" name="image_url" value=<%= r.getImageUrl() %>>
							   <input style="display:none;" name="cats" value=<%= newCats %>>
							    <input style="display:none;" name="ingredients" value=<%= ingNew %>>
							     <input style="display:none;" name="steps" value=<%= newInstructions %>>
							      <input style="display:none;" name="url" value=<%= newurl %>>
						</form>
						</div>
				
        	<% }%>
        	<%} %>
        	
        	</div>
			
        </body>
        </html>