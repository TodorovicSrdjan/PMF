﻿--Kolokvijum 2020/21

--1. Zadatak
select godina, count(*) as broj_odigranih_utakmica
from utakmice U join sezona S on U.id_sezone = S.id
group by godina

--2. Zadatak
alter view dani as
select id_igraca, CASE
						WHEN datum2 is not NULL THEN DATEDIFF(day,datum1,datum2)
						ELSE  DATEDIFF(day,datum1,GETDATE())
				  END as period_u_danima
from ugovori

select D1.id_igraca, D1.period_u_danima
from dani D1 left join dani D2 on D1.id_igraca != D2.id_igraca and D1.period_u_danima < D2.period_u_danima
where D2.id_igraca is NULL

--3. Zadatak
select ime,	(
				select count(*)
				from golovi G
				where G.id_igraca = I.id
				group by id_igraca
				
			)
from igraci I

--4. Zadatak
create view spisak_gosti as
select UT.id_sezone, UG.id_igraca, count(*) as broj_utakmica
from utakmice UT join ugovori UG on UT.id_gosta = UG.id_tima
group by UT.id_sezone, UG.id_igraca

create view spisak_domacin as
select UT.id_sezone, UG.id_igraca, count(*) as broj_utakmica
from utakmice UT join ugovori UG on UT.id_domacina = UG.id_tima
group by UT.id_sezone, UG.id_igraca

select godina,CASE 
					WHEN D.id_igraca is NULL THEN G.id_igraca
					WHEN G.id_igraca is NULL THEN D.id_igraca
					ELSE D.id_igraca
			  END as id_igraca , D.broj_utakmica + G.broj_utakmica as broj_utakmica
from spisak_domacin D full join spisak_gosti G on D.id_sezone = G.id_sezone and D.id_igraca = G.id_igraca
						   join sezona S on D.id_sezone = S.id or G.id_sezone = S.id
						   join ugovori U on D.id_igraca = U.id_igraca or G.id_igraca = U.id_igraca
where D.broj_utakmica + G.broj_utakmica > 3 and (S.godina between datepart(year,U.datum1) and datepart(year,U.datum2) or (U.datum2 is NULL and S.godina Between datepart(year,U.datum1) and datepart(year,GETDATE())))
order by godina

--5. Zadatak
create view broj_golova as
select ut.id, gl.id_tima, count(*) as broj_golova
from utakmice ut left join golovi gl on ut.id = gl.id_utakmice
group by ut.id, gl.id_tima

select id,
	   (select naziv from timovi where id = ut.id_domacina) nazivTimaDomacina,
	   (select naziv from timovi where id = ut.id_gosta) nazivTimaGosta,
	   concat( (select broj_golova from broj_golova where id = ut.id and id_tima = ut.id_domacina),
			   ':',
			   (select broj_golova from broj_golova where id = ut.id and id_tima = ut.id_gosta)) as rezultat
from utakmice ut

--6. Zadatak
select G.id_igraca, I.ime, count(*) as broj_autogolova
from golovi G join igraci I on G.id_igraca = I.id
where G.id_igraca not in (
								select U.id_igraca
								from ugovori U
								where G.id_tima = U.id_tima
						 )
group by G.id_igraca, I.ime
