<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Wallet</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<style>
.payment-section {
	border: 1px solid #ccc;
	border-radius: 8px;
	padding: 20px;
	margin: 20px auto;
	max-width: 500px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
}

.form-inline {
	display: flex;
	align-items: center;
}

.form-inline input {
	flex: 1;
	margin-right: 10px;
}

.modal-dialog {
	max-width: 400px;
}

.alert {
	display: none;
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

/* Button styling */
.btn-success {
	border: none;
}

.btn-success:disabled {
	background-color: grey;
}

#paymentStatusText {
	margin-top: 10px;
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
		<!-- Wallet Section -->
		<div class="payment-section">
			<h3>Wallet</h3>
			<form id="walletForm" class="form-inline"
				action="${pageContext.request.contextPath}/addToWallet"
				method="post">
				<input type="number" class="form-control" id="walletBalanceInput"
					name="walletBalance" min="3000" max="10000"
					placeholder="Add Money to Wallet" required>
				<button type="submit" class="btn btn-dark">Add</button>
			</form>
			<p class="mt-3">
				Current Wallet Balance: Rs. <span id="walletBalance">${sessionScope.walletBalance}</span>
			</p>
		</div>

		<!-- Maintenance Payment Section -->
		<div class="payment-section">
			<h3>Maintenance Payment</h3>
			<p>Maintenance Fee for this Month: ₹3000</p>
			<button type="button" class="btn btn-success" id="payNowButton"
				data-bs-toggle="modal" data-bs-target="#payModal"
				${isPaid ? 'disabled' : ''}>Pay Now</button>
			<p id="paymentStatusText"
				style="${isPaid ? 'color: green;' : 'color: red;'}">
				<c:choose>
					<c:when test="${isPaid}">
                        Payment already done!
                    </c:when>
					<c:otherwise>
                        Payment due!
                    </c:otherwise>
				</c:choose>
			</p>

			<c:choose>
				<c:when test="${param.paymentUpdate == 'success'}">
					<div class="alert alert-success" role="alert">Payment made
						successfully!</div>
				</c:when>
				<c:when test="${param.paymentUpdate == 'failure'}">
					<div class="alert alert-danger" role="alert">Failed to
						process payment. Please try again.</div>
				</c:when>
				<c:when test="${param.paymentUpdate == 'insufficientFunds'}">
					<div class="alert alert-warning" role="alert">Insufficient
						funds in wallet.</div>
				</c:when>
				<c:when test="${param.paymentUpdate == 'alreadyPaid'}">
					<div class="alert alert-info" role="alert">Payment already
						done!</div>
				</c:when>
			</c:choose>
		</div>

		<!-- Modal for Payment Confirmation -->
		<div class="modal fade" id="payModal" tabindex="-1"
			aria-labelledby="payModalLabel" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered">
				<div class="modal-content">
					<div class="modal-header">
						<h5 class="modal-title" id="payModalLabel">Confirm Payment</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>
					<div class="modal-body">Are you sure you want to pay the
						maintenance fee of ₹3000?</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">Cancel</button>
						<form action="${pageContext.request.contextPath}/payMaintenance"
							method="post" style="display: inline;">
							<button type="submit" class="btn btn-success">Pay</button>
						</form>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- Notification Pop-ups -->
	<div class="event-popup-overlay"></div>
	<div class="event-popup" id="removeEventPopup">
		<h4>Money Added!</h4>
		<p>Money successfully added to your wallet!</p>
		<button type="button" class="cancel btn btn-dark"
			onclick="closeEventPopup()">Okay</button>
	</div>

	<div class="event-popup" id="paymentSuccessPopup">
		<h4>Payment Successfull!</h4>
		<p>Payment successfully processed!</p>
		<button type="button" class="cancel btn btn-dark"
			onclick="closePaymentPopup()">Okay</button>
	</div>

	<div class="event-popup" id="insufficientFundsPopup">
		<h4>Payment Failed!</h4>
		<p>Insufficient funds in your wallet. Please add money and try
			again.</p>
		<button type="button" class="cancel btn btn-dark"
			onclick="closeNotificationPopup()">Okay</button>
	</div>

	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.min.js"></script>

	<script>
		window.onload = function() {
			const urlParams = new URLSearchParams(window.location.search);
			
			window.onload = function() {
			    const isPaid = '${isPaid}';
			    if (isPaid === 'true') {
			        document.getElementById('payNowButton').disabled = true;
			        document.getElementById('paymentStatusText').textContent = 'Payment already done!';
			    }
			};
		
			if (urlParams.get('walletUpdate') === 'success') {
				document.getElementById('removeEventPopup').style.display = 'block';
				document.querySelector('.event-popup-overlay').style.display = 'block';
				updateWalletBalance();
			} else if (urlParams.get('walletUpdate') === 'failure') {
				alert('Failed to add money to wallet. Please try again.');
			}
		
			if (urlParams.get('paymentUpdate') === 'success') {
				document.getElementById('paymentSuccessPopup').style.display = 'block';
				document.querySelector('.event-popup-overlay').style.display = 'block';
				updateWalletBalance();
			}
		
			if (urlParams.get('paymentUpdate') === 'insufficientFunds') {
				document.getElementById('insufficientFundsPopup').style.display = 'block';
				document.querySelector('.event-popup-overlay').style.display = 'block';
			}
		}
		
		function closeEventPopup() {
			document.getElementById('removeEventPopup').style.display = 'none';
			document.querySelector('.event-popup-overlay').style.display = 'none';
		}
		
		function closePaymentPopup() {
			document.getElementById('paymentSuccessPopup').style.display = 'none';
			document.querySelector('.event-popup-overlay').style.display = 'none';
		}
		
		function closeNotificationPopup() {
			document.getElementById('insufficientFundsPopup').style.display = 'none';
			document.querySelector('.event-popup-overlay').style.display = 'none';
		}
		
		function updateWalletBalance() {
			fetch('${pageContext.request.contextPath}/walletBalance')
				.then(response => response.json())
				.then(data => {
					document.getElementById('walletBalance').textContent = data.walletBalance;
				})
				.catch(error => console.error('Error fetching wallet balance:', error));
		}
	</script>

</body>
</html>
