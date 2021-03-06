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
		<nav class="navbar navbar-inverse">
			<div class="container-fluid">
				<div class="navbar-header">
					<a class="navbar-brand" href="#">Sistem Informasi Asistensi</a>
				</div>
				<ul class="nav navbar-nav">
					<li><a href="lihatlowongandosen.php">Daftar Lowongan</a></li>
				</ul>
				<ul class="nav navbar-nav navbar-right">
					<li><a href="logout.php"><span class="glyphicon glyphicon-log-out"></span> Logout</a></li>
				</ul>
			</div>
		</nav>


		<div class="container">
		    <h1>Daftar Lowongan Asisten</h1>
		    <h6><span style="color:red">Dosen: Helen Woods</span></h6>
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
	        				<th>Jumlah Asisten Dibutuhkan</th>
	        				<th>Jumlah Pelamar</th>
	        				<th>Jumlah Pelamar Diterima</th>
	        				<th>Action</th>
	      				</tr>
	    			</thead>
	    			<tbody>
	    				<tr>
	        				<th>UIST601014</th>
	        				<th>Matematika Dasar 1</th>
	        				<th>Helen Woods, Cheryl Cooper</th>
	        				<th>Tutup</th>
	        				<th>2</th>
	        				<th>5</th>
	        				<th>2</th>
	        				<th><button>Edit</button><button>Delete</button></th>
	      				</tr>
	      				<tr>
	        				<th>CSGE602070</th>
	        				<th>Basis Data</th>
	        				<th>Willie Morales, Helen Woods</th>
	        				<th>Buka</th>
	        				<th>3</th>
	        				<th>3</th>
	        				<th>1</th>
	        				<th><button>Edit</button><button>Delete</button></th>
	      				</tr>
					</tbody>
				</table>
			</div>
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
		url: 'lowongandosen.php',
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