# LAPORAN PRAKTIKUM MODUL-1 #
## Praktikum Sistem Operasi Kelompok IT16 ##

| Nama | NRP       |
|-------|-----------|
| Ahmad Syauqi Reza | 5027241085   |
| Mochammad Atha Tajuddin   | 5027241093  |
| Tiara Fatimah Azzahra   | 5027241090  |
---


### Soal_1 ###
1. Untuk soal ini kita menggunakan awk untuk menganalisis file bernama reading_data.csv. Mulai dari analisis berapa banyak buku yang dibaca oleh “Chris Hemsworth”, berapa lama rata-rata mereka membaca dengan benda ini, mencari siapa yang memberikan rating tertinggi untuk buku yang dibaca (Rating) beserta nama (Name) dan judul bukunya (Book_Title), dan genre apa yang paling populer di sana setelah tahun 2023. dengan catatan Seluruh command dimasukkan kedalam 1 file dan gunakan kondisi if else untuk setiap soalnya.
untuk soal tersebut pertama kita perlu buat file dengan mengetik “nano script” dan mengisi nano script tersebut menggunakan kode berikut 

![1t](https://github.com/user-attachments/assets/685e8f10-eb0d-4f3f-84bf-91d6669d51a8)

![2t](https://github.com/user-attachments/assets/260b33b7-3ac5-4a1e-98c0-b5ba78a6dbca)

2. setelah di isi kita perlu simpan dengan cara ketik “control + x” terus “Y” dan “Enter”

![3t](https://github.com/user-attachments/assets/29055091-b209-45ad-90df-eb83e92a1f5c)


3. sebelum menjalankan dan mengeksekusi program kita perlu melakukan perizinan terlebih dahulu dengan mengetik “chmod +x script” lalu bisa kita jalankan dengan mengetik “awk -f script reading_data.csv” dan output akan muncul seperti yang digambar









### Soal_2 ###


1. Buat folder serta script2 yang dibutuhkan sesuai petunjuk soal
untuk itu kita bisa menggunakan basic command linux seperti mkdir,chown,chmod,nano,vim dsb. Logic dasarnya ialah kita diperintahkan untuk membuat database yang nantinya berisikan file player.csv yang nanti akan digunakan sebagai tempat penyimpanan email,password, serta username dari user yang melakukan register. Pada kasus ini kita bisa menggunakan editor file apa saja untuk membuat file register/login sh, umumnya bisa menggunakan command touch,nano,vim,vi dsb.




2. Praktikan diminta untuk membuat sistem login dengan unique symbol seperti email pada umumnya “@”. Dalam kasus ini kita dapat menggunakan seperti regex dsj. Atau dapat menggunakan metode seperti contoh berikut : 
```
i="test@terraes" IFS="@" set -- $i if [ "${#@}" -ne 2 ];then echo "invalid email" fi domain="$2" dig $domain | grep "ANSWER: 0" 1>/dev/null && echo "domain not ok"
```
   Sehingga lebih memudahkan dan tidak perlu menggunakan regex yang rumit. 

![4t](https://github.com/user-attachments/assets/91ad1da8-290e-4593-a815-4f16ee8f4097)

![5t](https://github.com/user-attachments/assets/c75ea5c5-e04f-4698-8f41-f5c9c73067bf)

Sistem Validasi Password pada file register.sh

3. Praktikan diminta untuk membuat validasi email terhadap inputan, di mana logicnya ialah if $email_inputan_saat_regist ==database_player.csv. Maka ia akan me-return emal sudah tersedia/terdaftar. Pada kasus ini kita dapat menggunakan seperti redirection,ammend,tee, dsb, untuk nantinya data yang di input-kan oleh user divalidasi dengan yang ada pada database.

![6t](https://github.com/user-attachments/assets/785a90d7-91e0-40ea-9cc6-191f6f42ba08)

4. Kemudian, praktikan diminta untuk membuat enkripsi saat user meng-inputkan sandi untuk nantinya disimpan ke dalam database, hal ini mungkin jika suatu saat ini terjadi kebocoran sistem maka password dalam database masih berbasis enkripsi SHA256 SUM, sehingga memerlukan waktu bagi attacker/black hat untuk men-decrypt password tersebut dan login sebagai user korban/victim.

![7t](https://github.com/user-attachments/assets/c431a962-2108-42d3-b858-a2ccaa1ceb73)

![8t](https://github.com/user-attachments/assets/5409af60-8c8b-48ac-9c4a-1a5a2e3f65cc)

5. Praktikan diminta untuk membuat file yang berisikan cpu model device serta cpu & ram usage dari user nantinya.

![9t](https://github.com/user-attachments/assets/26b0328d-23aa-44c9-8075-30b05d10a698)

(Keterangan jam yang tertera pada os linux bukan jam basis GMT + 7)

![10t](https://github.com/user-attachments/assets/de5b6f2a-c6f9-4162-a4ba-555fe2bb1289)

di dalam pengerjaan ini ada beberapa command pendukung untuk melakukan validasi apakah script yang dibuat sudah sesuai atau belum, seperti mpstat,htop,top dsb.

6. Setelah semua dirasa sudah aman & clear, praktikan diminta untuk membuat interface sebagai tempat nantinya user berada alias seperti home page.

![11t](https://github.com/user-attachments/assets/32b61c20-3fc8-4fd9-a4a4-623e3d141301)

![12t](https://github.com/user-attachments/assets/7328e6e7-4614-46fb-98ff-718b2b641d3b)


Pada langkah ini kita membuat sebuah kode program shell kembali sebagai interface tempat user nantinya berada (Seperti home page)

A Few Source : 
- https://stackoverflow.com/questions/43518465/overall-cpu-usage-and-memoryram-usage-in-percentage-in-linux-ubuntu
- https://stackoverflow.com/questions/9229333/how-to-get-overall-cpu-usage-e-g-57-on-linux
- https://stackoverflow.com/questions/2138701/checking-correctness-of-an-email-address-with-a-regular-expression-in-bash
- https://unix.stackexchange.com/questions/174566/what-is-the-purpose-of-using-shift-in-shell-scripts


### Soal_3 ###

### Nomor 4 ###



#### E & F ####
Praktikan diminta untuk membuat error handling atau dapat disebut juga dengan exception handling, di mana fungsinya jika user memasukkan input tidak sesuai maka script akan me-return kekeliruan atau input yang tidak sesuai tersebut. 

![14t](https://github.com/user-attachments/assets/65ac2b41-7f7f-4edc-97e2-61aef306a537)

Contoh exception handlingnya.

Terakhir, praktikan diminta untuk membuat semacem manual book supaya user dapat menetahui apa saja kegunaan script yang dijalankan.

![13t](https://github.com/user-attachments/assets/f34f1d1a-6702-45d4-bc79-2e7c6d2db99e)


