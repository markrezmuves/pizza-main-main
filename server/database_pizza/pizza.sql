

SELECT * FROM pizza;
SELECT * FROM rendeles;
SELECT * FROM cim;


# get .../pizzak
  SELECT * FROM pizza;

  # get .../pizzak/1
  SELECT * FROM pizza where id = 1;

#   post .../pizzak

  insert into pizza
    (nev, meret, ar)
    values 
    ('kiskutya', 22, 1500);

  #delete ../pizzak/1
  delete from pizza where id = 11;

  #put .../pizzak/2
    update pizza set nev = 'asddd', meret = 4534, ar = 345353535 where id = 118;
         

    #get ../pizzak/sajt

      select * from pizza where like nev '%sajt%';

   
        
        #get ../cimek
          select * from cim;

            # get .../pizzak/1
  SELECT * FROM cim where id = 1;


  SELECT * FROM cim;

delete from cim where id = 0;
     #post .../cimek
        insert into cim 
          (nev, utca, hsz)
          VALUES
          ('aaaa', 'a utca', 15);

         #put .../cim/10
    update cim set nev = 'asddd',  utca = 'Igen', hsz = 345353535 where id = 10;


  #delete ../cimek/100
  delete from cim where id = 100;

  #get n
    select id, CONCAT(nev, ' ', utca, ' ', hsz) nevcim from cim
    order by nev
    ;
    
  #post rendeles
  insert into rendeles
    (pizzaid,darab,cimid,szallitas)
    VALUES
    (50,2,184,'2023.05.12. 12:00');

  select * from rendeles;

  delete from rendeles
    where id = 0;