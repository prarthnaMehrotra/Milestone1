<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page
	import="com.cl.sampleservletjspproject.model.Calendar, java.util.*"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Resident Dashboard</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Custom CSS -->
<style>
html, body {
	font-family: sans-serif;
	color: #444;
	margin: 0;
	font-size: 15px;
	line-height: 1.4;
}

.navbar {
	margin-bottom: 20px;
}

.welcome {
	text-align: center;
}

.table-container {
	display: none;
	z-index: 10;
	width: 50%;
	margin: 20px auto; /* Center the table */
	background-color: white;
	border: 1px solid #ccc;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
	max-height: 200px;
	overflow-y: auto;
}

.table {
	font-size: 0.9em;
	margin: 0;
	box-shadow: none;
}

.card-img-top {
	height: 200px;
	object-fit: cover;
}

.events-btn {
	text-align: center;
}
</style>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
		<div class="container-fluid">
			<a class="navbar-brand d-flex align-items-center" href="#"> <img
				src="../images/logo.png" alt="Logo"
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

	<h4 class="welcome">
		Welcome,
		<c:out value="${sessionScope.username} (${sessionScope.role})!" />
	</h4>

	<%
	HttpSession sess = request.getSession();
	List<Calendar> events = (List<Calendar>) sess.getAttribute("events");
	%>

	<div class="container mt-5">
		<h3 class="text-center mb-4">Our Events</h3>
		<div class="row">
			<div class="col-md-4 mb-4">
				<div class="card">
					<img src="../images/basketball.jpg" class="card-img-top"
						alt="Basketball">
					<div class="card-body text-center">
						<h5 class="card-title">Basketball Court</h5>
						<p class="card-text">Enjoy a game of basketball on our
							well-maintained court.</p>
					</div>
				</div>
			</div>
			<div class="col-md-4 mb-4">
				<div class="card">
					<img src="../images/poolgame.jpg" class="card-img-top"
						alt="Pool Game">
					<div class="card-body text-center">
						<h5 class="card-title">Pool Game Area</h5>
						<p class="card-text">Relax and have fun in our recreational
							pool game area.</p>
					</div>
				</div>
			</div>
			<div class="col-md-4 mb-4">
				<div class="card">
					<img src="../images/swimmingpool.jpg" class="card-img-top"
						alt="Swimming Pool">
					<div class="card-body text-center">
						<h5 class="card-title">Swimming Pool</h5>
						<p class="card-text">Take a dip in our luxurious swimming
							pool, perfect for a refreshing break.</p>
					</div>
				</div>
			</div>
		</div>

		<div class="events-btn mt-4">
			<button class="btn btn-primary" id="toggle-events">Upcoming
				Events</button>
			<div class="table-container" id="events-table">
				<table class="table table-striped table-bordered">
					<thead>
						<tr>
							<th>Event Date</th>
							<th>Event Name</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach var="event" items="${sessionScope.events}">
							<tr>
								<td>${event.date}</td>
								<td>${event.eventName}</td>
							</tr>
						</c:forEach>
						<c:if test="${empty events}">
							<tr>
								<td colspan="2" class="text-center no-events">No events
									available.</td>
							</tr>
						</c:if>
					</tbody>
				</table>
			</div>
		</div>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script>
		document.getElementById('toggle-events')
				.addEventListener(
						'click',
						function() {
							const eventsTable = document
									.getElementById('events-table');
							if (eventsTable.style.display === 'none'
									|| eventsTable.style.display === '') {
								eventsTable.style.display = 'block';
							} else {
								eventsTable.style.display = 'none';
							}
						});
	</script>
</body>
</html>
