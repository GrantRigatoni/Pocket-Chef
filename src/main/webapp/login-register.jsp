<!DOCTYPE html>
<html>
    <head>
        <title>Pocket Chef Login/Register</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.3.1/dist/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
        <link rel="stylesheet" type="text/css" href="index.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
		<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
		<link href="https://fonts.googleapis.com/css2?family=Inter:wght@700&display=swap" rel="stylesheet">
    </head>
	
	
    <body style= "font-family: 'Inter', sans-serif;">
    <!-- HEADER -->
       	<nav class="navbar navbar-expand-lg" style="background-color: #5b7b7d">
		<div class="container-fluid" >
        	<a href="index.jsp">
        		<img src="image 2 (Traced).png" class="img-fluid" alt="Pocket Chef" style="max-width: 50%">
        	</a>
        
        	<ul class="navbar-nav ml-auto" style="font-family: 'Inter', sans-serif;">
        		<li style="padding-right: 2vw;" class="nav-item"><a href="login-register.jsp" style="color:#FFFFFF;">Login/Register</a></li>
        		<li class="nav-item"><a href="search.jsp"style="color:#FFFFFF;">Get Started</a></li>
        	</ul>
       	</div>
       	</nav>
	
	<%
		//check errors, display error message at top
		String loginError = (String) request.getAttribute("error");
		if (loginError != null) {
			//if(request.getParameter("error").length() > 1) {
		%>
			<div style="font-size: 16px; font-family: 'Inter', sans-serif; background-color:#FF7276;color: white; "><br><center>Invalid email or password. Please try again.</center><br></div>
		<%
	}%><%
		//check errors, display error message at top
		String registerError = (String) request.getAttribute("registerError");
		if (registerError != null) {
			//if(request.getParameter("error").length() > 1) {
		%>
		<div style="font-size: 16px; font-family: 'Inter', sans-serif; background-color:#FF7276;color: white; "><br><center><%=registerError %></center><br></div>
	<%}%>
	<!-- FORMS -->
		<div class="d-md-flex h-md-100 align-items-center">
	
		    <!-- First Half -->
		    <div class="col-md-6 p-0  h-md-100 align-items-center h-100 p-5 text-center justify-content-center">
		    	<h4 style="color:#5b7b7d; ">Login</h4>
		        <div style="color:black; text-align: left;">
		        
		        <div class="text-white d-md-flex align-items-center h-100 p-5 justify-content-center">
            
		            <form id="login" action="LoginDispatcher" method="POST" style="color:black; justify-content: left;">
					<label for="email" >email:</label>
					<input type="text" name="email" id="email" class="form-control" style="border-radius: 15px;">
					<br>
					<label for="password">password:</label>
					<input type="password" name="password" id="password" class="form-control" style="border-radius: 15px;">
					<br>
					<button type="submit" class="btn-block form-controll btn search" style="background-color: #72b8c9; color: white;">
						<i class="fa fa-sign-in"></i> Sign In
					</button>
				</form>
		        </div>
		    </div></div>
	
		    <!-- Second Half -->
		    <div class="col-md-6   p-0  h-md-100 align-items-center h-md-100 p-5 text-center justify-content-center">
		       <br>
		            <h4 style="color:#5b7b7d; ">Register</h4>
		            <div  style="color:black; text-align: left;">
		            
		            <div class="d-md-flex align-items-center h-md-100 p-5 justify-content-center">
		            
					<form name="RegisterDispatcher" action="RegisterDispatcher" method="POST" style="color:black; justify-content: left;">
						<label for="email">email:</label>
						<input type="email" name="email" id="email" class="form-control" style="border-radius: 15px;">
						<br>
						<label for="name">username:</label>
						<input type="text" name="name" id="name" class="form-control" style="border-radius: 15px;">
						<br>
						<label for="password">password:</label>
						<input type="password" name="password" id="password" class="form-control" style="border-radius: 15px;">
						<br>
						<label for="confirm_password">confirm password:</label>
						<input type="password" name="confirm_password" id="confirm_password" class="form-control" style="border-radius: 15px;">
						<br>
						<input type="checkbox" name="checkbox" value="agree"> I have read and agree to all terms and conditions of Pocket Chef
						<br><br>
						
						<button name ="createuser" type="submit"class="btn-block form-controll btn search" style="background-color: #72b8c9; color: white;">
							<i class="fa fa-user-plus"></i> Create Account
						</button>
					</form>
		        </div></div>
		    </div>
        
		</div>
	
</body>
</html>