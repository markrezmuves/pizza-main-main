# Pizzéria Weboldal Műszaki Leírás

## Backend

A backend rész felelős az üzleti logika végrehajtásáért, adatkezelésért és a kommunikációért az adatbázissal. A következő funkciókat tartalmazza:

- **API végpontok**: Az API végpontok az ügyfelek és a szerver közötti kommunikációért felelnek. Ide tartoznak a pizzák, rendelések, felhasználók kezelésével kapcsolatos végpontok.

- **Adatbázis kezelő**: A backend használ egy adatbázist a pizzák, felhasználók és rendelések tárolására. Az adatbázis kapcsolatot és lekérdezéseket kezel a szükséges műveletek végrehajtásához.

- **Üzleti logika**: Itt találhatók a pizzéria üzleti logikájához kapcsolódó műveletek. Például, a rendelések feldolgozása, kosárkezelés, kedvezmények kiszámítása stb.

## Frontend

A frontend rész felelős a weboldal felhasználói felületének kialakításáért és a felhasználóval való kommunikációért. A következő funkciókat tartalmazza:

- **Felhasználói felület**: A frontend fejleszti és kezeli a felhasználói felületet. Ez magában foglalja az oldalak tervezését, a navigációt, a űrlapokat, a gombokat és egyéb felhasználói interakciókat.

- **Adatok lekérése**: A frontend kommunikál a backenddel, és lekéri a szükséges adatokat az API végpontok segítségével. Például, lekérdezheti a rendelhető pizzák listáját vagy az aktuális felhasználó rendeléseit.

- **Eseménykezelés**: A frontend kezeli az eseményeket, például a gombnyomásokat vagy az űrlapok beküldését. Ezen események alapján végrehajtja a szükséges műveleteket, például adatok validálását vagy rendelések elküldését a backendre.

## Mappa struktúra

A következő mappa struktúra javasolt 

  - 📁 server
    - 📁 config: Az API végpontok kezeléséért felelős vezérlők.
    - 📁 databasepizza: Az adatbázismodelljekek, például pizzák, felhasználók és rendelések.
    - 📁 routes: Az API útvonalainak definiálása és irányítása.
    - 📁 utils: Segédfüggvények és hasznos eszközök.
    - 📄 server.js: A server  indítása és konfigurálása.
  - 📁 frontend
    - 📁 components: Újrafelhasználható komponensek, például navigáció, űrlapok stb.
    - 📁 views: A weboldal különböző oldalainak komponensei.
    - 📁 styles: A weboldal stíluslapjai és CSS fájlok.
    - 📄 index.html: A weboldal fő HTML fájlja.
    - 📄 main.js: Az alkalmazás fő JavaScript fájlja.
  - 📄 README.md: A projekt dokumentációja és leírása.

