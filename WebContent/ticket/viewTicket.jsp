<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Tickets</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
.table {
	margin: 0 auto; /* Center the table within its container */
	max-width: 100%; /* Ensure it doesn't exceed the container width */
}

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

.no-tickets {
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
		<h2 class="mb-4">Tickets Raised by Residents</h2>
		<table class="table table-striped table-bordered">
			<thead>
				<tr>
					<th>Ticket ID</th>
					<th>Title</th>
					<th>Description</th>
					<th>Username</th>
					<th>Flat Number</th>
					<th>Date Raised</th>
					<th>Status</th>
					<th>Actions</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="ticket" items="${tickets}">
					<tr>
						<td>${ticket.id}</td>
						<td>${ticket.title}</td>
						<td>${ticket.description}</td>
						<td>${ticket.raisedBy}</td>
						<td>${ticket.flatNumber}</td>
						<td>${ticket.raisedOn}</td>
						<td><c:choose>
								<c:when test="${ticket.status == 'Open'}">
									<span class="badge bg-success">Open</span>
								</c:when>
								<c:when test="${ticket.status == 'Resolved'}">
									<span class="badge bg-secondary">Resolved</span>
								</c:when>
								<c:otherwise>
									<span class="badge bg-warning">Pending</span>
								</c:otherwise>
							</c:choose></td>
						<td>
							<form
								action="${pageContext.request.contextPath}/updateTicketStatus"
								method="post" class="d-inline">
								<input type="hidden" name="ticketId" value="${ticket.id}">
								<input type="hidden" name="newStatus"
									value="${ticket.status == 'Open' ? 'Resolved' : 'Open'}">
								<button type="submit"
									class="btn ${ticket.status == 'Open' ? 'btn-danger' : 'btn-success'}">
									${ticket.status == 'Open' ? 'Mark as Resolved' : 'Mark as Open'}
								</button>
							</form>
						</td>
					</tr>
				</c:forEach>
				<c:if test="${empty tickets}">
					<tr>
						<td colspan="8" class="text-center no-tickets">No tickets
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
