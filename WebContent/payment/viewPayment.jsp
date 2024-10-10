<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Maintenance Payments</title>
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

.no-payments {
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
		<h2 class="mb-4">Maintenance Payments</h2>
		<table class="table table-striped table-bordered">
			<thead>
				<tr>
					<th>Payment ID</th>
					<th>Username</th>
					<th>Payment Date</th>
					<th>Payment Amount</th>
					<th>Payment Month</th>
					<th>Status</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="payment" items="${payments}">
					<tr>
						<td>${payment.paymentId}</td>
						<td>${payment.username}</td>
						<td>${payment.paymentDate}</td>
						<td>${payment.paymentAmount}</td>
						<td>${payment.paymentMonth}</td>
						<td><c:choose>
								<c:when test="${payment.paid}">
									<span class="badge bg-success">Paid</span>
								</c:when>
								<c:otherwise>
									<span class="badge bg-danger">Pending</span>
								</c:otherwise>
							</c:choose></td>
					</tr>
				</c:forEach>
				<c:if test="${empty payments}">
					<tr>
						<td colspan="6" class="text-center no-payments">No payments
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
