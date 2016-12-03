<?php
	require 'conn.php';

	if(!connect())
		die(pg_last_error());
		
	session_start();
		$passwdErr = $userErr = "";

	if(isset($_POST['username'])){
		if(login($_POST['username'], $_POST['password'])){
			//tambahkan session, kemudian redirect
			header("Location: index.php");
		}
	}


  	function login($username, $password){
		//validate()
		//cek ke database
		$conn = connect();

		$sql_mahasiswa = "SELECT * FROM siasisten.mahasiswa WHERE username='$username' AND password='$password';";
		$sql_dosen = "SELECT * FROM siasisten.dosen WHERE username='$username' AND password='$password';";
		$namelist1 = "SELECT username FROM siasisten.mahasiswa WHERE username='$username';";
		$namelist2 = "SELECT username FROM siasisten.dosen WHERE username='$username';";
		$result = pg_query($sql_mahasiswa);
		$result2 = pg_query($sql_dosen);
		$result3 = pg_query($namelist1);
		$result4 = pg_query($namelist2);

		if(pg_num_rows($result) > 0){
		pg_close();
			while($row = pg_fetch_assoc($result)) {
				$_SESSION['username'] = $row['username'];
				$_SESSION['password'] = $row['password'];
				return true;
			}
		}

		else if(pg_num_rows($result2) > 0){
		pg_close();
			while($row = pg_fetch_assoc($result)) {
				$_SESSION['username'] = $row['username'];
				$_SESSION['password'] = $row['password'];
				return true;
			}
		}

		else if (pg_fetch_assoc($result3) == 0) {
			pg_close();
			$userErr="Invalid email";
			echo "Invalid email.<br>" ;
			return false;
		}

		else if (pg_fetch_assoc($result4) == 0) {
			pg_close();
			$userErr="Invalid email";
			echo "Invalid email.<br>" ;
			return false;
		}

		else {
			pg_close();
			$passwdErr="Invalid password";
			echo "Invalid password.<br>";
			return false;
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
		<form class="form-horizontal">
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
				<button type="submit" class="btn btn-default">Login</button>
			</div>
		</form>
	</div>
	</div>
</div>


</body>

<script src="bootstrap/js/bootstrap.min.js"/>
<script type="text/javascript" type="javascript" src="jquery-2.1.4.min.js" />
<script type="text/javascript" type="javascript" src="jquery-2.1.4.js" />
<script type="text/javascript" type="javascript" src="javascript.js" />

<br><br>
<footer id="copyright" class="container">
	<p>&copy; A05 SIAsisten. All rights reserved.</p>
</footer>