CREATE SCHEMA SIASISTEN;

SET search_path to SIASISTEN;

CREATE TABLE MATA_KULIAH (
kode char(10) PRIMARY KEY,
nama varchar(100) not null,
prasyarat_dari char(10) REFERENCES MATA_KULIAH(kode)
ON DELETE CASCADE ON UPDATE CASCADE
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
ON DELETE CASCADE ON UPDATE CASCADE,
kode_mk char(10) not null REFERENCES MATA_KULIAH(kode)
ON DELETE CASCADE ON UPDATE CASCADE
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
ON DELETE CASCADE ON UPDATE CASCADE,
idkelasmk INT REFERENCES KELAS_MK(idkelasmk)
ON DELETE CASCADE ON UPDATE CASCADE,
PRIMARY KEY (npm, idkelasmk),
nilai numeric(5,2)
);

CREATE TABLE DOSEN_KELAS_MK (
nip varchar(20) REFERENCES DOSEN(nip)
ON DELETE CASCADE ON UPDATE CASCADE,
idkelasmk INT REFERENCES KELAS_MK(idkelasmk)
ON DELETE CASCADE ON UPDATE CASCADE,
PRIMARY KEY (nip, idkelasmk)
);

CREATE TABLE LOWONGAN (
idlowongan SERIAL PRIMARY KEY,
idkelasmk int not null REFERENCES KELAS_MK(idkelasmk)
ON DELETE CASCADE ON UPDATE CASCADE,
status boolean not null DEFAULT FALSE,
jumlah_asisten INT not null DEFAULT 0,
syarat_tambahan varchar(100),
nipdosenpembuka varchar(20) not null REFERENCES DOSEN(nip)
ON DELETE CASCADE ON UPDATE CASCADE,
jumlah_pelamar INT DEFAULT 0,
jumlah_diterima INT DEFAULT 0
);

CREATE TABLE STATUS_LAMARAN (
id INT PRIMARY KEY,
status varchar(20) not null
);

CREATE TABLE LAMARAN (
idlamaran SERIAL,
npm char(10) REFERENCES MAHASISWA(npm)
ON DELETE CASCADE ON UPDATE CASCADE,
PRIMARY KEY (idlamaran, npm),
idlowongan INT not null REFERENCES LOWONGAN(idlowongan)
ON DELETE CASCADE ON UPDATE CASCADE,
id_st_lamaran INT not null REFERENCES STATUS_LAMARAN(id)
ON DELETE CASCADE ON UPDATE CASCADE,
ipk numeric(3,2) not null,
jumlahsks INT not null,
nip varchar(20) REFERENCES DOSEN(nip)
ON DELETE CASCADE ON UPDATE CASCADE
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
ON DELETE CASCADE ON UPDATE CASCADE,
id_kat_log INT not null REFERENCES KATEGORI_LOG(id)
ON DELETE CASCADE ON UPDATE CASCADE,
id_st_log INT not null REFERENCES STATUS_LOG(id)
ON DELETE CASCADE ON UPDATE CASCADE,
tanggal date not null,
jam_mulai time not null,
jam_selesai time not null,
deskripsi_kerja varchar(100) not null
);

