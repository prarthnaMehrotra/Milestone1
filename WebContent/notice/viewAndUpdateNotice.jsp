<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Notices</title>
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

.no-notices {
	font-style: italic;
	color: #6c757d;
}

.btn {
	white-space: nowrap; /* Prevent button text from wrapping */
}
</style>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
		<div class="container-fluid">
			<a class="navbar-brand d-flex align-items-center" href="#"> <img
				src="./images/logo.png" alt="Logo"
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
					<form
						action="${pageContext.request.contextPath}/viewAndUpdateNotice"
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
		<h2 class="mb-4">Notices</h2>
		<table class="table table-striped table-bordered">
			<thead>
				<tr>
					<th>ID</th>
					<th>Title</th>
					<th>Content</th>
					<th>Category</th>
					<th>User</th>
					<th>Date Posted</th>
					<th>Status</th>
					<th>Action</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="notice" items="${notices}">
					<tr>
						<td>${notice.id}</td>
						<td>${notice.title}</td>
						<td>${notice.content}</td>
						<td>${notice.category}</td>
						<td>${notice.postedBy}</td>
						<td>${notice.postedOn}</td>
						<td><c:choose>
								<c:when test="${notice.status == 'Open'}">
									<span class="badge bg-success">Open</span>
								</c:when>
								<c:when test="${notice.status == 'Cancelled'}">
									<span class="badge bg-secondary">Cancelled</span>
								</c:when>
							</c:choose></td>
						<td>
							<form
								action="${pageContext.request.contextPath}/updateNoticeStatus"
								method="post" class="d-inline">
								<input type="hidden" name="noticeId" value="${notice.id}">
								<input type="hidden" name="newStatus"
									value="${notice.status == 'Open' ? 'Cancelled' : 'Open'}">
								<button type="submit"
									class="btn ${notice.status == 'Open' ? 'btn-danger' : 'btn-success'} btn-sm">
									${notice.status == 'Open' ? 'Cancel' : 'Open'}</button>
							</form>
						</td>
					</tr>
				</c:forEach>
				<c:if test="${empty notices}">
					<tr>
						<td colspan="8" class="text-center no-notices">No notices
							available.</td>
					</tr>
				</c:if>
			</tbody>
		</table>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
