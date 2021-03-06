<?php

	include "conn.php";
	
	if(!connect())
		die(pg_last_error());
		
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
					<a class="navbar-brand" href="#">Sistem Informasi Asistensi</a>
				</div>
				<ul class="nav navbar-nav">
					<li><a href="lihatlowonganadmin.php">Daftar Lowongan</a></li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li><a href="logout.php"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
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
		url: 'lowonganadmin.php',
		data: {limit:limit},
		success: function(data){
			$(".table-responsive").html(data);
		}
	});
	}
	sort();
	
	
	function next(){
		limit += 10;
		sort();
	}
	
	function prev(){
		if(limit != 10)
			limit -= 10;
		sort();
	}

</script>