-- insert mahasiswa --
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1310336628', 'Pamela Reyes', 'pamela.reyes' , 'ZQjH1FbqFFA', 'pamela.reyes@ui.ac.id', 'preyes1m@adobe.com', 'Senin-Selasa 12-14 Rabu-Jumat 16-19', 'BRI', '1002184460', 'http://dummyimage.com/128x207.png/ff4444/ffffff', 'https://robohash.org/perferendisquodvitae.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1325307320', 'Anthony Knight', 'anthony.knight' , 'IkTLsOj', 'anthony.knight@ui.ac.id', 'aknight2t@uol.com.br', 'Sabtu-Minggu 9-15', 'Mandiri', '1000617570', 'http://dummyimage.com/190x157.png/5fa2dd/ffffff', 'https://robohash.org/voluptatemdignissimosconsequuntur.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1326719892', 'Beverly Alvarez', 'beverly.alvarez' , 'lasRtl8c', 'beverly.alvarez@ui.ac.id', 'balvarezx@cargocollective.com', 'Senin 18-20 Selasa 19-21 Rabu 16-20 Kamis 10-14 Jumat 12-15', 'BCA', '1002356661', 'http://dummyimage.com/113x179.png/cc0000/ffffff', 'https://robohash.org/dolorquissit.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1330626780', 'Keith Patterson', 'keith.patterson' , 'pNiKENbhcT5', 'keith.patterson@ui.ac.id', 'kpatterson2f@flickr.com', 'Senin 18-20 Selasa 19-21 Rabu 16-20 Kamis 10-14 Jumat 12-15', 'Mandiri', '1001010491', 'http://dummyimage.com/139x188.png/dddddd/000000', 'https://robohash.org/temporibussitminus.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1334756654', 'Howard Stone', 'howard.stone' , 'Wr2siZsR7', 'howard.stone@ui.ac.id', 'hstone37@noaa.gov', 'Kamis 19-21 Sabtu 8-15', 'BNI', '1003412444', 'http://dummyimage.com/187x241.png/dddddd/000000', 'https://robohash.org/nisicumqueodit.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1336118599', 'Brian Carr', 'brian.carr' , 'tjqjwTSRf', 'brian.carr@ui.ac.id', 'bcarr2r@salon.com', 'Senin 12-16 Selasa 18-21 Rabu 10-12 Kamis 18-21 Jumat 19-22', 'BNI', '1004283037', 'http://dummyimage.com/118x126.png/cc0000/ffffff', 'https://robohash.org/corporisdoloremnihil.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1338545712', 'Maria Nichols', 'maria.nichols' , 'TxBuB5aisG', 'maria.nichols@ui.ac.id', 'mnichols23@alibaba.com', 'Senin-Kamis 16-20', 'BCA', '1008080574', 'http://dummyimage.com/192x100.png/cc0000/ffffff', 'https://robohash.org/occaecatietet.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1342894931', 'David Coleman', 'david.coleman' , '2gofLi5NV', 'david.coleman@ui.ac.id', 'dcoleman2q@businessweek.com', 'Rabu 8-16 Sabtu 8-12', 'BCA', '1008519109', 'http://dummyimage.com/167x165.png/5fa2dd/ffffff', 'https://robohash.org/magnamquiaautem.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1343426119', 'Charles Carr', 'charles.carr' , 'zDHE7r5Ezmi', 'charles.carr@ui.ac.id', 'ccarr7@lycos.com', 'Selasa-Jumat 18-22', 'BRI', '1009776256', 'http://dummyimage.com/213x195.png/ff4444/ffffff', 'https://robohash.org/quisadipisciqui.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1345684665', 'Christine Kennedy', 'christine.kennedy' , 'YghJezPY0vhK', 'christine.kennedy@ui.ac.id', 'ckennedy20@fema.gov', 'Kamis 19-21 Sabtu 8-15', 'BNI', '1000460350', 'http://dummyimage.com/139x246.png/dddddd/000000', 'https://robohash.org/undeautaut.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1346885475', 'Emily Dunn', 'emily.dunn' , 'kAlUY9l9I6c', 'emily.dunn@ui.ac.id', 'edunn2i@usatoday.com', 'Kamis-Jumat 17-21 Sabtu 8-12', 'BCA', '1008748619', 'http://dummyimage.com/247x225.png/ff4444/ffffff', 'https://robohash.org/eaqueerrorquam.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1348477830', 'Harold Kennedy', 'harold.kennedy' , 'thoJ8tS', 'harold.kennedy@ui.ac.id', 'hkennedyg@wikimedia.org', 'Rabu 8-16 Sabtu 8-12', 'BCA', '1009665892', 'http://dummyimage.com/195x242.png/5fa2dd/ffffff', 'https://robohash.org/temporaquiodit.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1351514621', 'Victor Nelson', 'victor.nelson' , 'FLLF51wiPp', 'victor.nelson@ui.ac.id', 'vnelson2j@github.io', 'Selasa 10-12 Rabu-Jumat 18-21', 'BNI', '1003092722', 'http://dummyimage.com/174x106.png/ff4444/ffffff', 'https://robohash.org/ullaminhic.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1351614361', 'Kelly Olson', 'kelly.olson' , 'C1vltSjrg', 'kelly.olson@ui.ac.id', 'kolson1@pinterest.com', 'Kamis 19-21 Sabtu 8-15', 'BNI', '1007463013', 'http://dummyimage.com/218x143.png/ff4444/ffffff', 'https://robohash.org/avoluptateset.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1353569963', 'Harold Lee', 'harold.lee' , 'MVbYpH', 'harold.lee@ui.ac.id', 'hlee32@foxnews.com', 'Selasa-Jumat 18-22', 'BRI', '1006326572', 'http://dummyimage.com/109x143.png/5fa2dd/ffffff', 'https://robohash.org/solutasitvoluptas.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1356727131', 'Lois Riley', 'lois.riley' , '9uRzYNK', 'lois.riley@ui.ac.id', 'lriley3@samsung.com', 'Senin-Kamis 16-20', 'BRI', '1004331566', 'http://dummyimage.com/211x150.png/dddddd/000000', 'https://robohash.org/accusamusvoluptascupiditate.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1361968372', 'Keith Nguyen', 'keith.nguyen' , 'XwFDhaY', 'keith.nguyen@ui.ac.id', 'knguyen1x@nih.gov', 'Sabtu-Minggu 9-15', 'BRI', '1000300581', 'http://dummyimage.com/161x158.png/ff4444/ffffff', 'https://robohash.org/aliquidundeeum.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1369145357', 'Frank Welch', 'frank.welch' , '9kFwXwTE', 'frank.welch@ui.ac.id', 'fwelchr@bbb.org', 'Senin 18-20 Selasa 19-21 Rabu 16-20 Kamis 10-14 Jumat 12-15', 'BCA', '1009309475', 'http://dummyimage.com/218x173.png/dddddd/000000', 'https://robohash.org/voluptatesomnisquo.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1381997233', 'Earl Patterson', 'earl.patterson' , 'UeLHU7B', 'earl.patterson@ui.ac.id', 'epatterson10@newsvine.com', 'Sabtu-Minggu 9-15', 'BNI', '1007101779', 'http://dummyimage.com/183x177.png/ff4444/ffffff', 'https://robohash.org/omnisquoquia.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1397301059', 'Theresa Hansen', 'theresa.hansen' , '4LYBsJVt', 'theresa.hansen@ui.ac.id', 'thansen5@nps.gov', 'Senin 18-20 Selasa 19-21 Rabu 16-20 Kamis 10-14 Jumat 12-15', 'BNI', '1005210649', 'http://dummyimage.com/161x181.png/5fa2dd/ffffff', 'https://robohash.org/nihilrerumvoluptas.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1413060204', 'Pamela Hughes', 'pamela.hughes' , 'xHRt5D6Fga', 'pamela.hughes@ui.ac.id', 'phughes2o@mac.com', 'Senin 12-16 Selasa 18-21 Rabu 10-12 Kamis 18-21 Jumat 19-22', 'BNI', '1001426049', 'http://dummyimage.com/116x192.png/5fa2dd/ffffff', 'https://robohash.org/veroconsecteturconsequuntur.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1423861028', 'Joseph Barnes', 'joseph.barnes' , 'OQ4zcLxYZ', 'joseph.barnes@ui.ac.id', 'jbarnes2a@fastcompany.com', 'Senin-Selasa 12-14 Rabu-Jumat 16-19', 'BNI', '1003453138', 'http://dummyimage.com/142x118.png/cc0000/ffffff', 'https://robohash.org/illumaliquidexpedita.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1424482403', 'John Fowler', 'john.fowler' , 'MOBMD1', 'john.fowler@ui.ac.id', 'jfowler3k@cafepress.com', 'Senin 18-20 Selasa 19-21 Rabu 16-20 Kamis 10-14 Jumat 12-15', 'BNI', '1007122292', 'http://dummyimage.com/203x105.png/cc0000/ffffff', 'https://robohash.org/cumassumendasimilique.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1430434808', 'Harry Riley', 'harry.riley' , 'elqDgq1nys', 'harry.riley@ui.ac.id', 'hriley21@chicagotribune.com', 'Senin Rabu Jumat 12-16 Sabtu 8-12', 'BNI', '1003246599', 'http://dummyimage.com/146x108.png/cc0000/ffffff', 'https://robohash.org/sediustoquisquam.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1434025676', 'Juan Armstrong', 'juan.armstrong' , 'RjArd1P', 'juan.armstrong@ui.ac.id', 'jarmstrong25@goo.gl', 'Kamis 19-21 Sabtu 8-15', 'BCA', '1004334545', 'http://dummyimage.com/215x202.png/cc0000/ffffff', 'https://robohash.org/idatunde.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1434634220', 'Edward Dixon', 'edward.dixon' , 'Birw55jZ2u1', 'edward.dixon@ui.ac.id', 'edixonf@archive.org', 'Senin-Kamis 16-20', 'BNI', '1002892127', 'http://dummyimage.com/208x123.png/dddddd/000000', 'https://robohash.org/liberoquaeratipsam.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1434772514', 'Sean Henry', 'sean.henry' , '77jim6TSb8H', 'sean.henry@ui.ac.id', 'shenry12@illinois.edu', 'Selasa 10-12 Rabu-Jumat 18-21', 'BNI', '1009384554', 'http://dummyimage.com/126x181.png/cc0000/ffffff', 'https://robohash.org/reiciendisconsequaturest.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1443792198', 'Amanda Daniels', 'amanda.daniels' , '3zuEgQP0', 'amanda.daniels@ui.ac.id', 'adaniels11@woothemes.com', 'Kamis-Jumat 17-21 Sabtu 8-12', 'BRI', '1005788201', 'http://dummyimage.com/223x131.png/cc0000/ffffff', 'https://robohash.org/voluptaspariaturdolorem.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1448148411', 'Diane Stone', 'diane.stone' , 'ODa8GO3X0d', 'diane.stone@ui.ac.id', 'dstone0@wordpress.org', 'Senin 12-16 Selasa 18-21 Rabu 10-12 Kamis 18-21 Jumat 19-22', 'BNI', '1002027305', 'http://dummyimage.com/241x195.png/cc0000/ffffff', 'https://robohash.org/verocumquequi.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1457809988', 'Andrea Phillips', 'andrea.phillips' , 'O23H4lG', 'andrea.phillips@ui.ac.id', 'aphillips36@hud.gov', 'Kamis-Jumat 17-21 Sabtu 8-12', 'BNI', '1007316584', 'http://dummyimage.com/152x107.png/dddddd/000000', 'https://robohash.org/adipisciveroquo.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1461665387', 'Alice Hunter', 'alice.hunter' , 'IyfBq351', 'alice.hunter@ui.ac.id', 'ahunter28@si.edu', 'Senin Selasa Jumat 18-20 Sabtu 8-12', 'Mandiri', '1001559220', 'http://dummyimage.com/216x102.png/ff4444/ffffff', 'https://robohash.org/possimusculpaiure.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1464327110', 'Jacqueline Baker', 'jacqueline.baker' , '7Marc4pAZ', 'jacqueline.baker@ui.ac.id', 'jbaker1j@marriott.com', 'Senin 18-20 Selasa 19-21 Rabu 16-20 Kamis 10-14 Jumat 12-15', 'BCA', '1001185837', 'http://dummyimage.com/171x168.png/ff4444/ffffff', 'https://robohash.org/voluptatibusfugiatquo.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1464560128', 'Joyce Palmer', 'joyce.palmer' , 'G99Dgh1', 'joyce.palmer@ui.ac.id', 'jpalmerk@pcworld.com', 'Rabu 8-16 Sabtu 8-12', 'BRI', '1005956733', 'http://dummyimage.com/220x165.png/cc0000/ffffff', 'https://robohash.org/temporanondelectus.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1466418063', 'George Cook', 'george.cook' , 'lw4wKrWV9bE', 'george.cook@ui.ac.id', 'gcook1t@rediff.com', 'Sabtu-Minggu 9-15', 'BNI', '1009945278', 'http://dummyimage.com/176x244.png/cc0000/ffffff', 'https://robohash.org/totamquifugit.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1474480808', 'Ann Harrison', 'ann.harrison' , 'Uk1g5laDyVkd', 'ann.harrison@ui.ac.id', 'aharrison1y@mtv.com', 'Kamis 19-21 Sabtu 8-15', 'BCA', '1002875400', 'http://dummyimage.com/207x219.png/dddddd/000000', 'https://robohash.org/quasietlaborum.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1475329393', 'Billy Graham', 'billy.graham' , '9IiCFtrlIgq', 'billy.graham@ui.ac.id', 'bgraham1i@elegantthemes.com', 'Senin 18-20 Selasa 19-21 Rabu 16-20 Kamis 10-14 Jumat 12-15', 'Mandiri', '1000096593', 'http://dummyimage.com/242x101.png/5fa2dd/ffffff', 'https://robohash.org/delectussequirepellat.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1479329901', 'Kimberly Garcia', 'kimberly.garcia' , 'DU15Oj', 'kimberly.garcia@ui.ac.id', 'kgarcia2g@loc.gov', 'Senin 12-16 Selasa 18-21 Rabu 10-12 Kamis 18-21 Jumat 19-22', 'BNI', '1000540911', 'http://dummyimage.com/243x164.png/ff4444/ffffff', 'https://robohash.org/nobisilloet.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1481986965', 'Thomas Alvarez', 'thomas.alvarez' , 'ByAHPctZ', 'thomas.alvarez@ui.ac.id', 'talvarez3f@joomla.org', 'Kamis 19-21 Sabtu 8-15', 'BNI', '1004182498', 'http://dummyimage.com/149x250.png/dddddd/000000', 'https://robohash.org/autullamfacilis.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1484460963', 'Linda Watkins', 'linda.watkins' , '4meEMPhmQBy', 'linda.watkins@ui.ac.id', 'lwatkins2y@xrea.com', 'Selasa 10-12 Rabu-Jumat 18-21', 'BCA', '1005816584', 'http://dummyimage.com/179x206.png/dddddd/000000', 'https://robohash.org/eafaciliseum.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1497433723', 'Terry Fisher', 'terry.fisher' , 'HtlwZ9TqAzay', 'terry.fisher@ui.ac.id', 'tfisher2e@japanpost.jp', 'Selasa-Jumat 18-22', 'Mandiri', '1009938605', 'http://dummyimage.com/194x208.png/cc0000/ffffff', 'https://robohash.org/evenietutdeserunt.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1498711404', 'Harry West', 'harry.west' , 'vCIAyTg6ig', 'harry.west@ui.ac.id', 'hwest3e@nhs.uk', 'Selasa 10-12 Rabu-Jumat 18-21', 'BRI', '1006317638', 'http://dummyimage.com/188x186.png/ff4444/ffffff', 'https://robohash.org/quirerumaccusamus.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1500611520', 'Harold Castillo', 'harold.castillo' , '2lOqp3', 'harold.castillo@ui.ac.id', 'hcastillo16@google.com.br', 'Senin 12-16 Selasa 18-21 Rabu 10-12 Kamis 18-21 Jumat 19-22', 'BRI', '1000626999', 'http://dummyimage.com/124x244.png/dddddd/000000', 'https://robohash.org/voluptatesdolortotam.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1502798367', 'Marilyn Nelson', 'marilyn.nelson' , 'TGcNVZhzyXp', 'marilyn.nelson@ui.ac.id', 'mnelsont@yahoo.co.jp', 'Sabtu-Minggu 9-15', 'Mandiri', '1001343667', 'http://dummyimage.com/235x154.png/dddddd/000000', 'https://robohash.org/quiaeligendiipsum.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1513550028', 'Earl James', 'earl.james' , 'FOQjPjA', 'earl.james@ui.ac.id', 'ejameso@yolasite.com', 'Selasa-Jumat 18-22', 'Mandiri', '1005670712', 'http://dummyimage.com/107x144.png/ff4444/ffffff', 'https://robohash.org/nonutqui.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1519355800', 'Harry Cooper', 'harry.cooper' , 'iZyRts', 'harry.cooper@ui.ac.id', 'hcooper3b@mtv.com', 'Senin-Selasa 12-14 Rabu-Jumat 16-19', 'BCA', '1000903644', 'http://dummyimage.com/213x208.png/ff4444/ffffff', 'https://robohash.org/incidunteosdolor.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1520554292', 'Gloria Hall', 'gloria.hall' , '6I8udlm', 'gloria.hall@ui.ac.id', 'ghall2d@wiley.com', 'Selasa 10-12 Rabu-Jumat 18-21', 'BNI', '1007036348', 'http://dummyimage.com/150x125.png/dddddd/000000', 'https://robohash.org/ineligendidolorem.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1522929237', 'Willie Stephens', 'willie.stephens' , 'I3t5AQC20WS1', 'willie.stephens@ui.ac.id', 'wstephens15@mapy.cz', 'Senin Selasa Jumat 18-20 Sabtu 8-12', 'BRI', '1003981788', 'http://dummyimage.com/146x185.png/dddddd/000000', 'https://robohash.org/hicanimitempore.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1523179621', 'Peter Cole', 'peter.cole' , 'YPdek0HnXG', 'peter.cole@ui.ac.id', 'pcole22@usda.gov', 'Senin 18-20 Selasa 19-21 Rabu 16-20 Kamis 10-14 Jumat 12-15', 'BNI', '1007017786', 'http://dummyimage.com/239x103.png/dddddd/000000', 'https://robohash.org/isteautdolor.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1531978569', 'Kimberly James', 'kimberly.james' , 'tcfuxRl1vx3f', 'kimberly.james@ui.ac.id', 'kjames2@blogger.com', 'Rabu 8-16 Sabtu 8-12', 'Mandiri', '1006131449', 'http://dummyimage.com/197x132.png/ff4444/ffffff', 'https://robohash.org/quiadipisciipsum.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1534536188', 'Matthew Elliott', 'matthew.elliott' , 'JMbYASVGWwN', 'matthew.elliott@ui.ac.id', 'melliott2u@php.net', 'Sabtu-Minggu 9-15', 'BRI', '1007540375', 'http://dummyimage.com/153x138.png/cc0000/ffffff', 'https://robohash.org/officiisnihilullam.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1536204489', 'Linda Green', 'linda.green' , 'j8RyOSJml9', 'linda.green@ui.ac.id', 'lgreen2m@soup.io', 'Rabu 8-16 Sabtu 8-12', 'BCA', '1003631264', 'http://dummyimage.com/208x178.png/ff4444/ffffff', 'https://robohash.org/abnesciuntvoluptatem.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1537676327', 'Louis Carter', 'louis.carter' , 'PxGHpU57zdbg', 'louis.carter@ui.ac.id', 'lcarteri@accuweather.com', 'Senin 12-16 Selasa 18-21 Rabu 10-12 Kamis 18-21 Jumat 19-22', 'BNI', '1000596984', 'http://dummyimage.com/241x154.png/ff4444/ffffff', 'https://robohash.org/veleumtenetur.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1537763787', 'Margaret Sanchez', 'margaret.sanchez' , 'houewggpJaO', 'margaret.sanchez@ui.ac.id', 'msanchez1z@ucsd.edu', 'Rabu 8-16 Sabtu 8-12', 'BRI', '1008207198', 'http://dummyimage.com/175x209.png/5fa2dd/ffffff', 'https://robohash.org/possimusestperspiciatis.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1541112149', 'Louise Kelley', 'louise.kelley' , 'r4vz3pTg01we', 'louise.kelley@ui.ac.id', 'lkelley1p@cbsnews.com', 'Senin-Rabu 17-21', 'BCA', '1000511054', 'http://dummyimage.com/223x208.png/cc0000/ffffff', 'https://robohash.org/asperioresquiquia.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1543730517', 'Melissa Ryan', 'melissa.ryan' , 'w5CYV59IE', 'melissa.ryan@ui.ac.id', 'mryan2p@cisco.com', 'Senin Selasa Jumat 18-20 Sabtu 8-12', 'BCA', '1002855731', 'http://dummyimage.com/182x185.png/cc0000/ffffff', 'https://robohash.org/minusetcommodi.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1544876141', 'Theresa Cole', 'theresa.cole' , 'GO2Uet', 'theresa.cole@ui.ac.id', 'tcole2b@multiply.com', 'Senin-Rabu 17-21', 'BNI', '1008194649', 'http://dummyimage.com/145x144.png/cc0000/ffffff', 'https://robohash.org/explicaboassumendaomnis.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1551538884', 'Gerald Reid', 'gerald.reid' , '2ezSHDRndEJN', 'gerald.reid@ui.ac.id', 'greid9@com.com', 'Senin Rabu Jumat 12-16 Sabtu 8-12', 'Mandiri', '1006797074', 'http://dummyimage.com/105x189.png/cc0000/ffffff', 'https://robohash.org/quiquinihil.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1553234403', 'Carolyn Carr', 'carolyn.carr' , 'oCqG0wSmmFpE', 'carolyn.carr@ui.ac.id', 'ccarr1w@cmu.edu', 'Selasa 10-12 Rabu-Jumat 18-21', 'BCA', '1002377877', 'http://dummyimage.com/129x112.png/dddddd/000000', 'https://robohash.org/accusamusvoluptatescorporis.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1553285061', 'Patrick Watkins', 'patrick.watkins' , 'jzR090oT', 'patrick.watkins@ui.ac.id', 'pwatkins1d@oaic.gov.au', 'Senin-Rabu 17-21', 'BCA', '1005003579', 'http://dummyimage.com/185x124.png/dddddd/000000', 'https://robohash.org/veniambeataevelit.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1556224007', 'Melissa Anderson', 'melissa.anderson' , 'kSHWFfcImMkN', 'melissa.anderson@ui.ac.id', 'manderson6@irs.gov', 'Senin-Rabu 17-21', 'Mandiri', '1000131194', 'http://dummyimage.com/125x100.png/dddddd/000000', 'https://robohash.org/auteteos.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1565323056', 'Jeffrey Andrews', 'jeffrey.andrews' , 'F6AvzAEzq61', 'jeffrey.andrews@ui.ac.id', 'jandrewsm@yale.edu', 'Selasa 10-12 Rabu-Jumat 18-21', 'BRI', '1009872086', 'http://dummyimage.com/213x136.png/dddddd/000000', 'https://robohash.org/minusdebitisaut.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1565530109', 'Scott Johnson', 'scott.johnson' , 'KjsXIIYU', 'scott.johnson@ui.ac.id', 'sjohnson1a@tinypic.com', 'Senin Selasa Jumat 18-20 Sabtu 8-12', 'BRI', '1009277891', 'http://dummyimage.com/199x141.png/5fa2dd/ffffff', 'https://robohash.org/occaecatimollitiadolore.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1578715010', 'Jose Burns', 'jose.burns' , 'cVgk5T', 'jose.burns@ui.ac.id', 'jburns2x@microsoft.com', 'Senin 12-16 Selasa 18-21 Rabu 10-12 Kamis 18-21 Jumat 19-22', 'BRI', '1000851683', 'http://dummyimage.com/149x180.png/ff4444/ffffff', 'https://robohash.org/quinonautem.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1579420641', 'Debra Shaw', 'debra.shaw' , 'FT2CfM', 'debra.shaw@ui.ac.id', 'dshaw3a@senate.gov', 'Senin-Selasa 12-14 Rabu-Jumat 16-19', 'BNI', '1004888328', 'http://dummyimage.com/190x248.png/5fa2dd/ffffff', 'https://robohash.org/quiaoptiosunt.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1585593783', 'Gregory Daniels', 'gregory.daniels' , 'uVK4NSd3ga', 'gregory.daniels@ui.ac.id', 'gdaniels2v@google.es', 'Senin Selasa Jumat 18-20 Sabtu 8-12', 'BNI', '1000649706', 'http://dummyimage.com/156x161.png/cc0000/ffffff', 'https://robohash.org/ametautvel.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1587990264', 'David Garrett', 'david.garrett' , 'wblzbvTK', 'david.garrett@ui.ac.id', 'dgarrett33@opensource.org', 'Selasa 10-12 Rabu-Jumat 18-21', 'BCA', '1001413301', 'http://dummyimage.com/109x182.png/dddddd/000000', 'https://robohash.org/repellendusrationeillo.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1590403253', 'Richard Walker', 'richard.walker' , '2mI0EG', 'richard.walker@ui.ac.id', 'rwalker1k@army.mil', 'Senin 12-16 Selasa 18-21 Rabu 10-12 Kamis 18-21 Jumat 19-22', 'BRI', '1009799659', 'http://dummyimage.com/213x196.png/dddddd/000000', 'https://robohash.org/ametdolorumaliquid.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1591081787', 'James Thompson', 'james.thompson' , '4zhea3J6t2uH', 'james.thompson@ui.ac.id', 'jthompson1n@php.net', 'Selasa 10-12 Rabu-Jumat 18-21', 'BCA', '1003310391', 'http://dummyimage.com/236x244.png/dddddd/000000', 'https://robohash.org/autvoluptatemut.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1593738108', 'Lisa Griffin', 'lisa.griffin' , '3hCWIt8kD', 'lisa.griffin@ui.ac.id', 'lgriffin3h@wiley.com', 'Senin 12-16 Selasa 18-21 Rabu 10-12 Kamis 18-21 Jumat 19-22', 'BNI', '1003626885', 'http://dummyimage.com/205x240.png/cc0000/ffffff', 'https://robohash.org/impeditcupiditateofficiis.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1598258425', 'Jack Jones', 'jack.jones' , '1UvbTHE6Cfg', 'jack.jones@ui.ac.id', 'jjones1u@ustream.tv', 'Senin 18-20 Selasa 19-21 Rabu 16-20 Kamis 10-14 Jumat 12-15', 'BCA', '1000850307', 'http://dummyimage.com/160x152.png/ff4444/ffffff', 'https://robohash.org/autsuscipitarchitecto.png?size=50x50&set=set1');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1600162787', 'Matthew Lynch', 'matthew.lynch' , 'nn64as8', 'matthew.lynch@ui.ac.id', 'mlynch3i@fc2.com', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1600427963', 'Charles Simpson', 'charles.simpson' , 'LXqp7Z', 'charles.simpson@ui.ac.id', 'csimpsony@tinypic.com', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1601252466', 'Frank Vasquez', 'frank.vasquez' , 'IwPX88S', 'frank.vasquez@ui.ac.id', 'fvasquez2h@drupal.org', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1601868594', 'Howard Burton', 'howard.burton' , 'JTreGcQE3', 'howard.burton@ui.ac.id', 'hburton1s@storify.com', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1601895996', 'Mary Brown', 'mary.brown' , 'YgysiHFBDs', 'mary.brown@ui.ac.id', 'mbrown1q@dedecms.com', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1610590803', 'Katherine Hanson', 'katherine.hanson' , 'd8XQjf0S', 'katherine.hanson@ui.ac.id', 'khansonu@edublogs.org', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1611868053', 'Timothy Collins', 'timothy.collins' , 'Jz2ZOkKjrdg', 'timothy.collins@ui.ac.id', 'tcollins3d@jiathis.com', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1612436644', 'Ruth Wells', 'ruth.wells' , 'Sq9lfHYIt6R', 'ruth.wells@ui.ac.id', 'rwells2z@nhs.uk', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1612771331', 'Craig West', 'craig.west' , 'ZCAGw7aDx4', 'craig.west@ui.ac.id', 'cwest31@usa.gov', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1613278918', 'Evelyn Collins', 'evelyn.collins' , 'mwmD5uVOR7n', 'evelyn.collins@ui.ac.id', 'ecollins19@google.it', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1613768173', 'Scott Marshall', 'scott.marshall' , 'cOuLOKVJBtc', 'scott.marshall@ui.ac.id', 'smarshall17@comsenz.com', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1614589578', 'Barbara Owens', 'barbara.owens' , 'nF6hhxzrH5b', 'barbara.owens@ui.ac.id', 'bowens27@ezinearticles.com', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1615903472', 'Lori Lopez', 'lori.lopez' , 'cJnNr6Ggs8j7', 'lori.lopez@ui.ac.id', 'llopezh@weebly.com', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1621307141', 'Harry Hawkins', 'harry.hawkins' , 'h7N5YmMjn3', 'harry.hawkins@ui.ac.id', 'hhawkinsn@cargocollective.com', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1621367088', 'Shawn Fox', 'shawn.fox' , '78DAaSwRQG', 'shawn.fox@ui.ac.id', 'sfox29@cdbaby.com', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1621548059', 'Judy Allen', 'judy.allen' , 'zRVye0zOuD', 'judy.allen@ui.ac.id', 'jallen18@cornell.edu', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1624377963', 'Lois Henry', 'lois.henry' , 'braIkYTypT', 'lois.henry@ui.ac.id', 'lhenry2c@e-recht24.de', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1626145763', 'Sandra Morris', 'sandra.morris' , '0lG1gu', 'sandra.morris@ui.ac.id', 'smorris26@mayoclinic.com', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1627655930', 'Martin Hanson', 'martin.hanson' , '2lG7XxDk3', 'martin.hanson@ui.ac.id', 'mhansonj@eventbrite.com', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1628654093', 'Paul Ramirez', 'paul.ramirez' , 'zQo4YKPWZ', 'paul.ramirez@ui.ac.id', 'pramirez1b@cmu.edu', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1629341488', 'Brenda Parker', 'brenda.parker' , 'jSrS1122', 'brenda.parker@ui.ac.id', 'bparkers@usatoday.com', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1630375273', 'Shawn Perry', 'shawn.perry' , '8lSmwrRyW', 'shawn.perry@ui.ac.id', 'sperry1c@wunderground.com', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1631430261', 'Diane Stewart', 'diane.stewart' , 'T2rFGHBx1s', 'diane.stewart@ui.ac.id', 'dstewart2k@china.com.cn', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1631895869', 'Melissa Young', 'melissa.young' , '3F5eBzi0ovo', 'melissa.young@ui.ac.id', 'myoung1e@is.gd', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1632097254', 'Jerry Jenkins', 'jerry.jenkins' , 'OZn6GDv', 'jerry.jenkins@ui.ac.id', 'jjenkinsv@google.com.au', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1633571276', 'Juan Bell', 'juan.bell' , '5aX2V2CfFYc', 'juan.bell@ui.ac.id', 'jbell1o@is.gd', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1634841413', 'Donna Nelson', 'donna.nelson' , 'S6O4PhSobo', 'donna.nelson@ui.ac.id', 'dnelson1r@usda.gov', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1635545165', 'Randy Roberts', 'randy.roberts' , '1DJSDrCqJ', 'randy.roberts@ui.ac.id', 'rroberts1l@bloglovin.com', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1638738514', 'John Rodriguez', 'john.rodriguez' , 'MBZ4ug', 'john.rodriguez@ui.ac.id', 'jrodriguez39@rambler.ru', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1639013760', 'Phyllis Gilbert', 'phyllis.gilbert' , 'fCY8ONpq', 'phyllis.gilbert@ui.ac.id', 'pgilbert35@bandcamp.com', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1639388506', 'Irene Howell', 'irene.howell' , 'aSPLNL', 'irene.howell@ui.ac.id', 'ihowellp@cdbaby.com', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1641767007', 'Melissa Lane', 'melissa.lane' , 'U841vD3lRyd', 'melissa.lane@ui.ac.id', 'mlanez@aboutads.info', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1642071123', 'Larry Gomez', 'larry.gomez' , 'puWK1lq', 'larry.gomez@ui.ac.id', 'lgomez30@ucsd.edu', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1648029742', 'Anthony Armstrong', 'anthony.armstrong' , '0UnGZiEyyo', 'anthony.armstrong@ui.ac.id', 'aarmstrong3g@goodreads.com', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1648275051', 'Clarence Long', 'clarence.long' , 'sbEocOz4UKY', 'clarence.long@ui.ac.id', 'clong14@quantcast.com', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1648720334', 'Jennifer Lawrence', 'jennifer.lawrence' , 'TLCyEjLdc1', 'jennifer.lawrence@ui.ac.id', 'jlawrence2n@fema.gov', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1649366322', 'Ann Riley', 'ann.riley' , 'V9us8PFwoq', 'ann.riley@ui.ac.id', 'ariley1g@mit.edu', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1649637658', 'Benjamin Owens', 'benjamin.owens' , 'HKPfMze7k', 'benjamin.owens@ui.ac.id', 'bowens34@npr.org', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1652117701', 'Billy Fuller', 'billy.fuller' , 'oQpIGHr', 'billy.fuller@ui.ac.id', 'bfuller3j@is.gd', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1654079943', 'Jean Hamilton', 'jean.hamilton' , '2G5fWj', 'jean.hamilton@ui.ac.id', 'jhamiltonw@wunderground.com', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1655119637', 'Kathryn Rice', 'kathryn.rice' , 'RXpLlnTxwfk', 'kathryn.rice@ui.ac.id', 'krice38@slate.com', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1655703307', 'Tina Wagner', 'tina.wagner' , 'cAePEcN9', 'tina.wagner@ui.ac.id', 'twagner1f@addtoany.com', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1656936755', 'Charles Mcdonald', 'charles.mcdonald' , '2stPFNhI7zOT', 'charles.mcdonald@ui.ac.id', 'cmcdonald8@washingtonpost.com', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1658940907', 'Kathy Hunt', 'kathy.hunt' , 'X7GpCR', 'kathy.hunt@ui.ac.id', 'khunte@storify.com', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1661009381', 'Deborah Fox', 'deborah.fox' , 'ER1IbEhs', 'deborah.fox@ui.ac.id', 'dfox4@istockphoto.com', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1661203200', 'Katherine Andrews', 'katherine.andrews' , '0aGOBiw9', 'katherine.andrews@ui.ac.id', 'kandrews3c@samsung.com', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1661475085', 'Lori Fernandez', 'lori.fernandez' , 'ZqEqgIEAzuP', 'lori.fernandez@ui.ac.id', 'lfernandez13@mashable.com', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1663016043', 'Peter Brown', 'peter.brown' , 'opBRaRP3fB', 'peter.brown@ui.ac.id', 'pbrown2l@i2i.jp', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1668148959', 'Christine Castillo', 'christine.castillo' , 'aCjrmB1itI', 'christine.castillo@ui.ac.id', 'ccastillo2w@cloudflare.com', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1671118828', 'Louis Rose', 'louis.rose' , 'DjNAAfayo', 'louis.rose@ui.ac.id', 'lrosed@chronoengine.com', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1672657112', 'Shawn Walker', 'shawn.walker' , '3ceBVqL', 'shawn.walker@ui.ac.id', 'swalker2s@whitehouse.gov', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1673015048', 'Henry Roberts', 'henry.roberts' , 'RL9OQNEPvS0', 'henry.roberts@ui.ac.id', 'hroberts1v@ft.com', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1675501835', 'Robin James', 'robin.james' , 'DlT2IoS', 'robin.james@ui.ac.id', 'rjamesc@angelfire.com', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1676892272', 'Cheryl Bryant', 'cheryl.bryant' , 'd9dA7nDge9y', 'cheryl.bryant@ui.ac.id', 'cbryant24@businessinsider.com', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1677836795', 'Pamela Larson', 'pamela.larson' , 'a0e5eN4', 'pamela.larson@ui.ac.id', 'plarsona@si.edu', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1683426067', 'Donna Brown', 'donna.brown' , 'VtchP5', 'donna.brown@ui.ac.id', 'dbrown3l@umich.edu', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1683920488', 'Victor Rivera', 'victor.rivera' , 'bXKFno4xz9', 'victor.rivera@ui.ac.id', 'vrivera1h@acquirethisname.com', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1689284561', 'Jerry Perry', 'jerry.perry' , 'TaCk0fg', 'jerry.perry@ui.ac.id', 'jperryl@hubpages.com', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1693129733', 'Ruby Carpenter', 'ruby.carpenter' , '2sMesujpH92J', 'ruby.carpenter@ui.ac.id', 'rcarpenterb@dmoz.org', '', '', '', '', '');
INSERT INTO MAHASISWA (npm, nama, username, password, email, email_aktif, waktu_kosong, bank, norekening, url_mukatab, url_foto) VALUES ('1693647077', 'Michelle Sullivan', 'michelle.sullivan' , '38DRlOAn', 'michelle.sullivan@ui.ac.id', 'msullivanq@boston.com', '', '', '', '', '');

