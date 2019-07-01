<h1>Custom Framework For Fivem</h1>

### TODO:
- [X] Dataa menee databaseen
- [ ] Käännös järjestelmä i18n?
- [ ] Raha homma
- [ ] Admin toolit
- [ ] Utils. 3D text, progressbar, notification yms.

### Miten saan toimimaan:
 1. Lataa tiedosto, ja laita se serverin tiedostoihin. Laita server.cfg:hen start Base. HUOM! Tarvitset <a href="https://github.com/brouznouf/fivem-mysql-async">mysql-async</a>
 2. Server.cfg:stä poista rivi `star fivem`
 3. Mene fivem-map-skater ja fivem-map-hipster \_\_resource.lua tiedostoon ja muokkaa rivi `resource_type 'map' { gameTypes = { fivem = true } }` ==> `resource_type 'map' { gameTypes = { Base = true } }`
