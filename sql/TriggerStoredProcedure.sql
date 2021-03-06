ALTER TABLE LOWONGAN ADD COLUMN jumlah_pelamar INT NOT NULL DEFAULT 0;
ALTER TABLE LOWONGAN ADD COLUMN jumlah_diterima INT NOT NULL DEFAULT 0;

CREATE TRIGGER jml_pelamar
	AFTER INSERT OR DELETE
	ON LAMARAN
	FOR EACH ROW
	EXECUTE PROCEDURE updt_pelamar();

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

INSERT INTO LAMARAN (npm, idlowongan, id_st_lamaran, ipk, jumlahsks, nip) VALUES ('1479329901', 60, 1, 4.00, 129, '3059038648');

CREATE TRIGGER jml_pelamar_diterima
	AFTER UPDATE
	ON LAMARAN
	FOR EACH ROW
	EXECUTE PROCEDURE updt_diterima();

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

UPDATE LAMARAN SET id_st_lamaran=3 WHERE idlamaran=185;

SELECT * FROM LOWONGAN WHERE idlowongan=60;
