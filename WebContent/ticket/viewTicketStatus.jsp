<%@ page import="java.util.List"%>
<%@ page import="com.cl.sampleservletjspproject.dao.TicketDao"%>
<%@ page import="com.cl.sampleservletjspproject.model.Ticket"%>
<%@ page session="true"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>View Ticket Status</title>
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
						href="${pageContext.request.contextPath}/dashboard/residentDashboard.jsp">Dashboard</a>
					</li>
					<li class="nav-item"><a class="nav-link"
						href="${pageContext.request.contextPath}/ticket/addTicket.jsp">Add
							Ticket</a></li>
					<form action="${pageContext.request.contextPath}/viewNotice"
						method="post" class="nav-item">
						<button type="submit" class="nav-link">View Notices</button>
					</form>
					<form action="${pageContext.request.contextPath}/viewTicketStatus"
						method="post" class="nav-item">
						<button type="submit" class="nav-link">View Tickets</button>
					</form>
					<li class="nav-item"><a class="nav-link"
						href="${pageContext.request.contextPath}/payment/payment.jsp">Payment</a></li>
					<li class="nav-item"><a class="nav-link"
						href="${pageContext.request.contextPath}/home/home.jsp">Logout</a>
					</li>
				</ul>
			</div>
		</div>
	</nav>

	<div class="container mt-4">
		<h2>Ticket Status</h2>
		<!-- Filter Options -->
		<%-- <form method="get" action="viewTicketStatus.jsp" class="mb-4">
			<label for="filter">Filter by:</label> <select name="filter"
				id="filter" class="form-control w-25 d-inline-block">
				<option value="all"
					${filter == null || filter == 'all' ? 'selected' : ''}>All
					Tickets</option>
				<option value="myTickets" ${filter == 'myTickets' ? 'selected' : ''}>My
					Tickets</option>
			</select>
			<button type="submit" class="btn btn-dark">Apply</button>
		</form> --%>

		<!-- Ticket List -->
		<table class="table table-striped table-bordered">
			<thead>
				<tr>
					<th>Ticket ID</th>
					<th>Title</th>
					<th>Description</th>
					<th>Raised By</th>
					<th>Raised On</th>
					<th>Status</th>
					<th>Flat Number</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="ticket" items="${tickets}">
					<tr>
						<td>${ticket.id}</td>
						<td>${ticket.title}</td>
						<td>${ticket.description}</td>
						<td>${ticket.raisedBy}</td>
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
						<td>${ticket.flatNumber}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>

		<!-- Display message if no tickets are found -->
		<c:if test="${empty tickets}">
			<div class="alert alert-warning" role="alert">No tickets found.
			</div>
		</c:if>
	</div>

	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.2/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
