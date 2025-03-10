LAB9 - SUBINTEROGARI NECORELATE
1)select * from studenti where bursa = (select max(bursa) FROM studenti);
2)select * from studenti where (an,grupa) IN (select an,grupa FROM studenti where nume='Arhire');
3)select nume,prenume,an,grupa,valoare FROM studenti natural join note WHERE (an,grupa,valoare) IN (select an,grupa,min(valoare) FROM studenti natural join note group by an,grupa) ORDER BY an,grupa;
3')select distinct nume,prenume,an,grupa,valoare,count(valoare) FROM studenti natural join note WHERE (an,grupa,valoare) IN (select an,grupa,min(valoare) FROM studenti natural join note group by an,grupa) GROUP BY nume,prenume,an,grupa,valoare ORDER BY an,grupa;
4)select nume,prenume,avg(valoare) FROM studenti natural join note group by nume,prenume,nr_matricol having avg(valoare)>(select avg(valoare) FROM note);
5)select nume,prenume,medie FROM (select nume,prenume,avg(valoare) medie FROM studenti natural join note GROUP BY nr_matricol,nume,prenume order by avg(valoare) desc ) where rownum<4;
6)select nr_matricol,nume,prenume from studenti natural join note group by nr_matricol,nume,prenume having avg(valoare)=(select max(avg(valoare)) FROM note group by nr_matricol);
7)select s.nr_matricol, s.nume, s.PRENUME, n.valoare, c.titlu_curs
from studenti s join note n on s.NR_MATRICOL=n.NR_MATRICOL join CURSURI c on n.ID_CURS=c.ID_CURS
where (n.valoare, c.titlu_curs) in (select n.valoare, c.TITLU_CURS
from studenti s join note n on s.NR_MATRICOL=n.NR_MATRICOL join CURSURI c on n.ID_CURS=c.ID_CURS where nume='Ciobotariu' and c.TITLU_CURS='Logica')
and s.nume<>'Ciobotariu';
8)select nume, prenume from (select nume, prenume, rownum rn from (select nume, prenume from studenti order by nume, prenume) where rownum<6) where rn=5;
9)  select * from studenti where nr_matricol=(select nr_matricol FROM(select nr_matricol,rownum rn from(select nr_matricol,sum(valoare*credite) from note natural join cursuri group by nr_matricol order by sum(valoare*credite) desc)) where rn=3);
10)select nume,prenume, valoare, id_curs, (SELECT titlu_curs from cursuri where id_curs=note.id_curs) FROM studenti natural join note where (nr_matricol,valoare,id_curs) in (select nr_matricol,valoare,id_curs from note where (id_curs,valoare) in (select n.id_curs,max(valoare) FROM note n join cursuri c on n.id_curs=c.id_curs group by n.id_curs,titlu_curs));

LAB10- SUBINTEROGARI CORELATE
1)select * from studenti s1 where exists (select 'banana' from studenti s2 where s1.data_nastere>s2.data_nasterE and s1.an=s2.an);
2)  select nume, prenume, avg(valoare) from studenti s1 join note n1 on s1.nr_matricol=n1.nr_matricol group by s1.nr_matricol, nume, prenume, an having avg(valoare) >= ALL(select avg(valoare) from studenti s2 join note n2 on s2.nr_matricol=n2.nr_matricol where s1.an=s2.an group by s2.nr_matricol);
3) select nume, prenume, avg(valoare), an, grupa from studenti s1 join note n1 on s1.nr_matricol=n1.nr_matricol group by s1.nr_matricol, nume, prenume, an, grupa having avg(valoare) >= ALL(select avg(valoare) from studenti s2 join note n2 on s2.nr_matricol=n2.nr_matricol where s1.an=s2.an and s1.grupa=s2.grupa group by s2.nr_matricol);
4) select nume, prenume, avg(valoare), an, grupa from studenti s1 join note n1 on s1.nr_matricol=n1.nr_matricol group by s1.nr_matricol, nume, prenume, an, grupa having avg(valoare) >= ALL(select avg(valoare) from studenti s2 join note n2 on s2.nr_matricol=n2.nr_matricol where s1.an=s2.an and s1.grupa=s2.grupa group by s2.nr_matricol);
5) select * from studenti s1 where not exists (select 'ceva' from studenti s2 where s1.nr_matricol<>s2.nr_matricol and s1.an=s2.an and s1.grupa=s2.grupa);
6) select nume, prenume, avg(valoare) from profesori p1 join didactic d1 on p1.id_prof=d1.id_prof join note n1 on d1.id_curs=n1.id_curs group by p1.id_prof, nume, prenume having avg(valoare) in (select avg(valoare) from profesori p2 join didactic d2 on p2.id_prof=d2.id_prof join note n2 on n2.id_curs=d2.id_curs where p1.id_prof<>p2.id_prof group by p1.id_prof, nume, prenume);
7) select s1.nume, s1.prenume, (select avg(valoare) from note where nr_matricol=s1.nr_matricol) as media from studenti s1;
8)select an,credite,titlu_curs from cursuri c1 where not exists (select 1 from cursuri c2 where c2.credite>c1.credite and c1.an=c2.an);
8')select titlu_curs,an,credite from cursuri where (an,credite) in (select an, max(credite) from cursuri group by an);
8) CORELAT: select titlu_curs from cursuri c1 where not exists (select 1 from cursuri c2 where c2.credite>c1.credite and c1.an=c2.an); 
8) NECORELAT: select titlu_curs from cursuri where (credite, an) in (select max(credite), an from cursuri group by an);
