<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Register</title>
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<style>
body {
    background: linear-gradient(135deg, #1c1c1c, #3d3d3d, #b0b0b0);
    background-size: cover;
    background-attachment: fixed;
    background-color: #3d3d3d;
    transition: background 0.3s ease-in-out;
    font-family: 'Arial', sans-serif;
    color: #f5f5f5;
}

.register-container {
	max-width: 600px;
	margin: 5% auto;
	padding: 2rem;
	color: white;
	background: transparent;
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.form-group {
	margin-bottom: 1rem;
}

.btn-primary {
	border-radius: 0.25rem;
}

.error-message {
	color: red;
	font-size: 0.875rem;
	margin-top: 0.25rem;
	display: none; 
}
</style>
</head>
<body>
	<jsp:include page="../common/header.jsp"></jsp:include>
	<div class="container">
		<div class="register-container">
			<h2 class="text-center">Register</h2>
			<%
			String notification = (String) request.getAttribute("NOTIFICATION");
			%>
			<%
			if (notification != null) {
			%>
			<div class="alert alert-info" role="alert">
				<%=notification%>
			</div>
			<%
			}
			%>
			<form action="${pageContext.request.contextPath}/register"
				method="post" class="form-label" id="registerForm">

				<div class="form-row">
					<div class="form-group col-md-6">
						<label for="username">Username</label> <input type="text"
							class="form-control" id="username" name="username" required
							minlength="5" maxlength="20" pattern="[A-Za-z0-9]+"
							title="Username should be 5-20 characters long and contain only letters and numbers.">
						<div id="usernameError" class="error-message">Username
							should be 5-20 characters long and contain only letters and
							numbers.</div>
					</div>

					<div class="form-group col-md-6">
						<label for="password">Password</label> <input type="password"
							class="form-control" id="password" name="password" required
							minlength="8" maxlength="20"
							title="Password should be 8-20 characters long, include at least one uppercase letter, one lowercase letter, one number, and one special character.">
						<div id="passwordError" class="error-message">Password
							should be 8-20 characters long, include at least one uppercase
							letter, one lowercase letter, one number, and one special
							character.</div>
					</div>
				</div>

				<div class="form-row">
					<div class="form-group col-md-6">
						<label for="firstName">First Name</label> <input type="text"
							class="form-control" id="firstName" name="firstName" required
							pattern="[A-Za-z]+" minlength="3"
							title="First Name should contain only letters.">
						<div id="firstNameError" class="error-message">First Name
							should contain only letters (length: 3).</div>
					</div>

					<div class="form-group col-md-6">
						<label for="lastName">Last Name</label> <input type="text"
							class="form-control" id="lastName" name="lastName"
							pattern="[A-Za-z]+"
							title="Last Name should contain only letters.">
						<div id="lastNameError" class="error-message">Last Name
							should contain only letters.</div>
					</div>
				</div>

				<div class="form-row">
					<div class="form-group col-md-6">
						<label for="flatNumber">Flat Number</label> <input type="text"
							class="form-control" id="flatNumber" name="flatNumber" required
							pattern="[A-Za-z0-9]+"
							title="Flat Number should contain only letters and numbers.">
						<div id="flatNumberError" class="error-message">Flat Number
							should contain only letters and numbers.</div>
					</div>

					<div class="form-group col-md-6">
						<label for="userRole">User Role</label> <input type="text"
							class="form-control" id="userRole" name="userRole"
							value="Resident" disabled>
					</div>
				</div>

				<button type="submit" class="btn btn-dark btn-block">Register</button>
				<p class="mt-3 text-center">
					Already have an account? <a
						href="<%=request.getContextPath()%>/login/login.jsp">Login
						here</a>
				</p>
			</form>
		</div>
	</div>
	<jsp:include page="../common/footer.jsp"></jsp:include>

	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script>
		document.addEventListener('DOMContentLoaded', function () {
			var passwordPattern = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&*()_+!~`|{}:;"'<>,.?/\\-]).{8,20}$/;

			function validateUsername() {
				var username = document.getElementById("username").value;
				var usernameError = document.getElementById("usernameError");
				if (username.length < 5 || username.length > 20 || !/^[A-Za-z0-9]+$/.test(username)) {
					usernameError.style.display = "block";
				} else {
					usernameError.style.display = "none";
				}
			}

			function validatePassword() {
				var password = document.getElementById("password").value;
				var passwordError = document.getElementById("passwordError");
				if (!passwordPattern.test(password)) {
					passwordError.style.display = "block";
				} else {
					passwordError.style.display = "none";
				}
			}

			function validateFirstName() {
				var firstName = document.getElementById("firstName").value;
				var firstNameError = document.getElementById("firstNameError");
				if ( firstName.length < 3 || !/^[A-Za-z]+$/.test(firstName)) {
					firstNameError.style.display = "block";
				} else {
					firstNameError.style.display = "none";
				}
			}

			function validateLastName() {
				var lastName = document.getElementById("lastName").value;
				var lastNameError = document.getElementById("lastNameError");
				if (!/^[A-Za-z]+$/.test(lastName)) {
					lastNameError.style.display = "block";
				} else {
					lastNameError.style.display = "none";
				}
			}

			function validateFlatNumber() {
				var flatNumber = document.getElementById("flatNumber").value;
				var flatNumberError = document.getElementById("flatNumberError");
				if (!/^[A-Za-z0-9]+$/.test(flatNumber)) {
					flatNumberError.style.display = "block";
				} else {
					flatNumberError.style.display = "none";
				}
			}

			document.getElementById('username').addEventListener('input', validateUsername);
			document.getElementById('password').addEventListener('input', validatePassword);
			document.getElementById('firstName').addEventListener('input', validateFirstName);
			document.getElementById('lastName').addEventListener('input', validateLastName);
			document.getElementById('flatNumber').addEventListener('input', validateFlatNumber);

			document.getElementById('registerForm').addEventListener('submit', function(event) {
				validateUsername();
				validatePassword();
				validateFirstName();
				validateLastName();
				validateFlatNumber();
				
				if (document.querySelectorAll('.error-message[style*="block"]').length > 0) {
					event.preventDefault();
				}
			});
		});
	</script>
</body>
</html>
