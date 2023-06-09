-- Neculae Andrei-Fabian
-- Grupa 152
-- Numarul 2

-- 1
-- Nu functioneaza complet, face produs cartezian la un mom dat
-- Conditia din WHERE mai sterge din duplicate, insa se observa la Andrei camera 9 daca nu se pune distinct, care nu rezolva problema produsului cartezian
SELECT DISTINCT t.id "Cod turist", prenume "Prenume turist",
       c.id "Cod camera", data_rezervare "Data rezervare",
       nr_camera "Nr. camera" --, tarif "Tarif camera"
FROM TURIST t
JOIN TURIST_REZERVARE tr ON (t.id = tr.id_turist)
JOIN REZERVARE r ON (tr.id_rezervare = r.id)
JOIN TARIF_CAMERA tc ON (r.id_camera = tc.id_camera)
JOIN CAMERA c ON (r.id_camera = c.id)
WHERE data_rezervare >= data_start AND data_rezervare + nr_zile <= NVL(data_end, '31-DEC-9999'); -- daca data-end e null, data-end devine f mare pentru a se valida mereu 


-- 2
SELECT id, denumire, "Numar turisti", "Suma totala", rownum
FROM
(
    SELECT h.id, h.denumire, COUNT(DISTINCT t.id) "Numar turisti", SUM(tarif) "Suma totala"
    FROM HOTEL h
    JOIN CAMERA c ON (h.id = c.id_hotel)
    JOIN TARIF_CAMERA tc ON (c.id = tc.id_camera) -- pentru tarif
    JOIN REZERVARE r ON (c.id = r.id_camera)
    JOIN TURIST_REZERVARE tr ON (r.id = tr.id_rezervare)
    JOIN TURIST t ON (tr.id_turist = t.id)
    GROUP BY h.id, h.denumire
    ORDER BY 3 DESC
)
WHERE ROWNUM = 1; -- hotelul cu numar maxim de turisti distinci

-- 3
SELECT t.id, nume, prenume
FROM TURIST t
JOIN TURIST_REZERVARE tr ON(t.id = tr.id_turist)
JOIN REZERVARE r ON(tr.id_rezervare = r.id)
WHERE TO_CHAR(r.data_rezervare, 'MM') IN ('06', '07', '08') -- aflam turistii cazati in intervalul iunie-august
MINUS
SELECT t.id, nume, prenume
FROM TURIST t
JOIN TURIST_REZERVARE tr ON(t.id = tr.id_turist)
JOIN REZERVARE r ON(tr.id_rezervare = r.id)
WHERE TO_CHAR(r.data_rezervare, 'MM') NOT IN ('06', '07', '08'); -- ii scadem pe cei care au fost cazati in afara lunilor iunie-august

-- 4
CREATE TABLE NUMAR_REZERVARI
(
    nume_turist VARCHAR2(30),
    prenume_turist VARCHAR2(30),
    data_rezervare DATE,
    numar_rezervari NUMBER(5)
);

INSERT INTO NUMAR_REZERVARI (
                                SELECT nume, prenume, data_rezervare, (
                                                                        SELECT COUNT(id_rezervare)
                                                                        FROM TURIST_REZERVARE
                                                                        WHERE id_turist = t.id
                                                                      )
                                FROM TURIST t
                                JOIN TURIST_REZERVARE tr ON (t.id = tr.id_turist)
                                JOIN REZERVARE r ON (tr.id_rezervare = r.id)
                            );