-- insert telepon mahasiswa --
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1310336628', '6281326886169');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1310336628', '6281824852450');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1325307320', '6281838032797');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1326719892', '6281336977404');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1326719892', '6281223571581');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1330626780', '6281294595009');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1334756654', '6281266997797');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1336118599', '6281531801522');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1338545712', '6281316327606');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1342894931', '6281851943349');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1343426119', '6281854047557');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1343426119', '6281859756852');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1345684665', '6281824165784');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1345684665', '6281861416164');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1346885475', '6281245272203');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1346885475', '6281509441803');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1348477830', '6281292095070');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1351514621', '6281838168424');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1351614361', '6281356414057');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1353569963', '6281292003994');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1356727131', '6281223358004');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1361968372', '6281220985412');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1369145357', '6281836111099');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1381997233', '6281253073074');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1397301059', '6281874013481');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1413060204', '6281272563110');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1423861028', '6281227762612');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1424482403', '6281517564429');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1424482403', '6281208428122');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1430434808', '6281851587924');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1434025676', '6281250272841');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1434634220', '6281279762815');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1434772514', '6281236265846');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1443792198', '6281228629492');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1443792198', '6281807599453');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1448148411', '6281853357959');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1448148411', '6281591021459');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1457809988', '6281252924195');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1461665387', '6281870192524');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1464327110', '6281289983064');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1464327110', '6281848819125');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1464560128', '6281843794116');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1466418063', '6281509190643');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1474480808', '6281205792043');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1475329393', '6281879856190');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1479329901', '6281534585345');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1481986965', '6281379273842');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1484460963', '6281823716012');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1484460963', '6281296741189');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1497433723', '6281333952219');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1498711404', '6281879406973');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1500611520', '6281250294389');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1502798367', '6281211248710');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1513550028', '6281318165816');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1513550028', '6281845491515');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1519355800', '6281324457406');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1519355800', '6281232925166');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1520554292', '6281261672319');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1522929237', '6281280621217');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1523179621', '6281708780323');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1531978569', '6281250302959');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1531978569', '6281278145291');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1534536188', '6281297190895');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1536204489', '6281380339875');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1537676327', '6281259239689');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1537763787', '6281228342240');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1541112149', '6281266925487');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1543730517', '6281356330553');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1544876141', '6281534090854');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1544876141', '6281253039603');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1553234403', '6281796471744');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1553285061', '6281368786726');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1556224007', '6281864327188');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1556224007', '6281279877485');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1565323056', '6281235103221');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1565530109', '6281265331007');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1578715010', '6281286832140');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1579420641', '6281254371873');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1585593783', '6281214530285');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1587990264', '6281742819425');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1590403253', '6281256362972');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1591081787', '6281255465835');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1593738108', '6281259191058');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1598258425', '6281277362365');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1600162787', '6281861453482');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1600427963', '6281262416840');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1601252466', '6281868885776');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1601868594', '6281898706373');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1601895996', '6281830602873');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1610590803', '6281880720504');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1611868053', '6281863774262');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1612436644', '6281801351722');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1612771331', '6281835004321');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1613278918', '6281889791141');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1613768173', '6281259417269');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1614589578', '6281214031726');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1615903472', '6281350927571');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1621307141', '6281818685101');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1621367088', '6281217331327');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1621548059', '6281834947295');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1624377963', '6281280880193');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1626145763', '6281210787291');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1627655930', '6281302756345');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1628654093', '6281299086714');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1629341488', '6281504129369');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1630375273', '6281249371687');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1631430261', '6281323921905');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1631895869', '6281247002609');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1632097254', '6281272868816');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1633571276', '6281224434484');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1634841413', '6281222456113');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1635545165', '6281219176630');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1638738514', '6281886240741');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1639013760', '6281885123315');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1639388506', '6281737159071');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1641767007', '6281876204929');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1642071123', '6281212728099');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1648029742', '6281282369711');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1648275051', '6281890158959');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1648720334', '6281217543633');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1649366322', '6281288469656');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1649366322', '6281227812013');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1649637658', '6281791629968');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1652117701', '6281858288527');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1654079943', '6281254785150');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1655119637', '6281753635449');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1655703307', '6281279916077');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1655703307', '6281202188902');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1656936755', '6281887126872');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1658940907', '6281816901187');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1661009381', '6281297194862');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1661203200', '6281817407165');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1661475085', '6281270224480');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1663016043', '6281241979691');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1668148959', '6281201789345');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1668148959', '6281337080662');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1671118828', '6281883758739');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1672657112', '6281289974007');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1673015048', '6281544751771');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1675501835', '6281820344906');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1676892272', '6281278666725');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1677836795', '6281260501312');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1683426067', '6281244675331');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1683426067', '6281263294280');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1683920488', '6281280801805');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1689284561', '6281835218450');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1693129733', '6281281632816');
INSERT INTO TELEPON_MAHASISWA (npm, nomortelepon) VALUES ('1693647077', '6281299829296');

