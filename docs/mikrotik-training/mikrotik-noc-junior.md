# MikroTik CLI — Scope 1: Read-Only

Dokumen ini berisi perintah read-only untuk monitoring dan pengecekan.
Tidak ada perintah di sini yang mengubah konfigurasi router.

---

## Dasar CLI

### Navigasi

RouterOS CLI terstruktur seperti folder. Gunakan path absolut dari mana saja:

```
/interface print
/ip address print
/ppp active print
```

Atau masuk ke menu dulu, lalu jalankan perintah pendek:

```
[admin@router] > /ip address
[admin@router] /ip address> print
```

Kembali ke root: `/` — naik satu level: `..` — lihat pilihan: `?` — autocomplete: `Tab`

---

### print

Menampilkan semua item dalam menu aktif. Kolom pertama adalah **index** (0, 1, 2, ...) yang dipakai untuk operasi lain.

```
/interface print
/ip route print
```

Flags di header output menjelaskan huruf di kolom kiri — misalnya `R` = running, `X` = disabled, `D` = dynamic. Baca flags-nya, jangan diabaikan.

---

### where — Filter output

```
/interface print where running=yes
/ppp active print where name~="pelanggan"
/log print where message~="down"
```

Operator yang tersedia: `=` (sama persis), `!=` (tidak sama), `~=` (mengandung/regex), `>`, `<`.
Beberapa kondisi bisa dikombinasi — coba sendiri.

---

### find — Cari index item

`find` mengembalikan index item yang cocok. Jarang dipakai sendirian, lebih sering dikombinasikan dengan bracket `[ ]`:

```
/interface find running=yes
/queue simple monitor [find name~="pelanggan"]
/interface ethernet monitor [find name~="sfp"]
```

---

### get — Ambil satu nilai

Mengambil nilai properti tertentu dari satu item. Output bersih, tanpa tabel:

```
/system resource get uptime
/system resource get cpu-load
/interface get 0 name
/ppp active get [find name="user123"] uptime
```

---

### detail, proplist, count-only

Tiga modifier `print` yang sering berguna:

```
# Tampilkan semua properti (vertikal)
/interface print detail where name="ether1"

# Pilih kolom yang ingin ditampilkan
/ppp active print proplist=name,address,uptime

# Hitung jumlah item tanpa tampilkan data
/ppp active print count-only
/ip dhcp-server lease print count-only where status="bound"
```

Nama kolom yang valid bisa dilihat dari output `print detail` atau dengan `Tab` setelah `proplist=`.

---

### monitor & follow

`monitor` untuk data real-time — tekan `q` untuk keluar. Tambahkan `once` untuk snapshot sekali:

```
/interface monitor-traffic ether1
/interface monitor-traffic ether1 once
/system resource monitor once
```

`follow` khusus untuk log — mirip `tail -f`:

```
/log print follow where message~="pppoe"
```

Tekan `Ctrl+C` untuk keluar.

---

### export — Lihat konfigurasi

Menampilkan konfigurasi dalam format teks, tidak mengubah apapun:

```
/ip address export
/ip firewall filter export
/export
```

Berguna untuk audit dan backup.

---

## 1. Status Interface (Up/Down)

```
/interface print
/interface print where running=yes
/interface print where running=no
```

Kolom yang diperhatikan: `NAME`, `TYPE`, `RUNNING`, `DISABLED`.
Interface dengan tanda `R` = running (up), tanpa `R` = down.

---

## 2. Redaman SFP (Optical Level)

```
/interface ethernet monitor [find name~"sfp"]
/interface ethernet monitor sfp-sfpplus1 once
```

Kolom yang diperhatikan:

- `sfp-rx-power` — sinyal masuk (dBm), normal antara **-8 sampai -24 dBm**
- `sfp-tx-power` — sinyal keluar (dBm)
- `sfp-temperature` — suhu modul

Jika `sfp-rx-power` di bawah -27 dBm atau `no-signal`, indikasi redaman tinggi atau kabel putus.

---

## 3. Mencari Interface dengan Operand Filter

Operand yang tersedia: `=` (sama persis), `!=` (tidak sama), `~=` (regex/contains).

```
# Exact match
/interface print where name="ether1"

# Not equal
/interface print where type!="ether"

# Contains (regex)
/interface print where name~="sfp"
/interface print where comment~="pelanggan"
/interface print where name~="pppoe"
```

Operand `~=` berlaku untuk string dan bisa dikombinasikan:

```
/interface print where running=yes name~="sfp"
```

---

## 4. IP Address pada Interface

```
/ip address print where interface="ether1"
/ip address print where interface~="pppoe"
```

Untuk melihat semua IP beserta interface-nya:

```
/ip address print detail
```

---

## 5. Log Up/Down/Connected/Disconnected Interface

