CREATE SCHEMA SIASISTEN;

SET search_path to SIASISTEN;

CREATE TABLE MATA_KULIAH (
kode char(10) PRIMARY KEY,
nama varchar(100) not null,
prasyarat_dari char(10) REFERENCES MATA_KULIAH(kode)
ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE TERM (
tahun INT,
semester INT,
PRIMARY KEY (tahun, semester)
);

CREATE TABLE KELAS_MK (
idkelasmk SERIAL PRIMARY KEY,
tahun INT not null,
semester INT not null,
FOREIGN KEY(tahun, semester) REFERENCES TERM(tahun, semester)
ON DELETE RESTRICT ON UPDATE CASCADE,
kode_mk char(10) not null REFERENCES MATA_KULIAH(kode)
ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE DOSEN (
nip varchar(20) PRIMARY KEY,
nama varchar(100) not null,
username varchar(30) not null,
password varchar(20) not null,
email varchar(100) not null,
universitas varchar(100) not null,
fakultas varchar(100) not null
);

CREATE TABLE MAHASISWA (
npm char(10) PRIMARY KEY,
nama varchar(100) not null,
username varchar(30) not null,
password varchar(20) not null,
email varchar(100) not null,
email_aktif varchar(100),
waktu_kosong varchar(100),
bank varchar(100),
norekening varchar(100),
url_mukatab varchar(100),
url_foto varchar(100)
);

CREATE TABLE TELEPON_MAHASISWA (
npm char(10) REFERENCES MAHASISWA(npm),
nomortelepon varchar(20) not null,
PRIMARY KEY (npm, nomortelepon)
);

CREATE TABLE MHS_MENGAMBIL_KELAS_MK (
npm char(10) REFERENCES MAHASISWA(npm)
ON DELETE RESTRICT ON UPDATE CASCADE,
idkelasmk INT REFERENCES KELAS_MK(idkelasmk)
ON DELETE RESTRICT ON UPDATE CASCADE,
PRIMARY KEY (npm, idkelasmk),
nilai numeric(5,2)
);

CREATE TABLE DOSEN_KELAS_MK (
nip varchar(20) REFERENCES DOSEN(nip)
ON DELETE RESTRICT ON UPDATE CASCADE,
idkelasmk INT REFERENCES KELAS_MK(idkelasmk)
ON DELETE RESTRICT ON UPDATE CASCADE,
PRIMARY KEY (nip, idkelasmk)
);

CREATE TABLE LOWONGAN (
idlowongan SERIAL PRIMARY KEY,
idkelasmk int not null REFERENCES KELAS_MK(idkelasmk)
ON DELETE RESTRICT ON UPDATE CASCADE,
status boolean not null DEFAULT FALSE,
jumlah_asisten INT not null DEFAULT 0,
syarat_tambahan varchar(100),
nipdosenpembuka varchar(20) not null REFERENCES DOSEN(nip)
ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE STATUS_LAMARAN (
id INT PRIMARY KEY,
status varchar(20) not null
);

CREATE TABLE LAMARAN (
idlamaran SERIAL,
npm char(10) REFERENCES MAHASISWA(npm)
ON DELETE RESTRICT ON UPDATE CASCADE,
PRIMARY KEY (idlamaran, npm),
idlowongan INT not null REFERENCES LOWONGAN(idlowongan)
ON DELETE RESTRICT ON UPDATE CASCADE,
id_st_lamaran INT not null REFERENCES STATUS_LAMARAN(id)
ON DELETE RESTRICT ON UPDATE CASCADE,
ipk numeric(3,2) not null,
jumlahsks INT not null,
nip varchar(20) REFERENCES DOSEN(nip)
ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE STATUS_LOG (
id INT PRIMARY KEY,
status varchar(10) not null
);

CREATE TABLE KATEGORI_LOG (
id INT PRIMARY KEY,
kategori varchar(50) not null
);

CREATE TABLE LOG (
idlog SERIAL PRIMARY KEY,
idlamaran INT not null,
npm char(10) not null,
FOREIGN KEY(idlamaran, npm) REFERENCES LAMARAN(idlamaran, npm)
ON DELETE RESTRICT ON UPDATE CASCADE,
id_kat_log INT not null REFERENCES KATEGORI_LOG(id)
ON DELETE RESTRICT ON UPDATE CASCADE,
id_st_log INT not null REFERENCES STATUS_LOG(id)
ON DELETE RESTRICT ON UPDATE CASCADE,
tanggal timestamp not null,
jam_mulai timestamp not null,
jam_selesai timestamp not null,
deskripsi_kerja varchar(100) not null
);
