<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Admin Dashboard</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Calendar CSS -->
<style>
html {
	font-family: sans-serif;
	font-size: 15px;
	line-height: 1.4;
	color: #444;
}

body {
	margin: 0;
	font-size: 1em;
}

.welcome {
	text-align: center;
}

.wrapper {
	margin: 15px auto;
	max-width: 1000px;
}

.container-calendar {
	padding: 20px;
	background: #ffffff;
	border: 2px solid #00a2b7;
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	max-width: 100%;
	overflow: hidden;
}

.button-container-calendar button {
	cursor: pointer;
	display: inline-block;
	zoom: 1;
	background: #00a2b7;
	color: #fff;
	border: 1px solid #0aa2b5;
	border-radius: 4px;
	padding: 10px 20px;
}

.table-calendar {
	border-collapse: collapse;
	width: 100%;
}

.table-calendar td, .table-calendar th {
	padding: 10px;
	border: 1px solid #e2e2e2;
	text-align: center;
	vertical-align: top;
}

.date-picker.selected {
	font-weight: bold;
	outline: 1px dashed #00BCD4;
}

.date-picker.selected span {
	border-bottom: 2px solid currentColor;
}

/* sunday */
.date-picker:nth-child(1) {
	color: red;
}

/* friday */
.date-picker:nth-child(7) {
	color: green;
}

.date-picker {
	cursor: pointer;
}

.date-picker:hover {
	cursor: pointer;
}

.date-picker.event {
	background-color: #f0f8ff;
	color: #333;
	border: 2px solid #00a2b7;
}

.date-picker .event-name {
	display: block;
	font-size: 0.8em;
	color: #666;
	margin-top: 2px;
}

#monthAndYear {
	text-align: center;
	font-size: 2em;
}

.button-container-calendar {
	position: relative;
	margin-bottom: 1em;
	overflow: hidden;
	clear: both;
}

#previous {
	float: left;
}

#next {
	float: right;
}

.footer-container-calendar {
	margin-top: 1em;
	border-top: 1px solid #dadada;
	padding: 10px 0;
}

.footer-container-calendar select {
	cursor: pointer;
	display: inline-block;
	zoom: 1;
	background: #ffffff;
	color: #585858;
	border: 1px solid #bfc5c5;
	border-radius: 3px;
	padding: 5px 1em;
}

/* Pop-up styling */
.event-popup {
	position: fixed;
	top: 50%;
	left: 50%;
	transform: translate(-50%, -50%);
	background-color: #fff;
	padding: 20px;
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
	z-index: 1000;
	display: none;
	width: 300px;
	text-align: center;
}

.event-popup input {
	width: 100%;
	padding: 8px;
	margin: 10px 0;
	border-radius: 5px;
	border: 1px solid #ccc;
}

.event-popup button {
	padding: 10px 20px;
	border-radius: 5px;
	border: none;
	cursor: pointer;
	color: #fff;
	font-size: 1em;
	margin: 5px;
}

.event-popup button.save {
	background-color: #00a2b7;
}

.event-popup button.cancel {
	background-color: #ccc;
}

.event-popup-overlay {
	position: fixed;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background-color: rgba(0, 0, 0, 0.5);
	z-index: 999;
	display: none;
}

