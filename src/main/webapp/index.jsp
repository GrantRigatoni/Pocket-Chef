<!DOCTYPE html>
<html>
    <head>
        <title>Pocket Chef Home</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" type="text/css" href="index.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
		<link href="https://fonts.googleapis.com/css2?family=Inter:wght@700&display=swap" rel="stylesheet">
    </head>
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
				Cookie cookies[]=null;
				int nameIndex = 0;
				Boolean loggedin=false;
				if (request.getCookies()!=null){
					 cookies=request.getCookies();
					
					
					for(int i=1; cookies!=null && i<cookies.length; i++)
					{
						if(cookies[i].getName() != null)
						{
							if((cookies[i].getName()).equals("name"))
							{
								//System.out.println(cookies[i].getValue());
								nameIndex = i;
							}
						}
					}
				
					if(cookies.length > 1 && cookies[nameIndex].getValue() != null && nameIndex !=0) { 
					  	String name = cookies[nameIndex].getValue();
					  	name = name.replace("*", " ");%>
					  	
					  		<p class="nav-item my-auto" style="color:#FFFFFF; font-family: 'Inter', sans-serif;">Hi, <%= name %></p>
					  	
						<%loggedin=true;} 
					else { 
						loggedin = false;
					}}%>
				
			
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
        
        <!-- IMAGE -->
        <div id="backgroundimage" style="background-image:url('home.jpg'); width:100vw; height: 100vh; background-size: 100% 100%; 
        	background-repeat: no-repeat; position: relative; overflow: auto;position: relative; text-align: center;">
        	<div id="center-text" style=" position: absolute; top: 50%; left: 50%; transform: translate(-50%, -50%); font-family: 'Inter', sans-serif;"">
        		<div id="welcome" style="font-size: 20px; color: #5b7b7d; padding-bottom: 20px;">
        			Welcome to Pocket Chef!
        		</div> 
        		<form action="search.jsp">
        			<input type="submit" class="btn btn-primary" style="background-color: #5b7b7d; outline:none; border-style: none;color: #FFFFFF; font-size: 9px; padding: 15px;" value="GET STARTED">
        		</form>
        		<!--  <button type="button" class="btn btn-primary" style="background-color: #5b7b7d; outline:none; border-style: none;color: #FFFFFF; font-size: 9px; padding: 15px;">GET STARTED</button>
        	--></div>
        </div>
    </body>
</html>