-- insert dosen --
INSERT INTO DOSEN (nip, nama, username, password, email, universitas, fakultas) VALUES ('3035652810', 'James Hunt', 'james.hunt', 'TSaWNVxiWQ', 'james.hunt@ui.ac.id', 'Universitas Indonesia', 'FASILKOM');
INSERT INTO DOSEN (nip, nama, username, password, email, universitas, fakultas) VALUES ('3045894452', 'Phyllis Alvarez', 'phyllis.alvarez', 'fRbczuCl', 'phyllis.alvarez@ui.ac.id', 'Universitas Indonesia', 'FASILKOM');
INSERT INTO DOSEN (nip, nama, username, password, email, universitas, fakultas) VALUES ('3059038648', 'Randy Peters', 'randy.peters', '0EeGB2oo', 'randy.peters@ui.ac.id', 'Universitas Indonesia', 'FASILKOM');
INSERT INTO DOSEN (nip, nama, username, password, email, universitas, fakultas) VALUES ('3122804230', 'Kenneth Jordan', 'kenneth.jordan', 'jrCmRp', 'kenneth.jordan@ui.ac.id', 'Universitas Indonesia', 'FASILKOM');
INSERT INTO DOSEN (nip, nama, username, password, email, universitas, fakultas) VALUES ('3177272910', 'Walter Ford', 'walter.ford', 'YtnmV4UHktN', 'walter.ford@ui.ac.id', 'Universitas Indonesia', 'FASILKOM');
INSERT INTO DOSEN (nip, nama, username, password, email, universitas, fakultas) VALUES ('3215261901', 'William Garrett', 'william.garrett', '7LakGNu9ntxb', 'william.garrett@ui.ac.id', 'Universitas Indonesia', 'FASILKOM');
INSERT INTO DOSEN (nip, nama, username, password, email, universitas, fakultas) VALUES ('3340836167', 'Norma Ortiz', 'norma.ortiz', '1IUcbw8P', 'norma.ortiz@ui.ac.id', 'Universitas Indonesia', 'FASILKOM');
INSERT INTO DOSEN (nip, nama, username, password, email, universitas, fakultas) VALUES ('3365718295', 'Tina Larson', 'tina.larson', 'c8XHKZ', 'tina.larson@ui.ac.id', 'Universitas Indonesia', 'FASILKOM');
INSERT INTO DOSEN (nip, nama, username, password, email, universitas, fakultas) VALUES ('3418186782', 'Keith Franklin', 'keith.franklin', 'VJE8rfkwlsV', 'keith.franklin@ui.ac.id', 'Universitas Indonesia', 'FT');
INSERT INTO DOSEN (nip, nama, username, password, email, universitas, fakultas) VALUES ('3459618321', 'Kathryn Phillips', 'kathryn.phillips', '6qPDB6SSxS', 'kathryn.phillips@ui.ac.id', 'Universitas Indonesia', 'FASILKOM');
INSERT INTO DOSEN (nip, nama, username, password, email, universitas, fakultas) VALUES ('3472342523', 'Evelyn Snyder', 'evelyn.snyder', 'mnYapH4yGI6', 'evelyn.snyder@ui.ac.id', 'Universitas Indonesia', 'FASILKOM');
INSERT INTO DOSEN (nip, nama, username, password, email, universitas, fakultas) VALUES ('3496267033', 'Sandra Sullivan', 'sandra.sullivan', 'vF4opke', 'sandra.sullivan@ui.ac.id', 'Universitas Indonesia', 'FASILKOM');
INSERT INTO DOSEN (nip, nama, username, password, email, universitas, fakultas) VALUES ('3528031202', 'Jose Hamilton', 'jose.hamilton', 'DhBKSsRkiFMW', 'jose.hamilton@ui.ac.id', 'Universitas Indonesia', 'FASILKOM');
INSERT INTO DOSEN (nip, nama, username, password, email, universitas, fakultas) VALUES ('3549817534', 'Louis Jenkins', 'louis.jenkins', '0NUEkLs', 'louis.jenkins@ui.ac.id', 'Universitas Indonesia', 'FASILKOM');
INSERT INTO DOSEN (nip, nama, username, password, email, universitas, fakultas) VALUES ('3611263342', 'Evelyn Schmidt', 'evelyn.schmidt', 'VQPk7Lt', 'evelyn.schmidt@ui.ac.id', 'Universitas Indonesia', 'FASILKOM');
INSERT INTO DOSEN (nip, nama, username, password, email, universitas, fakultas) VALUES ('3672861132', 'Helen Woods', 'helen.woods', '3XZ0jS4Qa', 'helen.woods@ui.ac.id', 'Universitas Indonesia', 'FASILKOM');
INSERT INTO DOSEN (nip, nama, username, password, email, universitas, fakultas) VALUES ('3739982678', 'Philip Wheeler', 'philip.wheeler', '2hAVj8D5N', 'philip.wheeler@ui.ac.id', 'Universitas Indonesia', 'FASILKOM');
INSERT INTO DOSEN (nip, nama, username, password, email, universitas, fakultas) VALUES ('3937455565', 'Carolyn Duncan', 'carolyn.duncan', 'TFji5OkC1L5', 'carolyn.duncan@ui.ac.id', 'Universitas Indonesia', 'FASILKOM');
INSERT INTO DOSEN (nip, nama, username, password, email, universitas, fakultas) VALUES ('3942423007', 'Irene Arnold', 'irene.arnold', 'v5fJWn', 'irene.arnold@ui.ac.id', 'Universitas Indonesia', 'FKM');
INSERT INTO DOSEN (nip, nama, username, password, email, universitas, fakultas) VALUES ('3995859523', 'Cheryl Cooper', 'cheryl.cooper', 'YfbMmR', 'cheryl.cooper@ui.ac.id', 'Universitas Indonesia', 'FASILKOM');
INSERT INTO DOSEN (nip, nama, username, password, email, universitas, fakultas) VALUES ('4015060337', 'Steve Howell', 'steve.howell', '9up7dpPiXZq', 'steve.howell@ui.ac.id', 'Universitas Indonesia', 'FASILKOM');
INSERT INTO DOSEN (nip, nama, username, password, email, universitas, fakultas) VALUES ('4036344880', 'Patricia Black', 'patricia.black', 'CvqXy6G', 'patricia.black@ui.ac.id', 'Universitas Indonesia', 'FASILKOM');
INSERT INTO DOSEN (nip, nama, username, password, email, universitas, fakultas) VALUES ('4043896614', 'Clarence Marshall', 'clarence.marshall', 'UrlhkMp2Jj6', 'clarence.marshall@ui.ac.id', 'Universitas Indonesia', 'FASILKOM');
INSERT INTO DOSEN (nip, nama, username, password, email, universitas, fakultas) VALUES ('4047893854', 'Anthony Shaw', 'anthony.shaw', 'kKvu0ur', 'anthony.shaw@ui.ac.id', 'Universitas Indonesia', 'FASILKOM');
INSERT INTO DOSEN (nip, nama, username, password, email, universitas, fakultas) VALUES ('4064403590', 'Roy Wood', 'roy.wood', 'ZSxa7r', 'roy.wood@ui.ac.id', 'Universitas Indonesia', 'FASILKOM');
INSERT INTO DOSEN (nip, nama, username, password, email, universitas, fakultas) VALUES ('4124707564', 'Aaron Carroll', 'aaron.carroll', '18C3IcjTKcKG', 'aaron.carroll@ui.ac.id', 'Universitas Indonesia', 'FASILKOM');
INSERT INTO DOSEN (nip, nama, username, password, email, universitas, fakultas) VALUES ('4140954045', 'Raymond Welch', 'raymond.welch', '5KJOtrd', 'raymond.welch@ui.ac.id', 'Universitas Indonesia', 'FISIP');
INSERT INTO DOSEN (nip, nama, username, password, email, universitas, fakultas) VALUES ('4144885032', 'Walter Porter', 'walter.porter', 'epoEa7u3', 'walter.porter@ui.ac.id', 'Universitas Indonesia', 'FASILKOM');
INSERT INTO DOSEN (nip, nama, username, password, email, universitas, fakultas) VALUES ('4217097164', 'Heather Warren', 'heather.warren', '7jBK1QfEn', 'heather.warren@ui.ac.id', 'Universitas Indonesia', 'FASILKOM');
INSERT INTO DOSEN (nip, nama, username, password, email, universitas, fakultas) VALUES ('4237037878', 'Bobby Evans', 'bobby.evans', 'S0H2R8Wp4V', 'bobby.evans@ui.ac.id', 'Universitas Indonesia', 'FASILKOM');
INSERT INTO DOSEN (nip, nama, username, password, email, universitas, fakultas) VALUES ('4243650250', 'Lori Burke', 'lori.burke', 'GKKUIeip4MyP', 'lori.burke@ui.ac.id', 'Universitas Indonesia', 'FF');
INSERT INTO DOSEN (nip, nama, username, password, email, universitas, fakultas) VALUES ('4261865704', 'Justin Moore', 'justin.moore', 'KM4ROE63thI', 'justin.moore@ui.ac.id', 'Universitas Indonesia', 'FASILKOM');
INSERT INTO DOSEN (nip, nama, username, password, email, universitas, fakultas) VALUES ('4289432766', 'Patricia Parker', 'patricia.parker', 'dr8HDN6wJXY1', 'patricia.parker@ui.ac.id', 'Universitas Indonesia', 'FASILKOM');
INSERT INTO DOSEN (nip, nama, username, password, email, universitas, fakultas) VALUES ('4325533101', 'Willie Morales', 'willie.morales', 'vZbw3tQjNaEB', 'willie.morales@ui.ac.id', 'Universitas Indonesia', 'FASILKOM');
INSERT INTO DOSEN (nip, nama, username, password, email, universitas, fakultas) VALUES ('4350184481', 'Jack Vasquez', 'jack.vasquez', 'rmH0okgXBxo', 'jack.vasquez@ui.ac.id', 'Universitas Indonesia', 'FIA');
INSERT INTO DOSEN (nip, nama, username, password, email, universitas, fakultas) VALUES ('4368065352', 'Nancy Patterson', 'nancy.patterson', 'tYWN0bqq', 'nancy.patterson@ui.ac.id', 'Universitas Indonesia', 'FASILKOM');
INSERT INTO DOSEN (nip, nama, username, password, email, universitas, fakultas) VALUES ('4385499191', 'Steve Hicks', 'steve.hicks', 'lhUhgxasShc', 'steve.hicks@ui.ac.id', 'Universitas Indonesia', 'FASILKOM');
INSERT INTO DOSEN (nip, nama, username, password, email, universitas, fakultas) VALUES ('4421663062', 'Sandra Price', 'sandra.price', 'ZF0EoQDfgZM', 'sandra.price@ui.ac.id', 'Universitas Indonesia', 'FASILKOM');
INSERT INTO DOSEN (nip, nama, username, password, email, universitas, fakultas) VALUES ('4434759529', 'Lillian Duncan', 'lillian.duncan', '4q1w3cZ4s3F', 'lillian.duncan@ui.ac.id', 'Universitas Indonesia', 'FASILKOM');
INSERT INTO DOSEN (nip, nama, username, password, email, universitas, fakultas) VALUES ('4449617303', 'Teresa Owens', 'teresa.owens', '95QrPFm1KSt', 'teresa.owens@ui.ac.id', 'Universitas Indonesia', 'FASILKOM');
INSERT INTO DOSEN (nip, nama, username, password, email, universitas, fakultas) VALUES ('4455259762', 'Rachel Boyd', 'rachel.boyd', 'g0cHZA', 'rachel.boyd@ui.ac.id', 'Universitas Indonesia', 'FASILKOM');
INSERT INTO DOSEN (nip, nama, username, password, email, universitas, fakultas) VALUES ('4477276074', 'Brandon Pierce', 'brandon.pierce', '2sNAvG8xjsF', 'brandon.pierce@ui.ac.id', 'Universitas Indonesia', 'FASILKOM');
INSERT INTO DOSEN (nip, nama, username, password, email, universitas, fakultas) VALUES ('4552891179', 'Jose Romero', 'jose.romero', '3ZHKF6U6CfFh', 'jose.romero@ui.ac.id', 'Universitas Indonesia', 'FEB');
INSERT INTO DOSEN (nip, nama, username, password, email, universitas, fakultas) VALUES ('4595228326', 'Willie Martin', 'willie.martin', 'U5bEf3', 'willie.martin@ui.ac.id', 'Universitas Indonesia', 'FASILKOM');
INSERT INTO DOSEN (nip, nama, username, password, email, universitas, fakultas) VALUES ('4655854812', 'Sean Rice', 'sean.rice', 'pjUyxwHa3fM', 'sean.rice@ui.ac.id', 'Universitas Indonesia', 'FK');
INSERT INTO DOSEN (nip, nama, username, password, email, universitas, fakultas) VALUES ('4706880174', 'Brenda Anderson', 'brenda.anderson', '2okDaMlNOx', 'brenda.anderson@ui.ac.id', 'Universitas Indonesia', 'FASILKOM');
INSERT INTO DOSEN (nip, nama, username, password, email, universitas, fakultas) VALUES ('4744624053', 'Janice George', 'janice.george', '0csZQMs', 'janice.george@ui.ac.id', 'Universitas Indonesia', 'FASILKOM');
INSERT INTO DOSEN (nip, nama, username, password, email, universitas, fakultas) VALUES ('4746900794', 'Joan Elliott', 'joan.elliott', 'VwWCMfr3o9v', 'joan.elliott@ui.ac.id', 'Universitas Indonesia', 'FASILKOM');
INSERT INTO DOSEN (nip, nama, username, password, email, universitas, fakultas) VALUES ('4769663945', 'Jeremy Weaver', 'jeremy.weaver', 'yghxXIS', 'jeremy.weaver@ui.ac.id', 'Universitas Indonesia', 'FASILKOM');
INSERT INTO DOSEN (nip, nama, username, password, email, universitas, fakultas) VALUES ('4777381851', 'Lois Morris', 'lois.morris', 'mdfUEN', 'lois.morris@ui.ac.id', 'Universitas Indonesia', 'FASILKOM');
INSERT INTO DOSEN (nip, nama, username, password, email, universitas, fakultas) VALUES ('4809912594', 'Ashley Lewis', 'ashley.lewis', 'g55w6bucT0', 'ashley.lewis@ui.ac.id', 'Universitas Indonesia', 'FASILKOM');
INSERT INTO DOSEN (nip, nama, username, password, email, universitas, fakultas) VALUES ('4860234283', 'Shirley Ray', 'shirley.ray', 'EGRy1JRsE', 'shirley.ray@ui.ac.id', 'Universitas Indonesia', 'FASILKOM');
INSERT INTO DOSEN (nip, nama, username, password, email, universitas, fakultas) VALUES ('4885469505', 'Karen Duncan', 'karen.duncan', 'yFv17zvSx1Q', 'karen.duncan@ui.ac.id', 'Universitas Indonesia', 'FIB');
INSERT INTO DOSEN (nip, nama, username, password, email, universitas, fakultas) VALUES ('4916441698', 'Gerald Porter', 'gerald.porter', 'ajgNJhIK5', 'gerald.porter@ui.ac.id', 'Universitas Indonesia', 'FMIPA');
INSERT INTO DOSEN (nip, nama, username, password, email, universitas, fakultas) VALUES ('4983146928', 'Jerry Spencer', 'jerry.spencer', 'bSvKwAH0C', 'jerry.spencer@ui.ac.id', 'Universitas Indonesia', 'FASILKOM');

