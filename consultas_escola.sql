-- a.	Produza um relatório que contenha os dados dos alunos matriculados em todos os cursos oferecidos pela escola.

SELECT ALUNO.* 
FROM ALUNO JOIN MATRICULA ON (ALUNO.CPF = MATRICULA.CPF_ALUNO)
ORDER BY ALUNO.Nome;

-- b.	Produza um relatório com os dados de todos os cursos, com suas respectivas disciplinas, oferecidos pela escola.

SELECT CURSO.*, DISCIPLINA.Nome as Disciplina
FROM CURSO JOIN COMPOE ON (CURSO.ID = COMPOE.ID_Curso)
           JOIN DISCIPLINA ON (DISCIPLINA.ID = COMPOE.ID_Disc)
ORDER BY CURSO.Nome;

-- c.	Produza um relatório que contenha o nome dos alunos e as disciplinas em que estão matriculados (CURSA ????).

SELECT ALUNO.Nome AS ALUNO, DISCIPLINA.Nome AS DISCIPLINA
FROM ALUNO JOIN CURSA ON (ALUNO.CPF = CURSA.CPF_Aluno)
           JOIN DISCIPLINA ON (DISCIPLINA.ID = CURSA.ID_Disc)
ORDER BY ALUNO.Nome;

-- d.	Produza um relatório com os dados dos professores e as disciplinas que ministram.

SELECT PROFESSOR.Nome AS PROFESSOR, DISCIPLINA.Nome AS DISCIPLINA
FROM PROFESSOR JOIN DISCIPLINA ON (DISCIPLINA.Matricula_Prof = PROFESSOR.Matricula)
ORDER BY PROFESSOR.Nome;

-- e.	Produza um relatório com os nomes das disciplinas e seus pré-requisitos.

SELECT DISCIPLINA.Nome AS DISCIPLINA, PRE.Nome AS PRE_REQUISITO
FROM DISCIPLINA LEFT JOIN PRE_REQ ON (DISCIPLINA.ID = PRE_REQ.ID_Disc)
                LEFT JOIN DISCIPLINA PRE ON (PRE.ID = PRE_REQ.ID_Disc_Dependencia)
ORDER BY DISCIPLINA.Nome;

-- f.	Produza um relatório com a média de idade dos alunos matriculados em cada curso.

SELECT CURSO.Nome, AVG(AGE(ALUNO.Data_Nasc))
FROM CURSO JOIN MATRICULA ON (CURSO.ID = MATRICULA.ID_Curso)
           JOIN ALUNO ON (ALUNO.CPF = MATRICULA.CPF_Aluno)
GROUP BY CURSO.Nome;

-- g.	Produza um relatório com os cursos oferecidos por cada departamento.

SELECT DEPARTAMENTO.Nome AS DEPARTAMENTO, CURSO.NOME AS CURSO
FROM DEPARTAMENTO LEFT JOIN CURSO ON (DEPARTAMENTO.ID = CURSO.ID_Dpto)
ORDER BY DEPARTAMENTO.Nome;