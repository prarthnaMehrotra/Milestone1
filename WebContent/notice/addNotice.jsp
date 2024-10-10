<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Add Notice</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
.error-message {
	color: red;
	font-size: 0.875rem;
	margin-top: 0.25rem;
	display: none;
}
</style>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
		<div class="container-fluid">
			<a class="navbar-brand d-flex align-items-center" href="#"> <img
				src="../images/logo.png" alt="Logo"
				style="height: 40px; margin-right: 10px;"> <span>Admin
					Dashboard</span>
			</a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="collapse" data-bs-target="#navbarNav"
				aria-controls="navbarNav" aria-expanded="false"
				aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarNav">
				<ul class="navbar-nav ms-auto">
					<li class="nav-item"><a class="nav-link"
						href="${pageContext.request.contextPath}/dashboard/adminDashboard.jsp">Dashboard</a></li>
					<li class="nav-item"><a class="nav-link"
						href="${pageContext.request.contextPath}/notice/addNotice.jsp">Add
							Notice</a></li>
					<form action="${pageContext.request.contextPath}/viewTicket"
						method="post" class="nav-item">
						<button type="submit" class="nav-link">View Tickets</button>
					</form>
					<form action="${pageContext.request.contextPath}/viewPayments"
						method="post" class="nav-item">
						<button type="submit" class="nav-link">View Payments</button>
					</form>
					<form action="${pageContext.request.contextPath}/viewAndUpdateNotice"
						method="post" class="nav-item">
						<button type="submit" class="nav-link">View Notices</button>
					</form>
					<li class="nav-item"><a class="nav-link"
						href="${pageContext.request.contextPath}/home/home.jsp">Logout</a></li>
				</ul>
			</div>
		</div>
	</nav>

	<div class="container mt-5">
		<h2>Add New Notice</h2>
		<p>
			<span style="color: red; font-size: 15px;">(*</span><span
				style="color: red; font-size: 15px;"> : required fields)</span>
		</p>

		<form action="<%=request.getContextPath()%>/addNotice" method="post" id="addnotice">

			<div class="mb-3">
				<label for="title" class="form-label">Notice Title</label><span
					style="color: red; font-size: 20px;">*</span> <input type="text"
					class="form-control" id="title" name="title" required minlength="5">
				<div id="titleError" class="error-message">Title should
					contain at least 5 characters.</div>
			</div>

			<div class="mb-3">
				<label for="description" class="form-label">Content</label><span
					style="color: red; font-size: 20px;">*</span>
				<textarea class="form-control" id="content" name="content" rows="4"
					required minlength="10"></textarea>
				<div id="contentError" class="error-message">Content should
					contain at least 10 characters.</div>
			</div>

			<div class="mb-3">
				<label for="category" class="form-label">Category</label> <select
					class="form-select" id="category" name="category" required>
					<option value="Maintenance">Maintenance</option>
					<option value="Cultural">Cultural</option>
					<option value="Community">Community</option>
					<option value="Electricity">Electricity</option>
					<option value="Water">Water</option>
					<option value="Event">Event</option>
					<option value="Others">Others</option>
				</select>
			</div>

			<button type="submit" class="btn btn-primary">Add Notice</button>
		</form>

		<c:if test="${not empty notification}">
			<div class="alert alert-info mt-3">${notification}</div>
		</c:if>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script>
		document.addEventListener('DOMContentLoaded', function () {
			var passwordPattern = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&*()_+!~`|{}:;"'<>,.?/\\-]).{8,20}$/;

			function validateTitle() {
				var title = document.getElementById("title").value;
				var titleError = document.getElementById("titleError");
				if (title.length < 5) {
					titleError.style.display = "block";
				} else {
					titleError.style.display = "none";
				}
			}

			function validateContent() {
				var content = document.getElementById("content").value;
				var contentError = document.getElementById("contentError");
				if (content.length < 10) {
					contentError.style.display = "block";
				} else {
					contentError.style.display = "none";
				}
			}

			document.getElementById('title').addEventListener('input', validateTitle);
			document.getElementById('content').addEventListener('input', validateContent);

			document.getElementById('addnotice').addEventListener('submit', function(event) {
				validateTitle();
				validateContent();
				
				if (document.querySelectorAll('.error-message[style*="block"]').length > 0) {
					event.preventDefault();
				}
			});
		});
	</script>
</body>
</html>
