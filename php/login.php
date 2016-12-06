<?php
	session_start();
	if(isset($_SESSION["username"])){
		if ($_SESSION['id']==0) {
			header("Location: lihatlowonganadmin.php");
		}
		elseif($_SESSION['id']%2>0) {
			header("Location: lihatlowonganmhs.php");
		}
		elseif($_SESSION['id']%2==0) {
			header("Location: lihatlowongandosen.php");
		}
	}
	$_SESSION['idrow'] = 0;
	$_SESSION['one_row'] = true;

	require "conn.php";
	$alert = "";
	if(isset($_POST["sbmt"])){
		if(checkUsername($_POST["username"])){
			if(checkPassword($_POST["username"], $_POST["password"])) {
				$resp = "login success";	
				movePage();
			}
			else {
				$alert ="password incorrect";
	}
		}
		else {
			$alert = "username is not exist";
		}
	}

	function checkUsername($username) {
		$conn = connect();
		$sql1 = "SELECT username FROM siasisten.mahasiswa WHERE username='$username'";
		$sql2 = "SELECT username FROM siasisten.dosen WHERE username='$username'";
		$result1 = pg_query($conn, $sql1);
		$result2 = pg_query($conn, $sql2);
		
		$id = mt_rand();

<<<<<<< HEAD
<<<<<<< HEAD
		if (pg_fetch_row($result1) > 0) {
			pg_close($conn);
			if($id%2==0) {
				$_SESSION['id'] = $id+1;
			}
			else 
				$_SESSION['id'] = $id;
			return true;
		}
		else if (pg_fetch_row($result2) > 0) {
			pg_close($conn);
=======
		if($username==='admin') {
			pg_close($conn);
			$_SESSION['id'] = 0;
			return true;
		}
		else if (pg_fetch_row($result1) > 0) {
			pg_close($conn);
			$_SESSION['id'] = $id+1;
			return true;
		}
		else if (pg_fetch_row($result2) > 0) {
			pg_close($conn);
>>>>>>> 6e4adb03b39b5e4b37cf330fb9f6886b2359ed86
=======
		if($username==='admin') {
			pg_close($conn);
			$_SESSION['id'] = 0;
			return true;
		}
		else if (pg_fetch_row($result1) > 0) {
			pg_close($conn);
			$_SESSION['id'] = $id+1;
			return true;
		}
		else if (pg_fetch_row($result2) > 0) {
			pg_close($conn);
>>>>>>> 6e4adb03b39b5e4b37cf330fb9f6886b2359ed86
			if($id%2==0) {
				$_SESSION['id'] = $id;
			}
			else 
				$_SESSION['id'] = $id+1;
			return true;
		}
		pg_close($conn);
		return false;
	}

	function checkPassword($username, $password) {
		$conn = connect();
		$sql1 = "SELECT password FROM siasisten.password WHERE username='$username' AND password='$password'";
		$sql2 = "SELECT password FROM siasisten.dosen WHERE username='$username' AND password='$password'";
		$result1 = pg_query($conn, $sql1);
		$result2 = pg_query($conn, $sql2);
<<<<<<< HEAD
<<<<<<< HEAD
		if (pg_fetch_row($result1) > 0) {
			pg_close($conn);
			return true;
		}
=======
		if($username==='admin' && $password==='admin') {
			pg_close($conn);
			return true;
		}
=======
		if($username==='admin' && $password==='admin') {
			pg_close($conn);
			return true;
		}
>>>>>>> 6e4adb03b39b5e4b37cf330fb9f6886b2359ed86
		else if (pg_fetch_row($result1) > 0) {
			pg_close($conn);
			return true;
		}
<<<<<<< HEAD
>>>>>>> 6e4adb03b39b5e4b37cf330fb9f6886b2359ed86
=======
>>>>>>> 6e4adb03b39b5e4b37cf330fb9f6886b2359ed86
		else if (pg_fetch_row($result2) > 0) {
			pg_close($conn);
			return true;
		}
		pg_close($conn);
		return false;
	}

	function movePage() {
<<<<<<< HEAD
<<<<<<< HEAD
		if($_SESSION['id']%2>0) {
			$_SESSION["username"] = $_POST['username'];
			session_start();
			header("Location: index.php?id=".$_SESSION['id']);
		}
		elseif ($_SESSION['id']%2==0) {
			$_SESSION["username"] = $_POST['username'];
			session_start();
			header("Location: index.php?id=".$_SESSION['id']);
=======
		if($_SESSION['id']===0) {
			$_SESSION["username"] = $_POST['username'];
			session_start();
=======
		if($_SESSION['id']===0) {
			$_SESSION["username"] = $_POST['username'];
			session_start();
>>>>>>> 6e4adb03b39b5e4b37cf330fb9f6886b2359ed86
			header("Location: lihatlowonganadmin.php");
		}
		else if($_SESSION['id']%2>0) {
			$_SESSION["username"] = $_POST['username'];
			session_start();
			header("Location: lihatlowonganmhs.php");
		}
		elseif ($_SESSION['id']%2==0) {
			$_SESSION["username"] = $_POST['username'];
			session_start();
			header("Location: lihatlowongandosen.php");
<<<<<<< HEAD
>>>>>>> 6e4adb03b39b5e4b37cf330fb9f6886b2359ed86
=======
>>>>>>> 6e4adb03b39b5e4b37cf330fb9f6886b2359ed86
		}
	}
  
?>

<head>
	<title>Login - SI Asisten</title>
	<meta charset="utf-8">
	<meta name="description" content="Tugas Kelompok Basdat - A05">
    <meta name="author" content="Imanda Minara Putri, Meitya Dianti, Muthia Nabila">
	<link rel="stylesheet" href="bootstrap/css/bootstrap.min.css" type="text/css" media="all" />
</head>

<body>

<nav class="navbar navbar-inverse">
	<div class="container-fluid">
		<div class="navbar-header">
			<a class="navbar-brand" href="#">Sistem Informasi Asistensi</a>
		</div>
		<ul class="nav navbar-nav navbar-right">
			<li><a href="login.php"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
		</ul>
	</div>
</nav>

<div class="container">
	<div class="well">
	<h2>Login</h2>
	<br>
	<div class="col-md-3">
		<form class="form-horizontal" method="post" action="">
			<div class="form-group">
				<div class="input-group">
					<span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
					<input id="username" type="text" class="form-control" name="username" placeholder="Username" required>
				</div>
				<br>
				<div class="input-group">
					<span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
					<input id="password" type="password" class="form-control" name="password" placeholder="Password" required>
				</div>
				<br>
			</div>
			<div class="form-group">        
				<button id="submit" type="submit" name="sbmt" class="btn btn-default">Login</button>
			</div>
		</form>
	</div>
	</div>
</div>


</body>

<br><br>
<footer id="copyright" class="container">
	<p>&copy; A05 SIAsisten. All rights reserved.</p>
</footer>