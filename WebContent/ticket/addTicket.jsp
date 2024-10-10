<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Raise a Ticket</title>
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

	<div class="container mt-5">
		<h2>Raise a Ticket</h2>
		<p>
			<span style="color: red; font-size: 15px;">(*</span><span
				style="color: red; font-size: 15px;"> : required fields)</span>
		</p>

		<!-- Display Success or Error Message -->
		<%
		String message = (String) request.getAttribute("message");
		if (message != null) {
		%>
		<div
			class="alert <%=message.contains("success") ? "alert-success" : "alert-danger"%> alert-dismissible fade show"
			role="alert">
			<%=message%>
			<button type="button" class="btn-close" data-bs-dismiss="alert"
				aria-label="Close"></button>
		</div>
		<%
		}
		%>

		<%
		HttpSession sess = request.getSession();
		String flatNumber = (String) sess.getAttribute("flatNumber");
		System.out.println(flatNumber);
		%>

		<form action="<%=request.getContextPath()%>/addTicket" method="post"
			id="addticket">

			<div class="mb-3">
				<label for="flatNumber" class="form-label">Flat Number</label> <input
					type="text" class="form-control" id="flatNumber" name="flatNumber"
					value="<%=flatNumber%>" readonly>
			</div>

			<div class="mb-3">
				<label for="title" class="form-label">Ticket Title</label><span
					style="color: red; font-size: 20px;">*</span><input type="text"
					class="form-control" id="title" name="title" required minlength="5">
				<div id="titleError" class="error-message">Title should
					contain at least 5 characters.</div>
			</div>

			<div class="mb-3">
				<label for="description" class="form-label">Description</label><span
					style="color: red; font-size: 20px;">*</span>
				<textarea class="form-control" id="description" name="description"
					rows="4" required minlength="10"></textarea>
				<div id="descriptionError" class="error-message">Description
					should contain at least 10 characters.</div>
			</div>

			<div class="mb-3">
				<label for="category" class="form-label">Category</label> <select
					class="form-select" id="category" name="category" required>
					<option value="Maintenance">Maintenance</option>
					<option value="Community">Community</option>
					<option value="Electricity">Electricity</option>
					<option value="Water">Water</option>
					<option value="Door Access Issues">Door Access Issues</option>
					<option value="Others">Others</option>
				</select>
			</div>

			<button type="submit" class="btn btn-primary">Submit Ticket</button>
		</form>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
	<script>
		document
				.addEventListener(
						'DOMContentLoaded',
						function() {
							var passwordPattern = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&*()_+!~`|{}:;"'<>,.?/\\-]).{8,20}$/;

							function validateTitle() {
								var title = document.getElementById("title").value;
								var titleError = document
										.getElementById("titleError");
								if (title.length < 5) {
									titleError.style.display = "block";
								} else {
									titleError.style.display = "none";
								}
							}

							function validateDescription() {
								var description = document
										.getElementById("description").value;
								var descriptionError = document
										.getElementById("descriptionError");
								if (description.length < 10) {
									descriptionError.style.display = "block";
								} else {
									descriptionError.style.display = "none";
								}
							}

							document.getElementById('title').addEventListener(
									'input', validateTitle);
							document.getElementById('description')
									.addEventListener('input',
											validateDescription);

							document
									.getElementById('addticket')
									.addEventListener(
											'submit',
											function(event) {
												validateTitle();
												validateDescription();

												if (document
														.querySelectorAll('.error-message[style*="block"]').length > 0) {
													event.preventDefault();
												}
											});
						});
	</script>
</body>
</html>
