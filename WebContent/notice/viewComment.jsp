<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>View Comments</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
.table thead th {
	background-color: #f8f9fa;
	color: #495057;
}

.table tbody tr:nth-child(even) {
	background-color: #f2f2f2;
}

.table tbody tr:hover {
	background-color: #e9ecef;
}

.no-comments {
	font-style: italic;
	color: #6c757d;
}
</style>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
		<div class="container-fluid">
			<a class="navbar-brand d-flex align-items-center" href="#"> <img
				src="./images/logo.png" alt="Logo"
				style="height: 40px; margin-right: 10px;"> <span>Resident
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
						href="${pageContext.request.contextPath}/dashboard/residentDashboard.jsp">Dashboard</a></li>
					<li class="nav-item"><a class="nav-link"
						href="${pageContext.request.contextPath}/ticket/addTicket.jsp">Add
							Ticket</a></li>
					<form action="${pageContext.request.contextPath}/viewNotice"
						method="post" class="nav-item">
						<button type="submit" class="nav-link">View Notices</button>
					</form>
					<li class="nav-item"><a class="nav-link"
						href="${pageContext.request.contextPath}/payment/payment.jsp">Payment</a></li>
					<li class="nav-item"><a class="nav-link"
						href="${pageContext.request.contextPath}/home/home.jsp">Logout</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<div class="container mt-5">
		<h2 class="mb-4">Comments for Notice ID: ${noticeId}</h2>
		<table class="table table-striped table-bordered">
			<thead>
				<tr>
					<th>Notice ID</th>
					<th>User Name</th>
					<th>Comment</th>
					<th>Date Posted</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="comment" items="${comments}">
					<tr>
						<td>${comment.noticeId}</td>
						<td>${comment.username}</td>
						<td>${comment.content}</td>
						<td>${comment.postedOn}</td>
					</tr>
				</c:forEach>
				<c:if test="${empty comments}">
					<tr>
						<td colspan="4" class="text-center no-comments">No comments
							available.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
		<a
			href="${pageContext.request.contextPath}/dashboard/residentDashboard.jsp"
			class="btn btn-primary">Back to the Dashboard</a>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