-- insert mata kuliah --
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('CSCE604121', 'Game Development', NULL);
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('CSCM603127', 'Rekayasa Perangkat Lunak', 'CSCE604121');
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('CSCE604131', 'Jejaring Semantik', NULL);
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('CSGE602022', 'Perancangan & Pemrograman Web', 'CSCE604131');
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('CSCE604132', 'Komputasi Lunak', NULL);
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('CSCM603130', 'Sistem Cerdas', 'CSCE604132');
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('CSCE604134', 'Pengolahan Multimedia', NULL);
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('CSCE604133', 'Pengolahan Citra', 'CSCE604134');
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('CSCE604150', 'Organisasi Sistem Komputer', NULL);
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('CSCM601252', 'Pengantar Organisasi Komputer', 'CSCE604150');
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('CSCM601150', 'Pengantar Sistem Dijital', 'CSCM601252');
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('CSCE604174', 'Basis Data Lanjut', NULL);
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('CSGE602070', 'Basis Data', 'CSCE604174');
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('CSGE602040', 'Struktur Data & Algoritma', 'CSGE602070');
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('CSGE601021', 'Dasar-Dasar Pemrograman 2', 'CSGE602040');
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('CSGE601020', 'Dasar-Dasar Pemrograman 1', 'CSGE601021');
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('CSCE604212', 'Persamaan Diferensial', NULL);
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('CSCM602115', 'Matematika Dasar 2', 'CSCE604212');
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('UIST601014', 'Matematika Dasar 1', 'CSCM602115');
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('CSGE601011', 'Matematika Diskret 2', NULL);
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('CSGE601010', 'Matematika Diskret 1', 'CSGE601011');
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('CSCE604231', 'Pengolahan Bahasa Manusia', NULL);
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('CSCE604135', 'Perolehan Informasi', 'CSCE604231');
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('CSCE604232', 'Robotika', NULL);
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('CSCE604253', 'Rancangan Sistem Dijital', 'CSCE604232');
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('CSCM603154', 'Jaringan Komputer', NULL);
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('CSGE602055', 'Sistem Operasi', 'CSCM603154');
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('CSIE604274', 'Administrasi Sistem', NULL);
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('CSIM602160', 'Administrasi Bisnis', 'CSIE604274');
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('CSIM603189', 'Manajemen Proyek TI', NULL);
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('CSIM602161', 'Prinsip-prinsip Manajemen', 'CSIM603189');
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('CSIM604182', 'Manajemen SI', NULL);
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('CSIM601280', 'Prinsip-prinsip SI', 'CSIM604182');
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('CSGE603291', 'Metodologi Penelitian & Penulisan Ilmiah', NULL);
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('CSIM603026', 'Pemrograman Skala Perusahaan', NULL);
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('CSGE602012', 'Aljabar Linier', NULL);
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('CSCE604130', 'Bioinformatika', NULL);
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('CSCE604233', 'Data Mining', NULL);
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('CSCE604241', 'Grafika Komputer', NULL);
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('CSGE604098', 'Kerja Praktik', NULL);
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('CSGE614093', 'Komputer & Masyarakat', NULL);
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('CSIE604266', 'Konfigurasi ERP', NULL);
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('CSCE604243', 'Kriptografi & Keamanan Informasi', NULL);
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('CSCE604271', 'Layanan & Aplikasi Web', NULL);
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('CSCE604225', 'Metode Formal', NULL);
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('CSCE604235', 'Pemelajaran Mesin', NULL);
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('CSCE604143', 'Pemodelan Geometris', NULL);
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('CSCM602023', 'Pemrograman Lanjut', NULL);
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('CSCE604222', 'Pemrograman Logika', NULL);
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('CSCM603128', 'Pemrograman Sistem', NULL);
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('CSCE604152', 'Pengolahan Sinyal Dijital', NULL);
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('CSCM603228', 'Proyek Perangkat Lunak', NULL);
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('CSCE604111', 'Simulasi & Pemodelan', NULL);
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('CSIM603124', 'Sistem Interaksi', NULL);
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('CSCE604154', 'Sistem Terdistribusi', NULL);
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('CSGE602013', 'Statistika dan Probabilitas', NULL);
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('CSCE604228', 'Teknik Kompilator', NULL);
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('CSCE604179', 'Teknologi Mobile', NULL);
INSERT INTO MATA_KULIAH (kode, nama, prasyarat_dari) VALUES ('CSCM602241', 'Teori Bahasa & Automata', NULL);

-- insert term --
INSERT INTO TERM (tahun, semester) VALUES (2015, 1);
INSERT INTO TERM (tahun, semester) VALUES (2015, 2);
INSERT INTO TERM (tahun, semester) VALUES (2015, 3);
INSERT INTO TERM (tahun, semester) VALUES (2016, 1);
INSERT INTO TERM (tahun, semester) VALUES (2016, 2);
INSERT INTO TERM (tahun, semester) VALUES (2016, 3);

-- insert kelas mk --
INSERT INTO KELAS_MK (tahun, semester, kode_mk) VALUES (2015, 1, 'CSGE601020');
INSERT INTO KELAS_MK (tahun, semester, kode_mk) VALUES (2015, 1, 'UIST601014');
INSERT INTO KELAS_MK (tahun, semester, kode_mk) VALUES (2015, 1, 'CSGE601010');
INSERT INTO KELAS_MK (tahun, semester, kode_mk) VALUES (2015, 1, 'CSCM601150');
INSERT INTO KELAS_MK (tahun, semester, kode_mk) VALUES (2015, 1, 'CSCM603228');
INSERT INTO KELAS_MK (tahun, semester, kode_mk) VALUES (2015, 1, 'CSGE602013');
INSERT INTO KELAS_MK (tahun, semester, kode_mk) VALUES (2015, 1, 'CSIE604274');
INSERT INTO KELAS_MK (tahun, semester, kode_mk) VALUES (2015, 1, 'CSCE604130');
INSERT INTO KELAS_MK (tahun, semester, kode_mk) VALUES (2015, 1, 'CSCE604233');
INSERT INTO KELAS_MK (tahun, semester, kode_mk) VALUES (2015, 1, 'CSCE604232');
INSERT INTO KELAS_MK (tahun, semester, kode_mk) VALUES (2015, 2, 'CSIM602160');
INSERT INTO KELAS_MK (tahun, semester, kode_mk) VALUES (2015, 2, 'CSGE602012');
INSERT INTO KELAS_MK (tahun, semester, kode_mk) VALUES (2015, 2, 'CSGE601021');
INSERT INTO KELAS_MK (tahun, semester, kode_mk) VALUES (2015, 2, 'CSCM602115');
INSERT INTO KELAS_MK (tahun, semester, kode_mk) VALUES (2015, 2, 'CSGE601011');
INSERT INTO KELAS_MK (tahun, semester, kode_mk) VALUES (2015, 2, 'CSIM601280');
INSERT INTO KELAS_MK (tahun, semester, kode_mk) VALUES (2015, 2, 'CSCM603127');
INSERT INTO KELAS_MK (tahun, semester, kode_mk) VALUES (2015, 2, 'CSCE604241');
INSERT INTO KELAS_MK (tahun, semester, kode_mk) VALUES (2015, 2, 'CSCE604131');
INSERT INTO KELAS_MK (tahun, semester, kode_mk) VALUES (2015, 2, 'CSCE604132');
INSERT INTO KELAS_MK (tahun, semester, kode_mk) VALUES (2015, 3, 'UIST601014');
INSERT INTO KELAS_MK (tahun, semester, kode_mk) VALUES (2015, 3, 'CSGE601010');
INSERT INTO KELAS_MK (tahun, semester, kode_mk) VALUES (2015, 3, 'CSCM601150');
INSERT INTO KELAS_MK (tahun, semester, kode_mk) VALUES (2015, 3, 'CSGE602012');
INSERT INTO KELAS_MK (tahun, semester, kode_mk) VALUES (2015, 3, 'CSGE602013');
INSERT INTO KELAS_MK (tahun, semester, kode_mk) VALUES (2016, 1, 'CSCM603154');
INSERT INTO KELAS_MK (tahun, semester, kode_mk) VALUES (2016, 1, 'CSIM603189');
INSERT INTO KELAS_MK (tahun, semester, kode_mk) VALUES (2016, 1, 'CSCM601150');
INSERT INTO KELAS_MK (tahun, semester, kode_mk) VALUES (2016, 1, 'CSGE602013');
INSERT INTO KELAS_MK (tahun, semester, kode_mk) VALUES (2016, 1, 'CSGE602040');
INSERT INTO KELAS_MK (tahun, semester, kode_mk) VALUES (2016, 1, 'CSCE604179');
INSERT INTO KELAS_MK (tahun, semester, kode_mk) VALUES (2016, 1, 'CSIE604266');
INSERT INTO KELAS_MK (tahun, semester, kode_mk) VALUES (2016, 1, 'CSCE604271');
INSERT INTO KELAS_MK (tahun, semester, kode_mk) VALUES (2016, 1, 'CSIM604182');
INSERT INTO KELAS_MK (tahun, semester, kode_mk) VALUES (2016, 2, 'CSGE602070');
INSERT INTO KELAS_MK (tahun, semester, kode_mk) VALUES (2016, 2, 'CSIM603189');
INSERT INTO KELAS_MK (tahun, semester, kode_mk) VALUES (2016, 2, 'CSGE603291');
INSERT INTO KELAS_MK (tahun, semester, kode_mk) VALUES (2016, 2, 'CSIM603026');
INSERT INTO KELAS_MK (tahun, semester, kode_mk) VALUES (2016, 2, 'CSIM601280');
INSERT INTO KELAS_MK (tahun, semester, kode_mk) VALUES (2016, 2, 'CSCE604150');
INSERT INTO KELAS_MK (tahun, semester, kode_mk) VALUES (2016, 2, 'CSCM602023');
INSERT INTO KELAS_MK (tahun, semester, kode_mk) VALUES (2016, 2, 'CSCM603127');
INSERT INTO KELAS_MK (tahun, semester, kode_mk) VALUES (2016, 2, 'CSCE604152');
INSERT INTO KELAS_MK (tahun, semester, kode_mk) VALUES (2016, 2, 'CSCM603130');
INSERT INTO KELAS_MK (tahun, semester, kode_mk) VALUES (2016, 2, 'CSCM602241');
INSERT INTO KELAS_MK (tahun, semester, kode_mk) VALUES (2016, 3, 'UIST601014');
INSERT INTO KELAS_MK (tahun, semester, kode_mk) VALUES (2016, 3, 'CSGE601011');
INSERT INTO KELAS_MK (tahun, semester, kode_mk) VALUES (2016, 3, 'CSCM601150');
INSERT INTO KELAS_MK (tahun, semester, kode_mk) VALUES (2016, 3, 'CSGE602012');
INSERT INTO KELAS_MK (tahun, semester, kode_mk) VALUES (2016, 3, 'CSGE602013');

-- insert dosen kelas mk -- 
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('3528031202', 1);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('4047893854', 1);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('3611263342', 2);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('4144885032', 2);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('4421663062', 3);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('4777381851', 3);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('3035652810', 4);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('4477276074', 4);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('4217097164', 5);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('4744624053', 5);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('4043896614', 6);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('4385499191', 6);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('3528031202', 7);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('3995859523', 7);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('4124707564', 8);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('3459618321', 8);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('3739982678', 9);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('4015060337', 9);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('4144885032', 10);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('4036344880', 10);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('4289432766', 11);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('4325533101', 11);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('4237037878', 12);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('3365718295', 12);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('3122804230', 13);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('4047893854', 13);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('3122804230', 14);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('3549817534', 14);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('3472342523', 15);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('4809912594', 15);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('3365718295', 16);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('3472342523', 16);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('3739982678', 17);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('3215261901', 17);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('4434759529', 18);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('4036344880', 18);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('3496267033', 19);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('4449617303', 19);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('4217097164', 20);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('3672861132', 21);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('3995859523', 21);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('4124707564', 22);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('4043896614', 22);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('4595228326', 23);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('4385499191', 23);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('4746900794', 24);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('4769663945', 24);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('3045894452', 25);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('4368065352', 25);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('3035652810', 26);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('3340836167', 26);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('3496267033', 27);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('3215261901', 27);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('3937455565', 28);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('4064403590', 28);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('4421663062', 29);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('4289432766', 29);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('4064403590', 30);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('3549817534', 30);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('4368065352', 31);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('4261865704', 31);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('4706880174', 32);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('3340836167', 33);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('4434759529', 34);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('4325533101', 35);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('3672861132', 35);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('4015060337', 36);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('3059038648', 36);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('3177272910', 37);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('4860234283', 37);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('3937455565', 38);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('4144885032', 38);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('4983146928', 39);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('3059038648', 39);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('4237037878', 40);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('4368065352', 41);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('4455259762', 42);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('3459618321', 43);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('4261865704', 44);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('4860234283', 45);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('4595228326', 46);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('4777381851', 47);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('3215261901', 48);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('4144885032', 49);
INSERT INTO DOSEN_KELAS_MK (nip, idkelasmk) VALUES ('4015060337', 50);