.error-message {
	color: red;
	font-size: 0.875rem;
	margin-top: 0.25rem;
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

	<h4 class="welcome">
		Welcome,
		<c:out value="${sessionScope.username} (${sessionScope.role})!" />
	</h4>

	<!-- Calendar HTML -->
	<div class="wrapper">
		<h4>Add events here</h4>
		<div class="container-calendar">
			<h3 id="monthAndYear"></h3>
			<div class="button-container-calendar">
				<button id="previous" onclick="previous()">&#8249;</button>
				<button id="next" onclick="next()">&#8250;</button>
			</div>
			<table class="table-calendar" id="calendar" data-lang="en">
				<thead id="thead-month"></thead>
				<tbody id="calendar-body"></tbody>
			</table>
			<div class="footer-container-calendar">
				<label for="month">Jump To: </label> <select id="month"
					onchange="jump()">
					<option value=0>Jan</option>
					<option value=1>Feb</option>
					<option value=2>Mar</option>
					<option value=3>Apr</option>
					<option value=4>May</option>
					<option value=5>Jun</option>
					<option value=6>Jul</option>
					<option value=7>Aug</option>
					<option value=8>Sep</option>
					<option value=9>Oct</option>
					<option value=10>Nov</option>
					<option value=11>Dec</option>
				</select> <select id="year" onchange="jump()"></select>
			</div>
		</div>
	</div>
	<jsp:include page="../common/footer.jsp"></jsp:include>

	<!-- Event Pop-ups -->
	<div class="event-popup-overlay"></div>
	<form action="${pageContext.request.contextPath}/calendar"
		method="post">
		<!-- Hidden fields for action and date -->
		<input type="hidden" name="action" id="actionInput"> <input
			type="hidden" name="date" id="dateInput">

		<div class="event-popup" id="addEventPopup">
			<h4>Add Event</h4>
			<input type="text" id="eventInput" name="eventName"
				placeholder="Event Name">
			<button type="submit" class="save" onclick="setAction('save')">Save</button>
			<button type="button" class="cancel" onclick="closeEventPopup()">Cancel</button>
		</div>

		<div class="event-popup" id="removeEventPopup">
			<h4>Remove Event</h4>
			<button type="submit" class="save" onclick="setAction('cancel')">Remove</button>
			<button type="button" class="cancel" onclick="closeEventPopup()">Cancel</button>
		</div>
	</form>

	<!-- Calendar JavaScript -->
	<script>
		function generate_year_range(start, end) {
			var years = "";
			for (var year = start; year <= end; year++) {
				years += "<option value='" + year + "'>" + year + "</option>";
			}
			return years;
		}

		today = new Date();
		currentMonth = today.getMonth();
		currentYear = today.getFullYear();
		selectYear = document.getElementById("year");
		selectMonth = document.getElementById("month");

		createYear = generate_year_range(1970, 2050);
		document.getElementById("year").innerHTML = createYear;

		var calendar = document.getElementById("calendar");
		var lang = calendar.getAttribute('data-lang');

		var months = [ "January", "February", "March", "April", "May", "June",
				"July", "August", "September", "October", "November",
				"December" ];

		var days = [ "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat" ];

		var dayHeader = "<tr>";
		for (day in days) {
			dayHeader += "<th data-days='" + days[day] + "'>" + days[day]
					+ "</th>";
		}
		dayHeader += "</tr>";

		document.getElementById("thead-month").innerHTML = dayHeader;

		monthAndYear = document.getElementById("monthAndYear");
		showCalendar(currentMonth, currentYear);

		function next() {
			currentYear = (currentMonth === 11) ? currentYear + 1 : currentYear;
			currentMonth = (currentMonth + 1) % 12;
			showCalendar(currentMonth, currentYear);
		}

		function previous() {
			currentYear = (currentMonth === 0) ? currentYear - 1 : currentYear;
			currentMonth = (currentMonth === 0) ? 11 : currentMonth - 1;
			showCalendar(currentMonth, currentYear);
		}

		function jump() {
			currentYear = parseInt(selectYear.value);
			currentMonth = parseInt(selectMonth.value);
			showCalendar(currentMonth, currentYear);
		}

		function showCalendar(month, year) {
			var firstDay = (new Date(year, month)).getDay();
			tbl = document.getElementById("calendar-body");
			tbl.innerHTML = "";

			monthAndYear.innerHTML = months[month] + " " + year;
			selectYear.value = year;
			selectMonth.value = month;

			var date = 1;
			for (var i = 0; i < 6; i++) {
				var row = document.createElement("tr");

				for (var j = 0; j < 7; j++) {
					if (i === 0 && j < firstDay) {
						var cell = document.createElement("td");
						var cellText = document.createTextNode("");
						cell.appendChild(cellText);
						row.appendChild(cell);
					} else if (date > daysInMonth(month, year)) {
						break;
					} else {
						var cell = document.createElement("td");
						var formattedDate = [ date.toString().padStart(2, '0'),
								(month + 1).toString().padStart(2, '0'), year ]
								.join('-');
						cell.setAttribute("data-date", date);
						cell.setAttribute("data-month", month + 1);
						cell.setAttribute("data-year", year);
						cell.className = "date-picker";
						cell.innerHTML = "<span>" + date + "</span>";

						cell.onclick = function() {
							openEventPopup(this);
						};

						row.appendChild(cell);
						date++;
					}
				}
				tbl.appendChild(row);
			}
		}

		function daysInMonth(iMonth, iYear) {
			return 32 - new Date(iYear, iMonth, 32).getDate();
		}

		var selectedCell = null;

		function openEventPopup(cell) {
			selectedCell = cell;
			var eventName = selectedCell.querySelector('.event-name');
			var date = [
					selectedCell.getAttribute('data-date').padStart(2, '0'),
					(selectedCell.getAttribute('data-month')).padStart(2, '0'),
					selectedCell.getAttribute('data-year') ].join('-');

			if (eventName) {
				// Show the remove event popup
				document.getElementById('removeEventPopup').style.display = 'block';
				document.querySelector('.event-popup-overlay').style.display = 'block';
			} else {
				// Show the add event popup
				document.getElementById('addEventPopup').style.display = 'block';
				document.querySelector('.event-popup-overlay').style.display = 'block';
				document.getElementById('eventInput').value = '';

				setDate(date);
			}
		}

		function closeEventPopup() {
			document.querySelectorAll('.event-popup').forEach(function(popup) {
				popup.style.display = 'none';
			});
			document.querySelector('.event-popup-overlay').style.display = 'none';
		}

		function setAction(action) {
			document.getElementById('actionInput').value = action;
		}

		function setDate(date) {
			document.getElementById('dateInput').value = date;
		}

		document.getElementById('saveEventBtn').addEventListener(
				'click',
				function() {
					var eventName = document.getElementById('eventInput').value
							.trim();

					if (eventName !== '' && selectedCell) {
						var eventLabel = document.createElement('span');
						eventLabel.className = 'event-name';
						eventLabel.textContent = eventName;
						selectedCell.appendChild(eventLabel);
						selectedCell.classList.add('event');
					}

					closeEventPopup();
				});

		document.getElementById('removeEventBtn').addEventListener(
				'click',
				function() {
					if (selectedCell) {
						var eventName = selectedCell
								.querySelector('.event-name');
						if (eventName) {
							selectedCell.removeChild(eventName);
							selectedCell.classList.remove('event');
						}
					}
					closeEventPopup();
				});
	</script>
</body>
</html>