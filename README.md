<h1>Custom Framework For Fivem</h1>

### TODO:
- [X] Dataa menee databaseen
- [X] Käännös järjestelmä i18n?
- [ ] Raha homma
- [ ] Admin toolit
- [ ] Utils. 3D text, progressbar, notification yms.

### Miten saan toimimaan:
 1. Lataa tiedosto, ja laita se serverin tiedostoihin. Laita server.cfg:hen start Base. HUOM! Tarvitset <a href="https://github.com/brouznouf/fivem-mysql-async">mysql-async</a>
 2. Server.cfg:stä poista rivi `start fivem`
 3. Mene fivem-map-skater ja fivem-map-hipster \_\_resource.lua tiedostoon ja muokkaa rivi: 
 `resource_type 'map' { gameTypes = { fivem = true } }` ==> `resource_type 'map' { gameTypes = { Base = true } }`

### Miten saan mysql-asyncin ja locale järjestelmän toimimaan omassa scriptissä:
 <h3>MySQL</h3>
 1. MYSQL: Lisää `'@mysql-async/lib/MySQL.lua'` omaan \_\_resource.lua tiedostoon server sideen ensinmäiseksi
 <h3>Locale</h3>
 1. Locale: Lisää `'@Spectrum_Core\locale.lua'` omaan \_\_resource.lua tiedostoon server ja/tai client sideen ennen `fi.lua (tai joku muu kieli)` tiedostoja
 2. lisää `config.lua` tiedostoon `Settings.Locale = 'fi' (tai joku muu kieli)`
 