-- insert mahasiswa mengambil kelas mk --
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1600162787', 1, 24.6);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1601252466', 1, 30.14);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1611868053', 1, 47.89);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1612436644', 1, 70.32);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1613278918', 1, 69.31);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1614589578', 1, 93.05);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1615903472', 1, 45.6);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1522929237', 2, 34.02);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1523179621', 2, 42.71);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1531978569', 2, 81.8);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1534536188', 2, 91.56);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1536204489', 2, 42.09);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1537676327', 2, 99.29);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1537763787', 2, 44.57);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1461665387', 3, 76.31);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1464327110', 3, 42.06);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1464560128', 3, 60.56);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1466418063', 3, 59.99);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1474480808', 3, 40.38);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1475329393', 3, 38.52);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1479329901', 3, 39.37);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1461665387', 4, 29.87);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1464327110', 4, 88.05);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1464560128', 4, 99.05);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1466418063', 4, 94.08);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1474480808', 4, 77.15);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1475329393', 4, 63.92);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1479329901', 4, 44.85);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1310336628', 5, 72.46);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1325307320', 5, 70.51);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1326719892', 5, 23.63);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1330626780', 5, 55.41);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1334756654', 5, 92.23);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1336118599', 5, 76.8);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1338545712', 5, 49.27);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1461665387', 6, 78.78);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1464327110', 6, 36.78);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1464560128', 6, 85.47);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1466418063', 6, 27.31);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1474480808', 6, 48.81);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1475329393', 6, 74.25);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1479329901', 6, 29.13);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1310336628', 7, 38.12);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1325307320', 7, 65.05);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1326719892', 7, 91.54);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1330626780', 7, 98.32);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1334756654', 7, 80.68);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1336118599', 7, 75.44);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1338545712', 7, 40.32);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1600162787', 11, 95.98);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1601252466', 11, 74.72);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1611868053', 11, 24.96);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1612436644', 11, 59.73);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1613278918', 11, 82.62);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1614589578', 11, 49.37);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1615903472', 11, 39.22);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1522929237', 12, 54.83);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1523179621', 12, 79.99);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1531978569', 12, 91.41);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1534536188', 12, 74.2);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1536204489', 12, 81.22);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1537676327', 12, 33.76);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1537763787', 12, 91.67);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1600162787', 13, 43.39);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1601252466', 13, 20.44);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1611868053', 13, 79.47);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1612436644', 13, 21.32);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1613278918', 13, 74.45);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1614589578', 13, 43.22);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1615903472', 13, 87.89);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1522929237', 14, 41.27);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1523179621', 14, 79.06);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1531978569', 14, 21.67);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1534536188', 14, 83.31);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1536204489', 14, 71.04);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1537676327', 14, 36.57);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1537763787', 14, 42.16);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1461665387', 15, 63.37);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1464327110', 15, 97.04);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1464560128', 15, 94.78);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1466418063', 15, 45.67);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1474480808', 15, 79.81);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1475329393', 15, 36.69);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1479329901', 15, 92.51);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1522929237', 16, 49.05);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1523179621', 16, 40.68);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1531978569', 16, 57.96);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1534536188', 16, 33.01);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1536204489', 16, 79.49);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1537676327', 16, 61.52);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1537763787', 16, 55.2);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1310336628', 17, 71.14);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1325307320', 17, 30.01);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1326719892', 17, 70.16);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1330626780', 17, 70.02);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1334756654', 17, 82.1);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1336118599', 17, 55.2);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1338545712', 17, 70.22);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1600162787', 21, 65.52);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1601252466', 21, 43.5);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1611868053', 21, 22.03);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1612436644', 21, 36.78);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1613278918', 21, 28.42);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1614589578', 21, 93.71);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1615903472', 21, 47.76);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1522929237', 22, 63.09);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1523179621', 22, 92.25);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1531978569', 22, 32.37);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1534536188', 22, 68.81);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1536204489', 22, 36.7);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1537676327', 22, 86.28);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1537763787', 22, 39.57);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1522929237', 23, 65.95);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1523179621', 23, 30.44);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1531978569', 23, 41.17);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1534536188', 23, 67.38);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1536204489', 23, 44.02);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1537676327', 23, 24.51);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1537763787', 23, 20.23);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1600162787', 24, 23.11);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1601252466', 24, 21.52);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1611868053', 24, 68.42);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1612436644', 24, 28.13);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1613278918', 24, 88.16);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1614589578', 24, 85.73);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1615903472', 24, 68.2);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1310336628', 25, 58.05);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1325307320', 25, 90.36);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1326719892', 25, 93.51);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1330626780', 25, 79.5);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1334756654', 25, 52.88);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1336118599', 25, 50.38);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1338545712', 25, 55.13);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1310336628', 26, 50.33);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1325307320', 26, 21.79);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1326719892', 26, 85.3);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1330626780', 26, 75.58);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1334756654', 26, 89.31);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1336118599', 26, 42.37);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1338545712', 26, 37.05);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1461665387', 27, 66.92);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1464327110', 27, 79.1);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1464560128', 27, 59.27);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1466418063', 27, 92.37);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1474480808', 27, 68);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1475329393', 27, 73.1);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1479329901', 27, 63.7);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1522929237', 28, 73.44);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1523179621', 28, 34.93);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1531978569', 28, 95.2);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1534536188', 28, 24.33);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1536204489', 28, 72.44);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1537676327', 28, 90.82);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1537763787', 28, 62.59);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1461665387', 29, 83.56);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1464327110', 29, 58.98);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1464560128', 29, 91.97);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1466418063', 29, 42.53);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1474480808', 29, 89.72);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1475329393', 29, 73.66);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1479329901', 29, 47.86);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1600162787', 30, 23.96);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1601252466', 30, 78.87);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1611868053', 30, 78.82);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1612436644', 30, 22.61);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1613278918', 30, 50.69);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1614589578', 30, 54.15);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1615903472', 30, 55.26);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1310336628', 31, 61.07);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1325307320', 31, 87.92);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1326719892', 31, 53.88);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1330626780', 31, 62.91);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1334756654', 31, 92.38);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1336118599', 31, 97.54);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1338545712', 31, 49.08);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1600162787', 35, NULL);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1601252466', 35, NULL);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1611868053', 35, NULL);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1612436644', 35, NULL);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1613278918', 35, NULL);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1614589578', 35, NULL);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1615903472', 35, NULL);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1522929237', 36, NULL);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1523179621', 36, NULL);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1531978569', 36, NULL);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1534536188', 36, NULL);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1536204489', 36, NULL);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1537676327', 36, NULL);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1537763787', 36, NULL);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1310336628', 37, NULL);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1325307320', 37, NULL);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1326719892', 37, NULL);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1330626780', 37, NULL);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1334756654', 37, NULL);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1336118599', 37, NULL);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1338545712', 37, NULL);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1461665387', 38, NULL);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1464327110', 38, NULL);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1464560128', 38, NULL);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1466418063', 38, NULL);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1474480808', 38, NULL);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1475329393', 38, NULL);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1479329901', 38, NULL);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1600162787', 39, NULL);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1601252466', 39, NULL);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1611868053', 39, NULL);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1612436644', 39, NULL);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1613278918', 39, NULL);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1614589578', 39, NULL);
INSERT INTO MHS_MENGAMBIL_KELAS_MK (npm, idkelasmk, nilai) VALUES ('1615903472', 39, NULL);

-- insert status lamaran --
INSERT INTO STATUS_LAMARAN (id, status) VALUES ('1', 'melamar');
INSERT INTO STATUS_LAMARAN (id, status) VALUES ('2', 'direkomendasikan');
INSERT INTO STATUS_LAMARAN (id, status) VALUES ('3', 'diterima');
INSERT INTO STATUS_LAMARAN (id, status) VALUES ('4', 'ditolak');

-- insert lowongan --
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (1, FALSE, 3, 'Diutamakan yang pernah saya ajar', '3528031202');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (1, FALSE, 3, '', '4047893854');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (2, FALSE, 9, '', '3611263342');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (2, FALSE, 2, '', '4144885032');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (3, FALSE, 1, '', '4421663062');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (3, FALSE, 9, 'Diutamakan tidak mendaftar asdos MK lain', '4777381851');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (4, FALSE, 6, '', '3035652810');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (4, FALSE, 9, 'Nilai B silahkan ikut daftar', '4477276074');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (5, FALSE, 8, '', '4217097164');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (5, FALSE, 6, 'Diutamakan yang pernah saya ajar', '4744624053');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (6, FALSE, 6, '', '4043896614');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (6, FALSE, 5, '', '4385499191');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (7, FALSE, 3, '', '3528031202');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (7, FALSE, 10, '', '3995859523');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (11, FALSE, 10, '', '4289432766');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (11, FALSE, 8, 'Nilai B silahkan ikut daftar', '4325533101');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (12, FALSE, 7, '', '4237037878');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (12, FALSE, 3, 'Nilai B silahkan ikut daftar', '3365718295');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (13, FALSE, 6, '', '3122804230');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (13, FALSE, 1, '', '4047893854');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (14, FALSE, 1, '', '3122804230');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (14, FALSE, 9, 'Nilai B silahkan ikut daftar', '3549817534');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (15, FALSE, 3, '', '3472342523');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (15, FALSE, 10, '', '4809912594');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (16, FALSE, 4, '', '3365718295');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (16, FALSE, 9, 'Diutamakan tidak mendaftar asdos MK lain', '3472342523');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (17, FALSE, 1, '', '3739982678');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (17, FALSE, 7, '', '3215261901');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (21, FALSE, 9, 'Diutamakan tidak mendaftar asdos MK lain', '3672861132');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (21, FALSE, 8, '', '3995859523');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (22, FALSE, 3, 'Nilai B silahkan ikut daftar', '4124707564');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (22, FALSE, 2, '', '4043896614');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (23, FALSE, 2, 'Minimal IPK 3.00', '4595228326');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (23, FALSE, 5, '', '4385499191');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (24, FALSE, 3, '', '4746900794');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (24, FALSE, 2, '', '4769663945');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (25, FALSE, 7, '', '3045894452');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (25, FALSE, 4, 'Minimal IPK 3.00', '4368065352');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (26, FALSE, 3, 'Nilai B silahkan ikut daftar', '3035652810');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (26, FALSE, 8, '', '3340836167');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (27, FALSE, 8, 'Diutamakan tidak mendaftar asdos MK lain', '3496267033');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (27, FALSE, 1, '', '3215261901');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (28, FALSE, 4, 'Diutamakan yang pernah saya ajar', '3937455565');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (28, FALSE, 1, '', '4064403590');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (29, FALSE, 5, '', '4421663062');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (29, FALSE, 7, '', '4289432766');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (30, FALSE, 6, '', '4064403590');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (30, FALSE, 5, 'Nilai B silahkan ikut daftar', '3549817534');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (31, FALSE, 3, 'Diutamakan tidak mendaftar asdos MK lain', '4368065352');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (31, FALSE, 10, '', '4261865704');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (35, FALSE, 7, 'Diutamakan tidak mendaftar asdos MK lain', '4325533101');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (35, TRUE, 3, '', '3672861132');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (36, FALSE, 10, '', '4015060337');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (36, TRUE, 6, 'Minimal IPK 3.00', '3059038648');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (37, FALSE, 7, 'Diutamakan tidak mendaftar asdos MK lain', '3177272910');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (37, TRUE, 8, '', '4860234283');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (38, FALSE, 10, '', '3937455565');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (38, TRUE, 1, 'Diutamakan yang pernah saya ajar', '4144885032');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (39, TRUE, 3, '', '4983146928');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (39, TRUE, 3, 'Nilai B silahkan ikut daftar', '3059038648');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (46, FALSE, 7, 'Diutamakan tidak mendaftar asdos MK lain', '4595228326');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (47, FALSE, 6, '', '4777381851');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (48, FALSE, 6, 'Nilai B silahkan ikut daftar', '3215261901');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (49, FALSE, 9, 'Minimal IPK 3.00', '4144885032');
INSERT INTO LOWONGAN (idkelasmk, status, jumlah_asisten, syarat_tambahan, nipdosenpembuka) VALUES (50, FALSE, 6, 'Diutamakan tidak mendaftar asdos MK lain', '4015060337');

