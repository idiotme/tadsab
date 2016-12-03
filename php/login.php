<?php
	session_start();
	/*if(isset($_SESSION["userlogin"])){
		if($_SESSION["role"]==='dosen') {
			header("Location: index.php");
		}
		elseif($_SESSION['role']==='mhs') {
			header("Location: pemesanan.php");
		}
		elseif ($_SESSION['role']==='admin') {
			header("Location: pembelian.php");
		}
	}*/
	$_SESSION['idrow'] = 0;
	$_SESSION['one_row'] = true;

	require "conn.php";

	$alert = "";
	if(isset($_POST["email"])){
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
		
		if (pg_fetch_row($result) > 0) {
			pg_close($conn);
			$_SESSION['role'] = 'mhs';
			return true;
		}
		else if (pg_fetch_row($result) > 0) {
			pg_close($conn);
			$_SESSION['role'] = 'dosen';
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
		
		if (pg_fetch_row($result) > 0) {
			pg_close($conn);
			return true;
		}
		else if (pg_fetch_row($result) > 0) {
			pg_close($conn);
			return true;
		}
		pg_close($conn);
		return false;
	}

	function movePage() {
		if($_SESSION['role']==='mhs') {
			$_SESSION["userlogin"] = $_POST['username'];
			session_start();
			header("Location: index1.php");
		}
		elseif ($_SESSION['role']==='dosen') {
			$_SESSION["userlogin"] = $_POST['username'];
			session_start();
			header("Location: index.php");
		} elseif ($_SESSION['role']==='admin') {
			$_SESSION["userlogin"] = $_POST['username'];
			session_start();
			header("Location: index.php");
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
		<ul class="nav navbar-nav">
			<li><a href="#">Daftar Lowongan</a></li>
			<li><a href="#">Profil Asisten</a></li>
			<li><a href="#">Log Asistensi</a></li>
		</ul>
		<ul class="nav navbar-nav navbar-right">
			<li><a href="#"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
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
				<button id="submit" type="submit" class="btn btn-default">Login</button>
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