```
/log print where topics~"interface"
/log print where message~"up" topics~"interface"
/log print where message~"down" topics~"interface"
/log print where message~"pppoe"
/log print where message~"connected"
/log print where message~"disconnected"
```

Untuk melihat log pada interface tertentu:

```
/log print where message~"ether1"
```

Filter proplist agar lebih ringkas:

```
/log print where topics~"interface" proplist=time,topics,message
```

---

## 6. Traffic Interface (Real-time)

```
/interface monitor-traffic ether1
/interface monitor-traffic sfp-sfpplus1,ether1
```

Tekan `q` untuk keluar. Kolom: `rx-bits-per-second`, `tx-bits-per-second`, `rx-packets-per-second`, `tx-packets-per-second`.

Snapshot sekali (non-interactive):

```
/interface monitor-traffic ether1 once
```

---

## 7. Detail PPPoE

Melihat sesi PPPoE aktif:

```
/ppp active print
/ppp active print detail
```

Filter per nama user atau caller ID:

```
/ppp active print where name~="pelanggan"
/ppp active print where caller-id~="192.168"
```

Kolom yang diperhatikan: `NAME`, `SERVICE`, `CALLER-ID`, `ADDRESS`, `UPTIME`, `ENCODING`.

Melihat profil PPPoE:

```
/ppp profile print
```

---

## 8. DHCP Leases

```
/ip dhcp-server lease print
/ip dhcp-server lease print where status="bound"
/ip dhcp-server lease print where address="192.168.1.100"
/ip dhcp-server lease print where mac-address="AA:BB:CC:DD:EE:FF"
/ip dhcp-server lease print where host-name~="android"
```

Kolom: `ADDRESS`, `MAC-ADDRESS`, `HOST-NAME`, `SERVER`, `STATUS`, `EXPIRES-AFTER`.

---

## 9. ARP Table

Mengecek device yang terkoneksi di layer 2:

```
/ip arp print
/ip arp print where interface="ether1"
/ip arp print where address="192.168.1.100"
/ip arp print where mac-address~="AA:BB"
```

Entry tanpa MAC address (status `incomplete`) berarti device tidak merespons ARP.

---

## 10. Simple Queue (Bandwidth Pelanggan)

```
/queue simple print
/queue simple print where name~="pelanggan"
/queue simple print where target="192.168.1.100/32"
```

Monitor traffic queue secara real-time:

```
/queue simple monitor [find name~="pelanggan"]
```

Kolom: `NAME`, `TARGET`, `MAX-LIMIT` (rx/tx), `BURST-LIMIT`.

---

## 11. Ping & Traceroute dari Router

```
/tool ping address=8.8.8.8 count=4
/tool ping address=192.168.1.1 interface=ether1 count=4
/tool ping address=8.8.8.8 src-address=10.0.0.1 count=4
```

```
/tool traceroute address=8.8.8.8
/tool traceroute address=8.8.8.8 src-address=10.0.0.1
```

---

## 12. Resource Router (CPU, RAM, Uptime)

```
/system resource print
```

Kolom penting:

- `uptime` — sudah berapa lama router menyala
- `cpu-load` — persentase penggunaan CPU (normal < 80%)
- `free-memory` — RAM tersisa
- `free-hdd-space` — storage tersisa

---

## 13. Bridge & Bridge Port Status

Melihat bridge yang ada:

```
/interface bridge print
```

Melihat port yang tergabung dalam bridge:

```
/interface bridge port print
/interface bridge port print where bridge="bridge1"
/interface bridge port print where interface~="ether"
```

Kolom: `INTERFACE`, `BRIDGE`, `STATE` (forwarding/learning/disabled).

MAC address table bridge:

```
/interface bridge host print where bridge="bridge1"
/interface bridge host print where mac-address~="AA:BB"
```

---

## 14. BGP / OSPF Neighbor (Jalur Upstream)

**BGP:**

```
/routing bgp peer print
/routing bgp peer print where state!="established"
```

Kolom: `NAME`, `REMOTE-ADDRESS`, `STATE`, `UPTIME`, `PREFIX-COUNT`.
State normal: `established`. Selain itu berarti ada masalah koneksi ke upstream.

**OSPF:**

```
/routing ospf neighbor print
/routing ospf neighbor print where state!="Full"
```

State normal: `Full`. State `Init` atau `2-Way` berarti adjacency belum terbentuk sempurna.

---

## 15. Neighbor di Interface Tertentu (LLDP/MNDP)

MikroTik menggunakan MNDP (MikroTik Neighbor Discovery Protocol) dan mendukung LLDP/CDP.

Melihat semua neighbor yang terdeteksi:

```
/ip neighbor print
/ip neighbor print detail
```

Filter per interface:

```
/ip neighbor print where interface="ether1"
/ip neighbor print where interface~="sfp"
```

