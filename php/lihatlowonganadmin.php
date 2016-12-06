<?php

	include "conn.php";
	
	if(!connect())
		die(pg_last_error());
		
/*    session_start();
    if(!isset($_SESSION["email"])){
        header("Location: login.php");
    }

	if($_SESSION["role"] == 'LA'){
        header("Location: login.php");
     }
	 
    $nama = $_SESSION["nama"];
    $address = $_SESSION["alamat"];
    $role = $_SESSION["role"];
	$email = $_SESSION["email"];*/
?>	
	
<!DOCTYPE html>
<html lang="en">
<head>
  	<meta charset="utf-8">
  	<title>Sistem Informasi Asisten</title>
  	
	<link rel="stylesheet" href="bootstrap/css/bootstrap.min.css" type="text/css" media="all" />
	
	<script type="text/javascript" src="bootstrap/js/jquery-1.11.3.min.js"></script>
	<script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>   
</head>

<body>

        <div id="wrapper">
		
		<nav class="navbar navbar-inverse">
		  <div class="container-fluid">
		    <div class="navbar-header">
		      <a class="navbar-brand" href="#">Sistem Informasi</a>
		    </div>
		    <ul class="nav navbar-nav">
		      <li class="active"><a href="#">Daftar Lowongan Asisten</a></li>
		      <li><a href="#">Profil Asisten</a></li>
		      <li><a href="#">Log Asistensi</a></li>
		    </ul>
		    <ul class="nav navbar-nav navbar-right">
		      <li><a href="#"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
		    </ul>
		  </div>
		</nav>

        <div id="page-wrapper">

            <div class="container">
		    <h1>Daftar Lowongan Asisten</h1>
		    <h6><span style="color:red">Admin</span></h6>
		    <button type="button" class="btn btn-primary">Tambah</button>
		    <br><br>
				<div class="table table-responsive">
					<table class="table table-striped">
						<thead>
							<tr>
								<th>Kode</th>
								<th>Mata Kuliah</th>
								<th>Dosen Pengajar</th>
								<th>Status</th>
								<th>Jumlah Lowongan</th>
								<th>Jumlah Pelamar</th>
								<th>Jumlah Pelamar Diterima</th>
								<th>Action</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<th>UIST601014</th>
								<th>Matematika Dasar 1</th>
								<th>Walter Porter</th>
								<th>Tutup</th>
								<th>2</th>
								<th>5</th>
								<th>2</th>
								<th><span class="glyphicon glyphicon-edit"><span class="glyphicon glyphicon-remove"></th>
							</tr>
						</tbody>
					</table>
				</div>
				<button class="btn-primary" onclick="prev()">Prev</button>
				<button class="btn-primary" onclick="next()">Next</button>
			</div>
        </div>
        <!-- /#page-wrapper -->
    </div>    
</body>
<br><br>
<footer id="copyright" class="container">
		<p>&copy; A05 SIAsisten. All rights reserved.</p>
	</footer>
</html>

<script>
	
	var limit = 10;
	function sort(){
	$.ajax({
		method: "get",
		url: 'lowongan.php',
		data: {limit:limit},
		success: function(data){
			$(".table-responsive").html(data);
		}
	});
	}
	sort();
	
	
	function next(){
		if(limit < 60)
			limit += 10;
		sort();
	}
	
	function prev(){
		if(limit != 10)
			limit -= 10;
		sort();
	}

</script>
