# akamai-pops

A small pipeline that discovers Akamai edge server (PoP) locations by DNS and plots them on a map.

**[See the map](https://gpirujo.github.io/akamai-pops/)** — generated from a snapshot of ~3600 edge servers discovered across ~230 countries.

## How it works

1. `01_download_server_list.sh` — downloads a list of public DNS resolvers per country from [public-dns.tk](http://public-dns.tk).
2. `02_filter_server_list.sh` — keeps only the resolvers reported as fully reliable.
3. `03_query_servers.sh` — asks each resolver to resolve an Akamai-served hostname, collecting the edge server IPs it's routed to.
4. `04_consolidate_list.sh` — deduplicates the collected IPs into a single list.
5. `05_geolocate_edge_servers.sh` — geolocates each edge server IP via Akamai's EdgeScape service (same dependency as [akamai-debug](https://github.com/gpirujo/akamai-debug)'s `bin/geolookup` — see that repo for what's needed on the receiving end).
6. `06_regenerate_map.sh` — renders all geolocated points into `index.html` (Google Maps + MarkerClusterer).

`run.sh` drives steps 1-3 across every country, using the DNS resolver counts already present under `02-reliable-dns/` to decide what to (re)query — so that directory needs at least an empty `<country>.txt` file per country to bootstrap a first run.

The raw intermediate data (DNS server lists, per-resolver query results, ~3600 geolocated IPs) isn't included here — just the code and the resulting map.