-- insert lamaran --
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1522929237', 1, 3, 3.87, 49, '3528031202');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1523179621', 1, 4, 3.59, 41, '3528031202');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1461665387', 1, 3, 3.47, 36, '3528031202');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1464327110', 1, 4, 3.78, 53, '3528031202');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1531978569', 2, 4, 3.54, 90, '4047893854');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1534536188', 2, 3, 3.92, 68, '4047893854');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1474480808', 2, 4, 3.41, 29, '4047893854');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1475329393', 2, 4, 3.26, 31, '4047893854');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1464560128', 3, 3, 2.57, 129, '3611263342');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1466418063', 3, 4, 3.48, 137, '3611263342');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1336118599', 3, 3, 3.57, 104, '3611263342');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1338545712', 3, 4, 3.52, 90, '3611263342');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1326719892', 3, 3, 3.33, 53, '3611263342');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1330626780', 3, 3, 3.56, 114, '3611263342');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1474480808', 3, 4, 3.09, 58, '3611263342');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1475329393', 3, 3, 2.71, 94, '3611263342');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1466418063', 4, 3, 2.76, 79, '4144885032');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1310336628', 5, 3, 2.65, 93, '4421663062');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1325307320', 5, 4, 3.74, 77, '4421663062');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1326719892', 6, 4, 3.16, 121, '4777381851');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1330626780', 6, 3, 3.87, 88, '4777381851');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1334756654', 6, 3, 3.69, 80, '4777381851');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1336118599', 6, 4, 3.16, 105, '4777381851');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1338545712', 6, 4, 3.96, 25, '4777381851');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1310336628', 7, 3, 3.54, 39, '3035652810');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1325307320', 7, 3, 3.03, 102, '3035652810');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1326719892', 8, 4, 3.86, 95, '4477276074');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1330626780', 8, 3, 3.31, 24, '4477276074');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1334756654', 8, 3, 3.08, 100, '4477276074');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1336118599', 8, 3, 3.64, 98, '4477276074');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1325307320', 11, 4, 2.94, 139, '4043896614');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1326719892', 11, 3, 3.47, 63, '4043896614');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1330626780', 12, 3, 3.39, 125, '4385499191');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1334756654', 12, 4, 2.98, 89, '4385499191');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1336118599', 15, 4, 3.26, 60, '4289432766');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1461665387', 15, 4, 3.06, 135, '4289432766');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1464327110', 15, 4, 2.52, 59, '4289432766');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1464560128', 15, 3, 3.88, 70, '4289432766');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1531978569', 15, 4, 3.51, 24, '4289432766');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1534536188', 15, 3, 2.99, 40, '4289432766');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1536204489', 15, 3, 3.34, 138, '4289432766');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1537676327', 15, 4, 2.83, 70, '4289432766');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1537763787', 16, 4, 2.55, 128, '4325533101');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1464560128', 17, 4, 2.67, 97, '4237037878');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1330626780', 18, 3, 3.28, 88, '3365718295');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1334756654', 18, 3, 3.92, 76, '3365718295');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1336118599', 18, 4, 3.11, 125, '3365718295');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1338545712', 19, 4, 3.14, 133, '3122804230');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1464327110', 19, 4, 3.02, 57, '3122804230');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1464560128', 19, 4, 2.88, 79, '3122804230');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1466418063', 20, 3, 3, 33, '4047893854');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1474480808', 20, 4, 3, 87, '4047893854');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1536204489', 20, 3, 3.49, 103, '4047893854');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1537676327', 20, 3, 3.56, 72, '4047893854');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1334756654', 21, 4, 3.2, 72, '3122804230');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1336118599', 21, 4, 3.63, 56, '3122804230');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1338545712', 21, 3, 3.71, 78, '3122804230');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1310336628', 23, 3, 3.39, 61, '3472342523');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1325307320', 23, 3, 2.66, 97, '3472342523');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1326719892', 23, 3, 3.42, 107, '3472342523');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1330626780', 23, 4, 3.22, 38, '3472342523');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1464560128', 29, 4, 2.68, 80, '3672861132');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1466418063', 29, 3, 2.84, 121, '3672861132');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1474480808', 29, 4, 2.72, 125, '3672861132');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1523179621', 30, 4, 3.98, 61, '3995859523');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1531978569', 30, 3, 3.37, 119, '3995859523');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1336118599', 31, 3, 3.2, 24, '4124707564');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1338545712', 31, 4, 2.55, 42, '4124707564');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1464560128', 32, 4, 3.83, 124, '4043896614');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1466418063', 32, 3, 3, 45, '4043896614');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1310336628', 33, 4, 3.34, 80, '4595228326');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1325307320', 34, 3, 3.32, 32, '4385499191');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1326719892', 34, 3, 3.15, 102, '4385499191');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1464327110', 35, 3, 3.59, 131, '4746900794');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1464560128', 35, 3, 3.66, 79, '4746900794');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1466418063', 36, 3, 3.04, 83, '4769663945');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1522929237', 36, 4, 3.85, 117, '4769663945');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1523179621', 36, 3, 2.88, 110, '4769663945');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1531978569', 36, 3, 2.97, 137, '4769663945');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1534536188', 36, 3, 3.59, 72, '4769663945');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1536204489', 36, 3, 2.99, 128, '4769663945');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1336118599', 41, 4, 3.53, 85, '3496267033');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1338545712', 42, 4, 3.05, 27, '3215261901');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1464560128', 44, 4, 3.55, 52, '4064403590');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1336118599', 45, 4, 3.47, 75, '4421663062');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1325307320', 46, 4, 2.93, 66, '4289432766');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1326719892', 46, 4, 3.42, 55, '4289432766');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1334756654', 47, 3, 2.99, 38, '4064403590');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1336118599', 47, 3, 3.67, 31, '4064403590');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1338545712', 47, 3, 2.95, 129, '4064403590');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1461665387', 47, 4, 3.83, 57, '4064403590');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1464327110', 47, 3, 3.84, 50, '4064403590');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1464560128', 47, 4, 3.31, 43, '4064403590');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1466418063', 48, 4, 2.51, 125, '3549817534');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1479329901', 48, 3, 3.73, 67, '3549817534');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1522929237', 48, 4, 3.94, 23, '3549817534');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1523179621', 48, 3, 3.09, 40, '3549817534');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1531978569', 48, 4, 2.96, 76, '3549817534');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1534536188', 48, 3, 3.41, 130, '3549817534');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1536204489', 48, 4, 3.38, 78, '3549817534');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1537676327', 48, 4, 3.01, 86, '3549817534');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1537763787', 48, 4, 2.68, 48, '3549817534');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1325307320', 51, 3, 3.55, 60, '4325533101');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1326719892', 51, 4, 3.38, 21, '4325533101');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1330626780', 51, 4, 2.75, 97, '4325533101');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1334756654', 51, 4, 3.51, 89, '4325533101');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1336118599', 51, 4, 2.64, 109, '4325533101');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1338545712', 51, 3, 3.41, 108, '4325533101');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1461665387', 51, 3, 3.65, 103, '4325533101');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1464327110', 51, 4, 2.59, 39, '4325533101');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1464560128', 51, 3, 3.14, 101, '4325533101');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1466418063', 51, 3, 3.43, 64, '4325533101');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1474480808', 51, 4, 3.05, 111, '4325533101');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1475329393', 51, 3, 3.26, 27, '4325533101');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1479329901', 51, 3, 3.53, 121, '4325533101');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1522929237', 52, 4, 3.86, 79, '3672861132');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1523179621', 52, 2, 3.79, 97, '3672861132');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1531978569', 52, 2, 3.52, 54, '3672861132');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1534536188', 52, 3, 2.86, 31, '3672861132');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1536204489', 52, 4, 2.59, 118, '3672861132');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1537676327', 52, 2, 2.77, 101, '3672861132');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1537763787', 52, 3, 3.46, 102, '3672861132');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1310336628', 53, 3, 3.24, 31, '4015060337');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1325307320', 53, 4, 3.58, 78, '4015060337');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1326719892', 53, 4, 3.74, 30, '4015060337');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1330626780', 53, 3, 3.52, 33, '4015060337');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1334756654', 53, 3, 3, 119, '4015060337');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1336118599', 53, 4, 3.03, 42, '4015060337');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1338545712', 53, 3, 2.98, 136, '4015060337');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1461665387', 53, 3, 3.03, 32, '4015060337');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1464327110', 53, 3, 3.53, 98, '4015060337');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1464560128', 53, 4, 3.19, 93, '4015060337');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1466418063', 53, 4, 3.64, 140, '4015060337');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1474480808', 53, 3, 3.22, 96, '4015060337');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1475329393', 53, 3, 3.25, 114, '4015060337');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1479329901', 53, 4, 2.57, 123, '4015060337');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1310336628', 54, 3, 3.86, 93, '3059038648');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1325307320', 54, 2, 2.75, 119, '3059038648');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1326719892', 54, 4, 3.26, 81, '3059038648');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1330626780', 54, 2, 2.71, 125, '3059038648');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1334756654', 54, 1, 2.97, 139, '3059038648');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1336118599', 54, 4, 3.05, 49, '3059038648');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1338545712', 54, 4, 2.95, 90, '3059038648');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1461665387', 54, 4, 2.87, 28, '3059038648');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1464327110', 54, 4, 3.75, 76, '3059038648');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1464560128', 54, 4, 3.15, 126, '3059038648');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1466418063', 54, 1, 3.16, 95, '3059038648');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1474480808', 54, 4, 3.89, 138, '3059038648');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1475329393', 54, 3, 3.82, 83, '3059038648');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1479329901', 54, 3, 2.64, 106, '3059038648');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1310336628', 57, 3, 3.88, 77, '3937455565');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1325307320', 57, 3, 2.66, 95, '3937455565');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1326719892', 57, 3, 2.91, 35, '3937455565');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1330626780', 57, 4, 2.55, 84, '3937455565');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1334756654', 57, 4, 3.52, 75, '3937455565');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1336118599', 57, 3, 3.54, 82, '3937455565');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1338545712', 57, 4, 3.83, 44, '3937455565');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1310336628', 58, 1, 2.83, 88, '4144885032');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1325307320', 58, 2, 3.19, 21, '4144885032');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1326719892', 58, 1, 3.07, 85, '4144885032');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1330626780', 58, 4, 2.63, 30, '4144885032');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1334756654', 58, 1, 3.23, 26, '4144885032');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1336118599', 58, 1, 3.81, 104, '4144885032');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1326719892', 59, 3, 3.79, 79, '4983146928');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1330626780', 59, 4, 3.64, 70, '4983146928');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1334756654', 59, 4, 3.19, 46, '4983146928');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1336118599', 59, 3, 2.89, 117, '4983146928');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1338545712', 59, 1, 3.25, 95, '4983146928');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1461665387', 59, 2, 3.34, 114, '4983146928');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1464327110', 59, 4, 3.83, 118, '4983146928');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1475329393', 59, 2, 3.53, 131, '4983146928');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1479329901', 59, 2, 4, 128, '4983146928');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1522929237', 59, 4, 4, 104, '4983146928');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1523179621', 59, 4, 3.08, 50, '4983146928');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1531978569', 59, 2, 3.58, 112, '4983146928');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1534536188', 59, 1, 3.48, 26, '4983146928');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1531978569', 60, 3, 2.79, 57, '3059038648');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1534536188', 60, 1, 3.15, 109, '3059038648');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1536204489', 60, 2, 3.62, 42, '3059038648');
INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1537676327', 60, 4, 3.65, 126, '3059038648');

-- insert status log --
INSERT INTO STATUS_LOG (id, status) VALUES ('1', 'dilaporkan');
INSERT INTO STATUS_LOG (id, status) VALUES ('2', 'disetujui');
INSERT INTO STATUS_LOG (id, status) VALUES ('3', 'ditolak');
INSERT INTO STATUS_LOG (id, status) VALUES ('4', 'diproses');

-- insert kategori log --
INSERT INTO KATEGORI_LOG (id, kategori) VALUES ('1', 'asistensi/tutorial');
INSERT INTO KATEGORI_LOG (id, kategori) VALUES ('2', 'persiapan asistensi');
INSERT INTO KATEGORI_LOG (id, kategori) VALUES ('3', 'membuat soal/tugas');
INSERT INTO KATEGORI_LOG (id, kategori) VALUES ('4', 'rapat');
INSERT INTO KATEGORI_LOG (id, kategori) VALUES ('5', 'sit in kelas');
INSERT INTO KATEGORI_LOG (id, kategori) VALUES ('6', 'mengoreksi');
INSERT INTO KATEGORI_LOG (id, kategori) VALUES ('7', 'mengawas');

