# Panduan Menulis Dokumentasi MikroTik

Panduan ini menjelaskan cara menulis, mengelompokkan, dan menyusun dokumentasi MikroTik.
Bukan tentang apa yang harus didokumentasikan — itu ada di masing-masing section scope.

---

## Prinsip Dasar

Dokumentasi yang baik menjawab tiga pertanyaan:

1. Apa yang dilakukan perintah/fitur ini?
2. Kapan dan kenapa digunakan?
3. Apa yang harus diperhatikan dari hasilnya?

Jangan hanya menyalin perintah tanpa penjelasan. NOC yang membaca harus bisa langsung eksekusi tanpa tanya-tanya.

---

## Scope dan Akses

Setiap file dokumentasi harus jelas scope-nya — tulis di baris pertama file.

| Scope                | Siapa yang boleh menulis      | Siapa yang boleh eksekusi     |
| -------------------- | ----------------------------- | ----------------------------- |
| Read-Only            | Junior NOC (setelah training) | Semua NOC                     |
| Konfigurasi Dasar    | Junior NOC dengan supervisi   | Junior dengan approval senior |
| Konfigurasi Lanjutan | Senior NOC                    | Senior NOC                    |

Jangan campur scope dalam satu section. Kalau satu topik punya bagian read-only dan bagian konfigurasi, pisah section-nya dengan heading yang jelas.

---

## Struktur Dokumen

Dokumentasi ditulis dalam **satu file per device/platform** menggunakan header level sebagai navigasi. Tujuannya agar NOC bisa pakai text search (`Ctrl+F` atau `grep`) tanpa perlu tahu ada di file mana.

Hierarki header:

```
# Judul Dokumen          ← H1: satu per file
## Scope                 ← H2: Read-Only / Konfigurasi Dasar / Konfigurasi Lanjutan
### Kelompok Topik       ← H3: Interface / PPPoE / DHCP / Routing / dst
#### Topik Spesifik      ← H4: jika kelompok perlu dipecah lebih dalam
```

Contoh struktur:

```
# MikroTik NOC

## Scope 1: Read-Only
### Interface
### PPPoE
### DHCP
### Routing

## Scope 2: Konfigurasi Dasar
### Tambah User PPPoE
### Buat Simple Queue
```

Urutan dalam satu kelompok topik: dari yang **paling sering dipakai** ke yang jarang, atau dari yang **paling sederhana** ke kompleks.

---

## Format Penulisan

### Struktur Satu Section

```
## [Nomor]. [Judul Topik]

[Satu kalimat: apa fungsinya dan kapan dipakai]

[Blok kode]

[Penjelasan output: kolom apa yang diperhatikan dan artinya]

[Nilai normal/abnormal jika relevan]
```

### Heading

Ikuti hierarki H1–H4 seperti di bagian Struktur Dokumen. Beri nomor urut pada topik spesifik — memudahkan komunikasi ("lihat bagian 7").

### Blok Kode

Selalu gunakan fenced code block. Jangan campur perintah dan output dalam satu blok.

Gunakan `#` untuk komentar konteks di dalam blok:

```
# Semua sesi aktif
/ppp active print

# Filter per username
/ppp active print where name~="pelanggan"
```

### Penjelasan Output

Fokus pada kolom yang perlu diinterpretasi, bukan semua kolom. Gunakan format bullet:

```
Kolom yang diperhatikan:
- `STATUS` — `bound` artinya IP sudah diberikan, `waiting` artinya belum ada device
- `EXPIRES-AFTER` — sisa waktu lease sebelum expired
```

Untuk output yang ada nilai threshold, tulis eksplisit:

```
Normal: -8 sampai -24 dBm
Waspada: di bawah -25 dBm
Kritis: di bawah -27 dBm atau no-signal
```

---

## Aturan Bahasa

- Tulis dalam Bahasa Indonesia yang jelas
- Istilah teknis tetap dalam Bahasa Inggris (`interface`, `uptime`, `routing`)
- Kalimat pendek dan langsung
- Formal tapi tidak kaku — hindari "sangat", "sekali", "banget"

---

## Contoh: Kurang Baik vs Baik

**Kurang baik** — tidak ada konteks, tidak ada penjelasan output:

```
## Queue
/queue simple print
```

**Baik** — ada konteks, ada penjelasan kolom yang perlu dibaca:

```
## 10. Simple Queue (Bandwidth Pelanggan)

Mengecek batas bandwidth yang dikonfigurasi untuk suatu IP pelanggan.

/queue simple print where target="192.168.1.100/32"

Kolom yang diperhatikan:
- `MAX-LIMIT` — batas upload/download (format: upload/download)
- `BURST-LIMIT` — batas saat burst aktif
- `TARGET` — IP atau subnet yang diatur queue-nya
```

---

## Cara Berkontribusi

1. Tambahkan section baru di bawah heading scope yang sesuai
2. Ikuti format di atas — minimal penjelasan fungsi, blok kode, dan keterangan output
3. Test semua perintah sebelum commit
4. Minta review senior NOC sebelum merge ke `main`
