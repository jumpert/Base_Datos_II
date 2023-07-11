/*
select count(*) from optimizacion.cursosalumnos
select count(*) from optimizacion.alumnos
select count(*) from optimizacion.cursos
select count(*) from optimizacion.examenes
select count(*) from optimizacion.semestres
select count(*) from optimizacion.anioacademico
select count(*) from optimizacion.cursosfacultades
select count(*) from optimizacion.examenesalu
select count(*) from optimizacion.facultades

select * from optimizacion.cursosalumnos
select * from optimizacion.cursosalumnos  where cursosalumnos.nomalu = 'Kim%';


SELECT *
FROM optimizacion.alumnos A
WHERE EXISTS (SELECT * FROM optimizacion.cursosalumnos CA
WHERE A."idAlu"=CA."idAlu"
AND nota >8
AND NOT EXISTS (SELECT * FROM optimizacion.examenesalu EA
WHERE CA."IdCur"=EA."idCur"
AND CA."idAlu"=EA."idAlu"
AND nota < 9))

SELECT nomalu, nomcur
FROM optimizacion.cursosalumnos ca 
join optimizacion.alumnos a on ca."idAlu"=a."idAlu"
join optimizacion.cursos c on ca."IdCur"=c."idCur"
where ca."idAlu"=a."idAlu"

SELECT nomalu, nomcur
FROM optimizacion.alumnos a, optimizacion.cursosalumnos ca, optimizacion.cursos c
WHERE a."idAlu"=ca."idAlu"
AND ca."IdCur"=c."idCur"
AND C.nomcur LIKE 'Q%'
AND C."idAnio">=2016
AND nota > 1

SELECT *
FROM optimizacion.alumnos A
WHERE EXISTS (SELECT * FROM optimizacion.cursosalumnos CA
WHERE A."idAlu"=CA."idAlu"
AND nota >8
AND NOT EXISTS (SELECT * FROM optimizacion.examenesalu EA
WHERE CA."IdCur"=EA."idCur"
AND CA."idAlu"=EA."idAlu"
AND nota < 9))

SELECT *
FROM optimizacion.facultades F
WHERE NOT EXISTS (SELECT * FROM optimizacion.cursosfacultades CF
WHERE F."idFac"=CF."idFac"
AND NOT EXISTS (SELECT * FROM optimizacion.cursos C
WHERE CF."idCur"=C."idCur"
AND "idAnio"=2016))*/

/*
SELECT *
FROM optimizacion.alumnos A
WHERE EXISTS (SELECT * FROM optimizacion.cursosalumnos CA
WHERE A."idAlu"=CA."idAlu"
AND NOTA >60
AND NOT EXISTS (SELECT * FROM optimizacion.examenesalu EA
WHERE (CA."IdCur"=EA."idCur"
AND CA."idAlu"=EA."idAlu"
AND nota < 61)))*/

/*create index indiceCurAlu on optimizacion.cursosalumnos ("IdCur","idAlu");
SELECT *
FROM optimizacion.alumnos A
WHERE EXISTS (SELECT * FROM optimizacion.cursosalumnos CA
WHERE A."idAlu"=CA."idAlu"
AND nota >8
AND NOT EXISTS (SELECT * FROM optimizacion.examenesalu EA
WHERE CA."IdCur"=EA."idCur"
AND CA."idAlu"=EA."idAlu"
AND nota < 9))

select nomcur, nomalu
from optimizacion.alumnos a, optimizacion.cursosalumnos ca, optimizacion.cursos c
where a."idAlu"=ca."idAlu"*/

create index indiceCurAluNot on optimizacion.cursosalumnos ("IdCur","idAlu", "nota");
SELECT *
FROM optimizacion.facultades F
WHERE NOT EXISTS (SELECT * FROM optimizacion.cursosfacultades CF
WHERE F."idFac"=CF."idFac"
AND NOT EXISTS (SELECT * FROM optimizacion.cursos C
WHERE CF."idCur"=C."idCur"
AND "idAnio"=2016))

SELECT *
FROM optimizacion.cursosalumnos 