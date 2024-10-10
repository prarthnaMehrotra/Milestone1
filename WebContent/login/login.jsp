<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login</title>
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

.login-container {
	max-width: 400px;
	margin: 5% auto;
	color: white;
	padding: 2rem;
	background: transparent;
	border-radius: 8px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.form-control {
	border-radius: 0.25rem;
}

.btn-primary {
	border-radius: 0.25rem;
}

.error-message {
	color: red;
	font-size: 0.875rem;
	margin-top: 0.25rem;
}
</style>
</head>
<body>
	<jsp:include page="../common/header.jsp"></jsp:include>
	<div class="container">
		<div class="login-container">
			<h2 class="text-center">Login</h2>
			<c:if test="${not empty NOTIFICATION}">
				<div class="alert alert-success">${NOTIFICATION}</div>
			</c:if>
			<c:if test="${not empty errorMessage}">
				<div class="error-message">${errorMessage}</div>
			</c:if>
			<form action="${pageContext.request.contextPath}/login" method="post"
				class="form-label">

				<div class="form-group">
					<label for="username">Username</label> <input type="text"
						class="form-control" id="username" name="username" required>
				</div>

				<div class="form-group">
					<label for="password">Password</label> <input type="password"
						class="form-control" id="password" name="password" required>
				</div>

				<button type="submit" class="btn btn-dark btn-block">Login</button>
				<p class="mt-3 text-center">
					Don't have an account? <a
						href="<%=request.getContextPath()%>/register">Register here</a>
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
</body>
</html>