-- insert log --
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (30, '1336118599', 3, 2, '2014-08-25', '13:44:00', '16:01:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (1, '1522929237', 3, 2, '2014-08-28', '16:34:00', '18:27:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (6, '1534536188', 5, 3, '2014-09-02', '18:20:00', '20:27:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (9, '1464560128', 5, 1, '2014-09-09', '18:46:00', '19:47:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (30, '1336118599', 6, 4, '2014-09-12', '16:07:00', '17:33:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (1, '1522929237', 6, 1, '2014-09-13', '18:37:00', '20:27:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (14, '1330626780', 6, 1, '2014-09-22', '20:56:00', '22:27:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (25, '1310336628', 3, 2, '2014-09-24', '11:55:00', '13:35:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (21, '1330626780', 5, 3, '2014-09-25', '12:43:00', '13:39:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (25, '1310336628', 5, 3, '2014-09-25', '12:32:00', '13:56:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (18, '1310336628', 3, 4, '2014-09-26', '20:14:00', '21:57:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (21, '1330626780', 4, 3, '2014-09-27', '11:06:00', '12:43:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (6, '1534536188', 3, 3, '2014-09-27', '14:47:00', '19:25:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (33, '1330626780', 6, 2, '2014-10-06', '13:37:00', '21:30:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (13, '1326719892', 6, 1, '2014-10-07', '11:25:00', '21:45:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (13, '1326719892', 6, 3, '2014-10-09', '12:47:00', '21:03:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (9, '1464560128', 5, 1, '2014-10-10', '16:14:00', '23:34:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (30, '1336118599', 3, 2, '2014-10-10', '14:43:00', '17:23:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (16, '1475329393', 2, 3, '2014-10-15', '12:08:00', '13:32:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (30, '1336118599', 1, 1, '2014-10-15', '14:13:00', '19:15:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (17, '1466418063', 6, 2, '2014-10-18', '10:24:00', '16:52:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (13, '1326719892', 5, 2, '2014-10-19', '12:09:00', '19:55:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (6, '1534536188', 6, 1, '2014-10-24', '09:50:00', '18:21:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (3, '1461665387', 7, 4, '2014-10-28', '12:50:00', '22:37:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (14, '1330626780', 6, 3, '2014-11-01', '09:52:00', '15:47:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (9, '1464560128', 7, 1, '2014-11-02', '15:20:00', '18:57:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (16, '1475329393', 6, 3, '2014-11-03', '11:10:00', '17:04:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (18, '1310336628', 3, 3, '2014-11-05', '15:37:00', '16:02:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (28, '1330626780', 1, 2, '2014-11-05', '18:16:00', '20:46:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (1, '1522929237', 4, 2, '2014-11-06', '08:56:00', '21:35:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (3, '1461665387', 3, 2, '2014-11-06', '13:36:00', '16:20:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (14, '1330626780', 3, 2, '2014-11-06', '21:30:00', '23:40:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (26, '1325307320', 1, 3, '2014-11-10', '09:01:00', '13:49:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (6, '1534536188', 1, 1, '2014-11-12', '09:00:00', '09:33:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (13, '1326719892', 5, 4, '2014-11-13', '08:04:00', '21:19:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (13, '1326719892', 5, 3, '2014-11-14', '11:03:00', '16:35:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (22, '1334756654', 1, 4, '2014-11-16', '10:47:00', '11:09:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (16, '1475329393', 5, 4, '2014-11-16', '09:51:00', '21:19:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (25, '1310336628', 5, 3, '2014-11-16', '14:45:00', '17:32:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (9, '1464560128', 7, 1, '2014-11-17', '11:33:00', '18:08:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (16, '1475329393', 7, 2, '2014-11-17', '08:33:00', '18:24:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (3, '1461665387', 5, 3, '2014-11-19', '20:45:00', '22:00:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (21, '1330626780', 3, 3, '2014-11-26', '17:25:00', '17:30:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (25, '1310336628', 3, 2, '2014-12-02', '15:34:00', '22:35:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (21, '1330626780', 7, 1, '2014-12-03', '10:14:00', '17:14:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (21, '1330626780', 6, 3, '2014-12-05', '10:04:00', '15:53:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (25, '1310336628', 6, 3, '2014-12-07', '10:21:00', '16:24:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (13, '1326719892', 2, 3, '2014-12-08', '17:04:00', '17:48:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (21, '1330626780', 3, 2, '2014-12-09', '13:45:00', '14:15:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (13, '1326719892', 3, 3, '2014-12-10', '16:51:00', '18:20:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (1, '1522929237', 6, 4, '2014-12-12', '18:18:00', '20:45:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (22, '1334756654', 4, 4, '2014-12-14', '09:49:00', '12:43:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (1, '1522929237', 4, 4, '2014-12-15', '18:01:00', '23:44:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (26, '1325307320', 5, 4, '2014-12-16', '11:06:00', '13:58:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (22, '1334756654', 7, 2, '2014-12-17', '18:46:00', '20:07:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (45, '1330626780', 3, 4, '2015-02-10', '10:52:00', '23:00:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (54, '1537676327', 3, 4, '2015-02-13', '12:26:00', '20:12:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (46, '1334756654', 3, 2, '2015-02-15', '15:49:00', '22:59:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (58, '1310336628', 4, 2, '2015-02-16', '22:00:00', '22:56:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (45, '1330626780', 4, 3, '2015-02-16', '17:51:00', '19:49:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (57, '1338545712', 4, 1, '2015-02-19', '09:38:00', '11:19:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (41, '1536204489', 7, 1, '2015-02-24', '12:55:00', '14:17:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (38, '1464560128', 1, 1, '2015-02-27', '09:08:00', '13:43:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (59, '1325307320', 4, 3, '2015-03-01', '13:52:00', '16:38:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (54, '1537676327', 6, 1, '2015-03-05', '10:07:00', '13:16:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (51, '1466418063', 1, 1, '2015-03-06', '14:00:00', '16:55:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (58, '1310336628', 4, 4, '2015-03-11', '19:55:00', '21:36:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (40, '1534536188', 5, 3, '2015-03-12', '11:52:00', '13:45:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (38, '1464560128', 4, 1, '2015-03-13', '21:22:00', '23:54:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (38, '1464560128', 5, 3, '2015-03-14', '09:04:00', '10:42:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (51, '1466418063', 5, 1, '2015-03-14', '17:06:00', '22:57:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (57, '1338545712', 5, 3, '2015-03-17', '19:19:00', '19:56:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (60, '1326719892', 3, 4, '2015-03-17', '09:00:00', '12:41:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (38, '1464560128', 1, 3, '2015-03-21', '14:59:00', '18:07:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (38, '1464560128', 6, 4, '2015-03-23', '10:34:00', '16:32:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (53, '1536204489', 5, 4, '2015-03-23', '10:59:00', '20:45:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (41, '1536204489', 7, 3, '2015-03-24', '09:46:00', '13:19:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (45, '1330626780', 3, 1, '2015-03-25', '09:18:00', '14:57:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (59, '1325307320', 2, 1, '2015-03-26', '18:44:00', '19:03:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (59, '1325307320', 2, 1, '2015-03-29', '13:20:00', '17:19:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (58, '1310336628', 5, 3, '2015-03-29', '13:29:00', '05:59:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (59, '1325307320', 4, 2, '2015-04-07', '12:41:00', '19:57:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (38, '1464560128', 5, 3, '2015-04-08', '09:30:00', '12:33:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (60, '1326719892', 7, 4, '2015-04-08', '11:47:00', '15:13:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (38, '1464560128', 7, 4, '2015-04-11', '14:42:00', '17:48:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (46, '1334756654', 7, 4, '2015-04-11', '20:50:00', '23:37:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (60, '1326719892', 3, 2, '2015-04-15', '10:48:00', '13:00:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (46, '1334756654', 6, 4, '2015-04-17', '09:51:00', '11:36:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (51, '1466418063', 2, 1, '2015-04-19', '11:03:00', '14:07:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (54, '1537676327', 3, 2, '2015-05-03', '13:52:00', '17:07:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (41, '1536204489', 1, 4, '2015-05-06', '16:26:00', '19:05:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (51, '1466418063', 1, 4, '2015-05-10', '08:41:00', '10:17:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (59, '1325307320', 7, 3, '2015-05-11', '17:51:00', '21:05:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (59, '1325307320', 1, 3, '2015-05-11', '21:58:00', '23:54:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (54, '1537676327', 3, 2, '2015-05-14', '12:58:00', '16:17:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (60, '1326719892', 6, 3, '2015-05-17', '11:32:00', '15:30:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (54, '1537676327', 4, 1, '2015-05-19', '13:09:00', '16:20:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (41, '1536204489', 7, 1, '2015-05-21', '08:30:00', '10:05:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (57, '1338545712', 4, 4, '2015-05-29', '11:40:00', '15:06:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (38, '1464560128', 4, 3, '2015-05-30', '11:09:00', '15:14:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (41, '1536204489', 4, 3, '2015-05-31', '08:02:00', '09:59:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (51, '1466418063', 2, 4, '2015-05-31', '14:05:00', '17:43:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (53, '1536204489', 2, 1, '2015-06-02', '16:31:00', '22:20:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (59, '1325307320', 6, 1, '2015-06-06', '08:56:00', '12:22:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (38, '1464560128', 1, 4, '2015-06-06', '14:32:00', '16:23:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (40, '1534536188', 1, 4, '2015-06-10', '11:39:00', '16:58:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (41, '1536204489', 1, 4, '2015-06-15', '20:40:00', '21:36:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (53, '1536204489', 3, 2, '2015-06-17', '09:02:00', '11:26:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (57, '1338545712', 6, 2, '2015-06-18', '17:00:00', '18:32:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (54, '1537676327', 6, 4, '2015-06-18', '12:00:00', '13:52:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (72, '1325307320', 4, 4, '2015-07-04', '15:29:00', '21:57:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (99, '1534536188', 1, 4, '2015-07-06', '15:26:00', '23:44:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (88, '1334756654', 1, 3, '2015-07-13', '20:00:00', '21:43:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (66, '1531978569', 7, 2, '2015-07-17', '10:00:00', '11:39:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (63, '1466418063', 7, 2, '2015-07-18', '18:00:00', '19:44:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (97, '1523179621', 7, 2, '2015-07-23', '18:37:00', '23:29:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (67, '1336118599', 1, 3, '2015-07-24', '10:00:00', '11:54:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (63, '1466418063', 3, 2, '2015-07-24', '08:34:00', '12:52:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (89, '1336118599', 5, 3, '2015-07-28', '15:00:00', '16:21:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (88, '1334756654', 1, 1, '2015-07-28', '13:45:00', '16:35:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (99, '1534536188', 5, 1, '2015-07-30', '17:09:00', '22:13:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (78, '1523179621', 2, 4, '2015-07-30', '10:42:00', '16:02:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (88, '1334756654', 4, 3, '2015-07-30', '21:43:00', '22:00:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (79, '1531978569', 5, 2, '2015-08-06', '13:00:00', '15:59:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (78, '1523179621', 1, 3, '2015-08-10', '17:00:00', '18:33:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (95, '1479329901', 5, 1, '2015-08-25', '20:00:00', '21:05:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (95, '1479329901', 4, 3, '2015-08-26', '18:00:00', '19:31:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (90, '1338545712', 3, 4, '2015-08-27', '17:23:00', '19:38:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (99, '1534536188', 2, 3, '2015-08-29', '22:00:00', '23:07:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (99, '1534536188', 1, 4, '2015-08-31', '08:00:00', '09:08:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (92, '1464327110', 5, 1, '2015-09-03', '10:00:00', '12:45:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (88, '1334756654', 5, 4, '2015-09-05', '22:00:00', '23:22:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (90, '1338545712', 5, 1, '2015-09-11', '19:21:00', '21:34:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (89, '1336118599', 3, 2, '2015-09-12', '15:00:00', '17:15:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (95, '1479329901', 4, 1, '2015-09-23', '08:00:00', '09:12:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (90, '1338545712', 5, 4, '2015-09-26', '13:00:00', '14:35:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (97, '1523179621', 3, 1, '2015-09-29', '10:00:00', '11:50:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (88, '1334756654', 2, 2, '2015-09-29', '18:42:00', '19:29:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (89, '1336118599', 6, 4, '2015-09-29', '11:00:00', '12:11:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (90, '1338545712', 1, 3, '2015-09-30', '08:09:00', '09:44:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (97, '1523179621', 2, 4, '2015-10-02', '11:43:00', '12:43:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (90, '1338545712', 1, 4, '2015-10-03', '08:00:00', '09:21:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (95, '1479329901', 5, 1, '2015-10-05', '09:57:00', '11:06:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (89, '1336118599', 5, 2, '2015-10-06', '17:56:00', '20:00:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (92, '1464327110', 1, 1, '2015-10-08', '12:00:00', '13:16:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (95, '1479329901', 1, 1, '2015-10-09', '12:47:00', '15:00:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (89, '1336118599', 2, 4, '2015-10-13', '18:24:00', '21:55:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (99, '1534536188', 6, 2, '2015-10-17', '16:12:00', '17:23:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (88, '1334756654', 3, 1, '2015-10-17', '20:00:00', '20:56:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (97, '1523179621', 7, 2, '2015-10-18', '15:53:00', '16:11:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (95, '1479329901', 3, 3, '2015-10-18', '16:14:00', '21:25:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (95, '1479329901', 2, 4, '2015-10-23', '10:10:00', '12:10:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (88, '1334756654', 7, 2, '2015-11-15', '17:55:00', '21:54:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (97, '1523179621', 2, 1, '2015-11-16', '17:00:00', '18:15:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (89, '1336118599', 5, 2, '2015-11-19', '14:33:00', '16:00:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (90, '1338545712', 1, 3, '2015-11-20', '17:21:00', '21:11:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (92, '1464327110', 5, 1, '2015-11-25', '21:31:00', '22:48:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (88, '1334756654', 4, 3, '2015-11-29', '10:00:00', '12:03:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (92, '1464327110', 4, 2, '2015-12-01', '10:32:00', '23:08:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (97, '1523179621', 3, 1, '2015-12-03', '10:28:00', '19:19:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (88, '1334756654', 5, 3, '2015-12-03', '18:00:00', '19:03:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (89, '1336118599', 5, 2, '2015-12-14', '18:38:00', '23:03:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (89, '1336118599', 7, 3, '2015-12-18', '10:07:00', '20:27:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (97, '1523179621', 5, 1, '2015-12-19', '16:00:00', '18:04:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (88, '1334756654', 2, 3, '2015-12-20', '10:00:00', '11:23:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (127, '1334756654', 7, 3, '2016-02-10', '11:50:00', '18:16:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (127, '1334756654', 3, 1, '2016-02-18', '18:00:00', '20:54:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (137, '1310336628', 7, 1, '2016-02-20', '10:00:00', '11:56:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (103, '1325307320', 6, 3, '2016-02-22', '18:00:00', '18:38:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (164, '1326719892', 2, 2, '2016-02-23', '15:56:00', '17:44:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (152, '1325307320', 2, 2, '2016-02-24', '10:00:00', '11:39:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (167, '1336118599', 7, 4, '2016-02-24', '20:00:00', '20:25:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (149, '1475329393', 3, 4, '2016-02-24', '10:00:00', '14:49:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (152, '1325307320', 2, 4, '2016-03-08', '13:00:00', '16:58:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (130, '1461665387', 4, 3, '2016-03-09', '15:00:00', '16:02:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (119, '1534536188', 6, 1, '2016-03-11', '11:17:00', '19:08:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (149, '1475329393', 5, 3, '2016-03-13', '08:00:00', '09:04:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (153, '1326719892', 2, 1, '2016-03-14', '12:00:00', '12:31:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (122, '1537763787', 7, 4, '2016-03-17', '08:00:00', '11:47:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');
INSERT INTO LOG (idlamaran, npm, id_kat_log, id_st_log, tanggal, jam_mulai, jam_selesai, deskripsi_kerja) VALUES (108, '1338545712', 7, 2, '2016-03-18', '10:00:00', '12:18:00', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit.');

-- TRIGGER AND STORED PROCEDURE --

CREATE OR REPLACE FUNCTION updt_pelamar()
	RETURNS "trigger" AS
	$$
	  BEGIN
	  	IF(TG_OP = 'INSERT') THEN
	  	UPDATE LOWONGAN SET jumlah_pelamar = jumlah_pelamar + 1
	  		WHERE idLowongan = NEW.idLowongan;
	  	RETURN NEW;

	  	ELSIF(TG_OP = 'DELETE') THEN
	  	UPDATE LOWONGAN SET jumlah_pelamar = jumlah_pelamar - 1
	  		WHERE idLowongan = OLD.idLowongan;
	  	RETURN OLD;

	  	END IF;
	  END;
	$$
	LANGUAGE 'plpgsql' VOLATILE;

CREATE TRIGGER jml_pelamar
	AFTER INSERT OR DELETE
	ON LAMARAN
	FOR EACH ROW
	EXECUTE PROCEDURE updt_pelamar();

/*
cek trigger jml_pelamar

INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1479329901', 60, 1, 4.00, 129, '3059038648');
*/

CREATE OR REPLACE FUNCTION updt_diterima()
	RETURNS "trigger" AS
	$$
	  BEGIN
	  	IF(TG_OP='UPDATE') THEN
	  	UPDATE LOWONGAN SET jumlah_diterima = jumlah_diterima + 1
	  		WHERE idLowongan = NEW.idLowongan AND NEW.id_st_lamaran=3;
	  	RETURN NEW;

	  	END IF;
	  END;
	$$
	LANGUAGE 'plpgsql' VOLATILE;

CREATE TRIGGER jml_pelamar_diterima
	AFTER UPDATE
	ON LAMARAN
	FOR EACH ROW
	EXECUTE PROCEDURE updt_diterima();

/*
cek trigger jml_pelamar_diterima 

UPDATE LAMARAN SET id_st_lamaran=3 WHERE idlamaran=185;

SELECT * FROM LOWONGAN WHERE idlowongan=60;
*/