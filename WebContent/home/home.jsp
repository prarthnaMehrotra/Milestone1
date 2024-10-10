<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Online Portal</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700&family=Open+Sans:wght@300;400;600;700&display=swap"
	rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css2?family=Baskervville+SC&display=swap"
	rel="stylesheet">
<style>
body {
	font-family: 'Baskervville SC', sans-serif;
	color: #333;
}

.hero-section {
	background: url('../images/image1.jpg') no-repeat center center;
	background-size: cover;
	height: 90vh;
	display: flex;
	justify-content: center;
	align-items: center;
	color: white;
	position: relative;
	padding: 0 2rem;
}

.hero-overlay {
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
	background: rgba(0, 0, 0, 0.5);
	z-index: 0;
}

.hero-content {
	position: relative;
	text-align: center;
	z-index: 1;
	opacity: 0;
	transform: translateY(20px);
	animation: fadeInUp 2s forwards;
}

.hero-content h2 {
	font-family: 'Baskervville SC', sans-serif;
	font-size: 4rem;
	font-weight: 700;
	margin-bottom: 20px;
}

.hero-content p {
	font-family: 'Roboto', sans-serif;
	font-size: 1.25rem;
	margin-bottom: 30px;
}

.hero-buttons .btn {
	margin: 0 10px;
	padding: 0.75rem 1.5rem;
	font-size: 1.125rem;
	border-radius: 50px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
}

.carousel {
	max-width: 900px;
	margin: 40px auto;
	border-radius: 10px;
	overflow: hidden;
}

.carousel-inner img {
	height: 400px;
	object-fit: cover;
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.3);
}

.carousel-control-prev-icon, .carousel-control-next-icon {
	background-color: rgba(0, 0, 0, 0.5);
	border-radius: 50%;
}

.carousel-control-prev, .carousel-control-next {
	width: 5%;
}

.carousel-indicators button {
	background-color: #333;
}

.carousel-indicators .active {
	background-color: #007bff;
}


/* Keyframes for fade-in and slide-up animation */
@keyframes fadeInUp {
	from {
		opacity: 0;
		transform: translateY(40px);
	}
	to {
		opacity: 1;
		transform: translateY(0);
	}
}


/* Styles for card hover effect */
.card {
	overflow: hidden;
	transition: all 0.3s ease;
	cursor: pointer;
	height: 250px;
}

.card:hover {
	height: 350px; /* Increase height on hover */
	box-shadow: 0 8px 16px rgba(0, 0, 0, 0.2);
}

.card img {
	transition: all 0.3s ease;
}

.card-body {
	position: absolute;
	bottom: 0;
	left: 0;
	right: 0;
	background: rgba(255, 255, 255, 0.9);
	padding: 10px;
	opacity: 0;
	transition: opacity 0.3s ease, transform 0.3s ease;
	transform: translateY(100%);
}

.card:hover .card-body {
	opacity: 1;
	transform: translateY(0);
}

.card-title {
	margin-bottom: 0;
}

.card-text {
	display: none;
}

.card:hover .card-text {
	display: block;
}
</style>
</head>
<body>

	<jsp:include page="../common/header.jsp"></jsp:include>
	<div class="hero-section">
		<div class="hero-overlay"></div>
		<div class="hero-content">
			<h2 class="display-4">Welcome to KDA Signature Greens</h2>
			<p class="lead">Your Comfort, Our Priority</p>
			<div class="hero-buttons">
				<a href="../login/login.jsp" class="btn btn-dark">Log In</a> <a
					href="../register/register.jsp" class="btn btn-dark">Sign Up</a>
			</div>
		</div>
	</div>

	<div class="container mt-5">
		<h3 class="text-center mb-4">Our Premium Amenities</h3>
		<div class="row">
			<div class="col-md-4 mb-4">
				<div class="card">
					<img src="../images/gym.jpeg" class="card-img-top" alt="Gym">
					<div class="card-body text-center">
						<h5 class="card-title">State-of-the-Art Gym</h5>
						<p class="card-text">Fully equipped with the latest fitness
							machines, including treadmills, ellipticals, and free weights to
							help you stay in shape.</p>
					</div>
				</div>
			</div>
			<div class="col-md-4 mb-4">
				<div class="card">
					<img src="../images/clubhouse.jpeg" class="card-img-top"
						alt="Clubhouse">
					<div class="card-body text-center">
						<h5 class="card-title">Luxurious Clubhouse</h5>
						<p class="card-text">A beautifully designed space for
							residents to relax, socialize, or host private events. Features
							include comfortable seating.</p>
					</div>
				</div>
			</div>
			<div class="col-md-4 mb-4">
				<div class="card">
					<img src="../images/pool.jpeg" class="card-img-top"
						alt="Swimming Pool">
					<div class="card-body text-center">
						<h5 class="card-title">Sparkling Swimming Pool</h5>
						<p class="card-text">Enjoy a refreshing swim or lounge
							poolside in our beautifully maintained swimming pool. Perfect for
							relaxing and enjoying sunny days.</p>
					</div>
				</div>
			</div>
		</div>
	</div>

	<jsp:include page="../common/footer.jsp"></jsp:include>

	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
