<?php
	include "conn.php";
	
	if(!connect())
		die(pg_last_error());
	
	$limit= $_GET['limit'];
	$min = $limit - 10;
		
	$query = "(Select kelas_mk.kode_mk, mata_kuliah.nama, dosen.nama, lowongan.status, jumlah_asisten, jumlah_pelamar, jumlah_diterima, status_lamaran.status as status2 
from siasisten.lowongan, siasisten.kelas_mk, siasisten.mata_kuliah, siasisten.dosen, siasisten.dosen_kelas_mk, siasisten.status_lamaran, siasisten.lamaran
where kelas_mk.idkelasmk = lowongan.idkelasmk AND kelas_mk.kode_mk = mata_kuliah.kode AND dosen_kelas_mk.nip = dosen.nip AND dosen_kelas_mk.idkelasmk = lowongan.idkelasmk AND lowongan.nipdosenpembuka = dosen.nip AND lamaran.npm='1310336628' AND lamaran.id_st_lamaran=status_lamaran.id AND lowongan.idlowongan=lamaran.idlowongan order by kelas_mk.kode_mk)
UNION (
(Select kelas_mk.kode_mk,mata_kuliah.nama,dosen.nama, status, jumlah_asisten, jumlah_pelamar, jumlah_diterima, null as status2
from siasisten.lowongan, siasisten.kelas_mk, siasisten.mata_kuliah, siasisten.dosen, siasisten.dosen_kelas_mk
where kelas_mk.idkelasmk = lowongan.idkelasmk AND kelas_mk.kode_mk = mata_kuliah.kode AND dosen_kelas_mk.nip = dosen.nip AND dosen_kelas_mk.idkelasmk = lowongan.idkelasmk AND lowongan.nipdosenpembuka = dosen.nip order by kelas_mk.kode_mk)
Except
(Select kelas_mk.kode_mk,mata_kuliah.nama,dosen.nama, lowongan.status, jumlah_asisten, jumlah_pelamar, jumlah_diterima, null as status2
from siasisten.lowongan, siasisten.kelas_mk, siasisten.mata_kuliah, siasisten.dosen, siasisten.dosen_kelas_mk, siasisten.status_lamaran, siasisten.lamaran
where kelas_mk.idkelasmk = lowongan.idkelasmk AND kelas_mk.kode_mk = mata_kuliah.kode AND dosen_kelas_mk.nip = dosen.nip AND dosen_kelas_mk.idkelasmk = lowongan.idkelasmk AND lowongan.nipdosenpembuka = dosen.nip AND lamaran.npm='1310336628' AND lamaran.id_st_lamaran=status_lamaran.id AND lowongan.idlowongan=lamaran.idlowongan order by kelas_mk.kode_mk)) order by status2
 			offset " . $min . " limit 10";

	if(!$res = pg_query($query))
		die(pg_last_error());
		
	$result = "";
	
		$result = $result . "<div class='table table-responsive'>
					<table class='table table-striped'>
						<thead>
							<tr>
								<th>Kode</th>
								<th>Mata Kuliah</th>
								<th>Pengajar</th>
								<th>Status Lowongan</th>
								<th>Jumlah Asisten Dibutuhkan</th>
								<th>Jumlah Pelamar</th>
								<th>Jumlah Pelamar Diterima</th>
								<th>Status Lamaran</th>
								<th>Action</th>
							</tr>
						</thead>
						<tbody>"; 
	
	
	while($line =pg_fetch_row($res)) {
	
		$result = $result . "<tr>\n";
		
		$result = $result . "<td>".$line[0]."</td><td>".$line[1]."</td><td>".$line[2]."</td>\n";
		
		if ($line[3]=='f')
			$col_value = "Tutup";
		else
			$col_value = "Buka";
		
		$result = $result . "<td>".$col_value."</td><td>".$line[4]."</td><td>".$line[5]."</td><td>".$line[6]."</td><td>".$line[7]."</td>\n";
		
		if ($line[7]=='melamar' || $line[7]=='direkomendasikan') {
			$result = $result . "<td><button>Batal</button></td>\n";
    	} else if ($line[7]=='diterima' || $line[7]=='ditolak') {
    		$result = $result . "<td></td>\n";
    	} else {
    		$result = $result . "<td><button>Daftar</button></td>\n";
    	}

		$result = $result . "</tr>\n";
	}
	
	$result = $result . "</tbody></table></div>\n";
	pg_close();
	echo $result;
?> 