Kolom yang diperhatikan:

- `INTERFACE` — port tempat neighbor terdeteksi
- `IDENTITY` — nama device neighbor
- `ADDRESS` — IP neighbor
- `MAC-ADDRESS` — MAC neighbor
- `PLATFORM` — jenis device (MikroTik, Cisco, dll)
- `VERSION` — versi RouterOS jika sesama MikroTik

Berguna untuk verifikasi topologi fisik dan memastikan device yang terhubung sesuai ekspektasi.

---

## Tips Umum

- Tambahkan `detail` untuk informasi lengkap: `/interface print detail`
- Tambahkan `proplist=name,running` untuk pilih kolom spesifik
- Kombinasikan filter: `where running=yes name~="sfp"`
- Semua perintah di atas tidak mengubah konfigurasi (read-only)

---

## Tugas Latihan

Tugas ini dikerjakan langsung di router. Setiap tugas ada pertanyaan yang jawabannya harus kamu tulis — jawaban itu yang nantinya jadi dokumentasi kamu sendiri.

Tidak ada jawaban yang diberikan di sini. Eksplorasi, coba, dan catat apa yang kamu temukan.

---

### Tahap 1 — Navigasi dan print

**T1.1** — Jalankan `/interface print` di router.

- Ada berapa interface yang tersedia?
- Flags apa saja yang muncul di kolom kiri? Apa artinya masing-masing?
- Interface mana yang sedang running, mana yang tidak?

**T1.2** — Coba `/interface print detail` pada satu interface yang running.

- Properti apa saja yang muncul tapi tidak terlihat di tampilan tabel biasa?
- Pilih 3 properti yang menurut kamu paling relevan untuk monitoring harian. Catat alasannya.

**T1.3** — Jalankan `/system resource print`.

- Catat nilai `uptime`, `cpu-load`, dan `free-memory` saat ini.
- Apa yang terjadi kalau `cpu-load` terus di atas 90%? Cari tahu sendiri.

---

### Tahap 2 — Filter dengan where dan operator

**T2.1** — Tampilkan hanya interface yang sedang **tidak** running.

- Berapa jumlahnya? Apakah wajar atau perlu investigasi?

**T2.2** — Filter log untuk melihat event koneksi/diskoneksi dalam 1 jam terakhir.

- Perintah apa yang kamu pakai?
- Ada pola yang mencurigakan? Misalnya interface yang flapping?

**T2.3** — Coba operator `~=` untuk mencari interface atau queue berdasarkan sebagian nama.

- Tulis perintah yang kamu buat dan apa hasilnya.
- Apa bedanya `~=` dan `=`? Tulis dengan kata-katamu sendiri.

---

### Tahap 3 — find, get, dan bracket

**T3.1** — Gunakan `find` untuk mencari index interface yang running.

- Berapa angka index yang muncul?
- Sekarang gunakan index itu di `get` untuk ambil nilai `name` dan `mac-address`. Catat perintahnya.

**T3.2** — Ambil nilai `uptime` dari PPPoE session yang sedang aktif menggunakan kombinasi `get` dan `find`.

- Kalau tidak ada PPPoE session, coba di bagian lain — misalnya DHCP lease.
- Kapan `get` lebih berguna dibanding `print`? Tulis pendapatmu.

**T3.3** — Gunakan bracket `[ ]` untuk memonitor traffic interface berdasarkan namanya, bukan index-nya.

- Tulis perintah lengkap yang kamu pakai.

---

### Tahap 4 — proplist dan count-only

**T4.1** — Tampilkan daftar PPPoE session aktif, tapi hanya kolom `name`, `address`, dan `uptime`.

- Perintah apa yang kamu pakai?
- Kapan `proplist` lebih berguna dibanding `print` biasa?

**T4.2** — Hitung berapa DHCP lease yang berstatus `bound` saat ini menggunakan `count-only`.

- Berapa angkanya?
- Sekarang coba tanpa filter — berapa total lease yang ada? Apa bedanya?

---

### Tahap 5 — monitor, follow, export

**T5.1** — Monitor traffic salah satu interface selama 30 detik.

- Catat rata-rata `rx-bits-per-second` dan `tx-bits-per-second`.
- Interface mana yang paling banyak traffic? Masuk akal tidak dengan topologi yang ada?

**T5.2** — Gunakan `follow` untuk memantau log PPPoE secara live.

- Biarkan berjalan 1-2 menit. Ada event apa yang muncul?
- Kalau tidak ada event, coba follow log tanpa filter dulu. Catat topics apa saja yang aktif.

**T5.3** — Jalankan `export` pada salah satu menu (misalnya `/ip address export`).

- Salin output-nya. Format ini berguna untuk apa?
- Coba bandingkan output `export` dengan `print detail`. Apa perbedaannya?

---
