# Pizzéria Weboldal

A Pizzéria Weboldal egy modern és felhasználóbarát online rendelőfelületet biztosít, amely lehetővé teszi a felhasználók számára, hogy telefonon keresztül kényelmesen és egyszerűen rendeljenek pizzát. A weboldal különféle funkciókkal rendelkezik, amelyek megkönnyítik az online rendelést és testreszabást.

## Főbb funkciók:

- **Pizzák böngészése**: A felhasználók áttekinthetik a pizzák kínálatát és részletes leírásukat. A pizzák rendelésekor kiválaszthatják a méretüket, a feltéteket és egyéb paramétereket.

- **Rendelés testreszabása**: Az adminisztrátorok testreszabhatják a rendeléseiket, annak különböző adatait.



- **A rendelők adatainak felvétele**: Az adminok lementhetik a rendelők adatit, amely lehetővé teszi számukra, hogy mentse a rendeléseiket, nyomon kövessék a történetüket és gyorsabban rendeljenek a jövőben.

- **Szerkesztés és törlés**: Az adminisztrátorok szerkeszthetik és törölhetik a korábbi rendeléseiket.

Ez a Pizzéria Weboldal egy felhasználóbarát és hatékony rendelőfelületet biztosít, amely lehetővé teszi a telefonon történő egyszerű és testreszabott pizzarendelést. A weboldal könnyen kezelhető, és a felhasználók széles választékából választhatnak a kínálatban lévő pizzák közül.
# A weboldal Üzembe Helyezése

A weboldal üzembe helyezéséhez számos programra lesz szükségünk. Biztosítsd, hogy a következő programok telepítve legyenek a számítógépeden: 

- [XAMPP](https://www.apachefriends.org/index.html): Az Apache és MySQL szervereket tartalmazza. Indítsd el az Apache és MySQL szervereket a XAMPP vezérlőpanel segítségével.

- [Visual Studio Code](https://code.visualstudio.com/): Egy könnyen használható kódszerkesztő, amely segíti a weboldal fejlesztését.

- [dbForge](https://www.devart.com/dbforge/): Egy adatbázis kezelő eszköz, amely segít az adatbázis biztonsági mentésének importálásában.

- [Git](https://git-scm.com/): Verziókezelő rendszer a kódbázis kezeléséhez.

- [Node.js](https://nodejs.org/): Egy JavaScript futtatókörnyezet, amely lehetővé teszi a JavaScript alapú szerveroldali fejlesztést.

## Üzembe helyezési lépések:

1. Indítsd el a XAMPP-ot, és indítsd el az Apache és MySQL szervereket a vezérlőpanel segítségével.

2. Importáld a webáruház adatbázisát a számítógépedre a következő útvonalon található fájlokból: `pizza-main-main\server\database_pizza`. Használva a dbForge-ot, futtasd le az adatbázis biztonsági mentését. Miután betöltött, futtasd a F5 billentyűvel a fájlt.

Ezzel készen vagyunk! Most már rendelkezünk a Webáruház adatbázisával és elindíthatjuk a weboldalt.


Az első git bashbe a következő parancsokat kell írnunk:

\`cd backend\` -> Ezzel a paranccsal a backend nevű mappába lépünk

\`npm run dev\` -> Ezzel a paranccsal a backendbe lévő szervert tudjuk futtatni

Az első git bash füllel kész vagyunk. Most lépjünk a másodikba

A parancsok amiket be kell írni:

\`cd backend\` -> Ismét a backend mappába kell lépnünk

\`npm run devauth\` -> Ezzel a paranccsal elindítjuk az authentikációs szervert, ami a fiókokhoz fog kelleni

Most pedig a harmadik git bashbe kell lépnünk

A szükséges parancsok:

\`cd frontend\` -> A frontend nevű mappába lépünk

\`npm run dev\` -> A frontend mappába lévő klienst indítsuk el ezzel a paranccsal. Miután lefut a terminál, kiír nekünk egy linket 'localhost' néven.

A CTRL billentyű lenyomása mellett kattintsunk rá a linkre, és megnyílik a szerver kliens oldala az alapértelmezett böngészőnkben. Immáron teljes üzemben van az alkalmazás.
