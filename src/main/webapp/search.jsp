<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
         pageEncoding="ISO-8859-1" import="j.Recipe, j.RecipeDataParser, java.util.ArrayList" %>

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

<!DOCTYPE html>
<html>
    <head>
        <title>Search</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" type="text/css" href="index.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
		<link href="https://fonts.googleapis.com/css2?family=Inter:wght@700&display=swap" rel="stylesheet">

	<link
	href="https://fonts.googleapis.com/css2?family=Lobster&family=Roboto:wght@300&display=swap"
	rel="stylesheet">
	
	<script src="https://kit.fontawesome.com/3204349982.js"
	crossorigin="anonymous"></script>
    </head>
        <title>Search for Recipes</title>

          


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
}

</style>
   
    <body>
    	
    
    
    
    
    
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
        <div id="center-text" style=" position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); font-family: 'Inter', sans-serif;">
        		
        		
        		  <div style = "font-size: 20px; color: #5B7C7D; font-family: 'Inter', sans-serif; text-align:center"> 
     			 Input ingredients you have in your fridge and separate by comma
     			 </div>
     			 <div style="white-space: nowrap;"> 
     			 
	     			 <label for="text "> <input type="text" id="ingredients"
						name="ingredients" style="width: 800px; margin: 5px; border-radius: 10px;">
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
      
    
        
        
         <div id="margin-bottom" style=" position: absolute; top: 80%; left: 10%; font-family: 'Inter', sans-serif;">
        	<label style="color: #72B8C9; font-size: 20px;"> List of Ingredients we have in our database: </label> <br>
        	<label style="color: #5B7C7D; font-size: 20px;"> apples, pineapples, oranges, flour, eggs, onion, bellpepper,  yogurt, olive oil +  30 more items </label>
        	</div>

		
    </body>
</html>