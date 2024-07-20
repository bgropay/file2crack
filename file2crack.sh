#!/bin/bash
#--------------------------------------------------
# EHF (Ekstrak Hash File)
#
# EHF adalah sebuah program bash sederhana yang dirancang
# untuk mengekstrak hash file ZIP, RAR, 7z, PDF, Office
# (docx, xlsx, pptx)
#
# Dibuat oleh bgropay
#--------------------------------------------------
# PERINGATAN
#
# Program ini dibuat hanya untuk tujuan edukasi dan
# pembelajaran saja. Tidak ada niatan atau maksud
# mendorong kegiatan ilegal atau kegiatan yang
# melanggar hukum.
#
# Gunakan program ini pada file yang Anda miliki.
# Jangan gunakan pada file orang lain OKE :)
#--------------------------------------------------

# var warna
c="\e[1;36m" # warna cyan
r="\e[0m"    # reset
m="\e[1;31m" # warna merah
p="\e[1;37m" # warna putih
h="\e[1;32m" # warna hijau
b="\e[1;34m" # warna biru
k="\e[1;33m" # warna kuning

# daftar menu yang tersedia
daftar_menu=(
	"Keluar"
	"Ekstrak hash file ZIP"
	"Ekstrak hash file RAR"
	"Ekstrak hash file 7z"
	"Ekstrak hash file PDF"
	"Ekstrak hash file Offcie (docx, xlsx, pptx)"
	"Tentang"
)

while true; do

	# membersihkan layar terminmal
	clear

	# waktu saat ini
	waktu=$(date +"%d-%m-%Y %H:%M:%S")

	# konter angka anggota list
	n=0

	# menampilkan waktu saat ini dan menu
	echo -e "${p}[${h}${waktu}${p}] [${c}Ekstrak Hash File${p}]${r}"
	echo ""
	echo -e "${k}Daftar menu yang tersedia:${r}"
	echo ""

	for menu in "${daftar_menu[@]}"; do
		echo -e "${p}[${k}${n}${p}] ${menu}${r}"
		((n+=1))
	done

	echo ""

	read -p $'\e[1;37mPilih menu: \e[1;33m' pilih_menu
	if [[ -z "${pilih_menu}" ]]; then
		echo -e "${m}[-] ${p}Menu tidak boleh kosong. Silahkan pilih kembali..${r}"
		echo ""
		read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk kembali ke menu utama.\e[0m'
		continue

	elif [[ "${pilih_menu}" == "0" ]]; then
		exit 0
	elif [[ "${pilih_menu}" == "1" ]]; then
		# memasukkan nama file zip
		while true; do
			read -p $'\e[1;37mMasukkan nama file ZIP: \e[1;33m' nama_file_zip

			# kondisi jika nama file zip kosong
			if [[ -z "${nama_file_zip}" ]]; then
				echo -e "${m}[-] ${p}Nama file ZIP tidak boleh kosong.${r}"
				continue
			fi

			# kondisi jika file zip tidak ditemukan
			if [[ ! -f "${nama_file_zip}" ]]; then
				echo -e "${m}[-] ${p}File ZIP '${nama_file_zip}' tidak ditemukan.${r}"
				continue
			fi

			# kondisi jika file bukan file zip
			if [[ "${nama_file_zip##*.}" != "zip" ]]; then
				echo -e "${m}[-] ${p}File '${nama_file_zip}' bukan file ZIP.${r}"
				continue
			fi

			# kondisi jika file zip ditemukan
			echo ""
			echo -e "${h}[+] ${p}File ZIP '${nama_file_zip}' ditemukan.${r}"

			# mengekstrak hash file zip ke format john
			echo -e "${b}[*] ${p}Mengekstrak hash file ZIP '${nama_file_zip}' ke format John ...${r}"
			sleep 3
			hash_file_zip_john=$(zip2john "${nama_file_zip}" 2>/dev/null)
			nama_file_hash_file_zip_john="${nama_file_zip}.john"
			echo "${hash_file_zip_john}" > "${nama_file_hash_file_zip_john}"

			# kondisi jika isi file hash file zip john kosong
			if [[ -z "${nama_file_hash_file_zip_john}" ]]; then
				echo -e "${m}[-] ${p}Gagal mengekstrak hash file ZIP '${nama_file_zip}' ke format John.${r}"
				exit 1
			# kondisi jika isi file hash file zip john tidak kosong
			else
				echo -e "${h}[+] ${p}Berhasil mengekstrak hash file ZIP '${nama_file_zip}' ke format John.${r}"
			fi

			# mengekstrak hash file zip ke format hashcat
			echo -e "${b}[*] ${p}Mengekstrak hash file ZIP '${nama_file_zip}' ke format Hashcat${i}${r}"
			sleep 3
			hash_file_zip_hashcat=$(zip2john "${nama_file_zip}" 2>/dev/null | cut -d ":" -f 2 | tr -d "[:space:]")
			nama_file_hash_file_zip_hashcat="${nama_file_zip}.hashcat"
			echo "${hash_file_zip_hashcat}" > "${nama_file_hash_file_zip_hashcat}"

			# kondisi jika isi file hash file zip hashcat kosong
			if [[ -z "${nama_file_hash_file_zip_hashcat}" ]]; then
				echo -e "${m}[-] ${p}Gagal mengekstrak hash file ZIP '${nama_file_zip}' ke format Hashcat.${r}"
				exit 1

			# kondisi jika isi file hash file zip hashcat tidak kosong
			else
				echo -e "${h}[+] ${p}Berhasil mengekstrak hash file ZIP '${nama_file_zip}' ke format Hashcat.${r}"
			fi
			echo ""
			read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk kembali ke menu utama.\e[0m'
			break
		done
	elif [[ "${pilih_menu}" == "2" ]]; then
		# memasukkan nama file rar
		while true; do
			read -p $'\e[1;37mMasukkan nama file RAR: \e[1;33m' nama_file_rar

			# kondisi jika nama file rar kosong
			if [[ -z "${nama_file_rar}" ]]; then
				echo -e "${m}[-] ${p}Nama file RAR tidak boleh kosong.${r}"
				continue
			fi

			# kondisi jika file rar tidak ditemukan
			if [[ ! -f "${nama_file_rar}" ]]; then
				echo -e "${m}[-] ${p}File RAR '${nama_file_rar}' tidak ditemukan.${r}"
				continue
			fi

			# kondisi jika file bukan file rar
			if [[ "${nama_file_rar##*.}" != "rar" ]]; then
				echo -e "${m}[-] ${p}File '${nama_file_rar}' bukan file RAR.${r}"
				continue
			fi

			# kondisi jika file rar ditemukan
			echo ""
			echo -e "${h}[+] ${p}File RAR '${nama_file_rar}' ditemukan.${r}"

			# mengekstrak hash file rar ke format john
			echo -e "${b}[*] ${p}Mengekstrak hash file RAR '${nama_file_rar}' ke format John ...${r}"
			sleep 3
			hash_file_rar_john=$(rar2john "${nama_file_rar}" 2>/dev/null)
			nama_file_hash_file_rar_john="${nama_file_rar}.john"
			echo "${hash_file_rar_john}" > "${nama_file_hash_file_rar_john}"

			# kondisi jika isi file hash file rar john kosong
			if [[ -z "${nama_file_hash_file_rar_john}" ]]; then
				echo -e "${m}[-] ${p}Gagal mengekstrak hash file RAR '${nama_file_rar}' ke format John.${r}"
				exit 1
			# kondisi jika isi file hash file rar john tidak kosong
			else
				echo -e "${h}[+] ${p}Berhasil mengekstrak hash file RAR '${nama_file_rar}' ke format John.${r}"
			fi

			# mengekstrak hash file rar ke format hashcat
			echo -e "${b}[*] ${p}Mengekstrak hash file RAR '${nama_file_rar}' ke format Hashcat ...${r}"
			sleep 3
			hash_file_rar_hashcat=$(rar2john "${nama_file_rar}" 2>/dev/null | cut -d ":" -f 2 | tr -d "[:space:]")
			nama_file_hash_file_rar_hashcat="${nama_file_rar}.hashcat"
			echo "${hash_file_rar_hashcat}" > "${nama_file_hash_file_rar_hashcat}"

			# kondisi jika isi file hash file rar hashcat kosong
			if [[ -z "${nama_file_hash_file_rar_hashcat}" ]]; then
				echo -e "${m}[-] ${p}Gagal mengekstrak hash file RAR '${nama_file_rar}' ke format Hashcat.${r}"
				exit 1

			# kondisi jika isi file hash file rar hashcat tidak kosong
			else
				echo -e "${h}[+] ${p}Berhasil mengekstrak hash file RAR '${nama_file_rar}' ke format Hashcat.${r}"
			fi
			echo ""
			read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk kembali ke menu utama.\e[0m'
			break
		done
	elif [[ "${pilih_menu}" == "3" ]]; then
		# memasukkan nama file 7z
		while true; do
			read -p $'\e[1;37mMasukkan nama file 7z: \e[1;33m' nama_file_7z

			# kondisi jika nama file 7z kosong
			if [[ -z "${nama_file_7z}" ]]; then
				echo -e "${m}[-] ${p}Nama file 7z tidak boleh kosong.${r}"
				continue
			fi

			# kondisi jika file 7z tidak ditemukan
			if [[ ! -f "${nama_file_7z}" ]]; then
				echo -e "${m}[-] ${p}File 7z '${nama_file_7z}' tidak ditemukan.${r}"
				continue
			fi

			# kondisi jika file bukan file 7z
			if [[ "${nama_file_7z##*.}" != "7z" ]]; then
				echo -e "${m}[-] ${p}File '${nama_file_7z}' bukan file 7z.${r}"
				continue
			fi

			# kondisi jika file 7z ditemukan
			echo ""
			echo -e "${h}[+] ${p}File 7z '${nama_file_7z}' ditemukan.${r}"

			# mengekstrak hash file 7z ke format john
			echo -e "${b}[*] ${p}Mengekstrak hash file 7z '${nama_file_7z}' ke format John ...${r}"
			sleep 3
			hash_file_7z_john=$(7z2john "${nama_file_7z}" 2>/dev/null)
			nama_file_hash_file_7z_john="${nama_file_7z}.john"
			echo "${hash_file_7z_john}" > "${nama_file_hash_file_7z_john}"

			# kondisi jika isi file hash file 7z john kosong
			if [[ -z "${nama_file_hash_file_7z_john}" ]]; then
				echo -e "${m}[-] ${p}Gagal mengekstrak hash file 7z '${nama_file_7z}' ke format John.${r}"
				exit 1
			# kondisi jika isi file hash file 7z john tidak kosong
			else
				echo -e "${h}[+] ${p}Berhasil mengekstrak hash file 7z '${nama_file_7z}' ke format John.${r}"
			fi

			# mengekstrak hash file 7z ke format hashcat
			echo -e "${b}[*] ${p}Mengekstrak hash file 7z '${nama_file_7z}' ke format Hashcat ...${r}"
			sleep 3
			hash_file_7z_hashcat=$(7z2john "${nama_file_7z}" 2>/dev/null | cut -d ":" -f 2 | tr -d "[:space:]")
			nama_file_hash_file_7z_hashcat="${nama_file_7z}.hashcat"
			echo "${hash_file_7z_hashcat}" > "${nama_file_hash_file_7z_hashcat}"

			# kondisi jika isi file hash file 7z hashcat kosong
			if [[ -z "${nama_file_hash_file_7z_hashcat}" ]]; then
				echo -e "${m}[-] ${p}Gagal mengekstrak hash file 7z '${nama_file_7z}' ke format Hashcat.${r}"
				exit 1

			# kondisi jika isi file hash file 7z hashcat tidak kosong
			else
				echo -e "${h}[+] ${p}Berhasil mengekstrak hash file 7z '${nama_file_7z}' ke format Hashcat.${r}"
			fi
			echo ""
			read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk kembali ke menu utama.\e[0m'
			break
		done
	elif [[ "${pilih_menu}" == "4" ]]; then
		# memasukkan nama file pdf
		while true; do
			read -p $'\e[1;37mMasukkan nama file PDF: \e[1;33m' nama_file_pdf

			# kondisi jika nama file pdf kosong
			if [[ -z "${nama_file_pdf}" ]]; then
				echo -e "${m}[-] ${p}Nama file PDF tidak boleh kosong.${r}"
				continue
			fi

			# kondisi jika file pdf tidak ditemukan
			if [[ ! -f "${nama_file_pdf}" ]]; then
				echo -e "${m}[-] ${p}File PDF '${nama_file_pdf}' tidak ditemukan.${r}"
				continue
			fi

			# kondisi jika file bukan file pdf
			if [[ "${nama_file_pdf##*.}" != "pdf" ]]; then
				echo -e "${m}[-] ${p}File '${nama_file_pdf}' bukan file PDF.${r}"
				continue
			fi

			# kondisi jika file pdf ditemukan
			echo ""
			echo -e "${h}[+] ${p}File PDF '${nama_file_pdf}' ditemukan.${r}"

			# mengekstrak hash file pdf ke format john
			echo -e "${b}[*] ${p}Mengekstrak hash file PDF '${nama_file_pdf}' ke format John ...${r}"
			sleep 3
			hash_file_pdf_john=$(pdf2john "${nama_file_pdf}" 2>/dev/null)
			nama_file_hash_file_pdf_john="${nama_file_pdf}.john"
			echo "${hash_file_pdf_john}" > "${nama_file_hash_file_pdf_john}"

			# kondisi jika isi file hash file pdf john kosong
			if [[ -z "${nama_file_hash_file_pdf_john}" ]]; then
				echo -e "${m}[-] ${p}Gagal mengekstrak hash file PDF '${nama_file_pdf}' ke format John.${r}"
				exit 1
			# kondisi jika isi file hash file pdf john tidak kosong
			else
				echo -e "${h}[+] ${p}Berhasil mengekstrak hash file PDF '${nama_file_pdf}' ke format John.${r}"
			fi

			# mengekstrak hash file pdf ke format hashcat
			echo -e "${b}[*] ${p}Mengekstrak hash file PDF '${nama_file_pdf}' ke format Hashcat ...${r}"
			sleep 3
			hash_file_pdf_hashcat=$(pdf2john "${nama_file_pdf}" 2>/dev/null | cut -d ":" -f 2 | tr -d "[:space:]")
			nama_file_hash_file_pdf_hashcat="${nama_file_pdf}.hashcat"
			echo "${hash_file_pdf_hashcat}" > "${nama_file_hash_file_pdf_hashcat}"

			# kondisi jika isi file hash file pdf hashcat kosong
			if [[ -z "${nama_file_hash_file_pdf_hashcat}" ]]; then
				echo -e "${m}[-] ${p}Gagal mengekstrak hash file PDF '${nama_file_pdf}' ke format Hashcat.${r}"
				exit 1

			# kondisi jika isi file hash file pdf hashcat tidak kosong
			else
				echo -e "${h}[+] ${p}Berhasil mengekstrak hash file PDF '${nama_file_pdf}' ke format Hashcat.${r}"
			fi
			echo ""
			read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk kembali ke menu utama.\e[0m'
			break
		done
	elif [[ "${pilih_menu}" == "5" ]]; then
		# memasukkan nama file office
		while true; do
			read -p $'\e[1;37mMasukkan nama file Office (docx, xlsx, pptx): \e[1;33m' nama_file_office

			# kondisi jika nama file office kosong
			if [[ -z "${nama_file_office}" ]]; then
				echo -e "${m}[-] ${p}Nama file Oficce tidak boleh kosong.${r}"
				continue
			fi

			# kondisi jika file office tidak ditemukan
			if [[ ! -f "${nama_file_office}" ]]; then
				echo -e "${m}[-] ${p}File Office '${nama_file_office}' tidak ditemukan.${r}"
				continue
			fi

			# kondisi jika file bukan file office
			if [[ "${nama_file_office##*.}" != "docx" || "${nama_file_office##*.}" != "xlsx" || "${nama_file_office##*.}" != "pptx" ]]; then
				echo -e "${m}[-] ${p}File '${nama_file_office}' bukan file Office.${r}"
				continue
			fi

			# kondisi jika file office ditemukan
			echo ""
			echo -e "${h}[+] ${p}File Office '${nama_file_office}' ditemukan.${r}"

			# mengekstrak hash file office ke format john
			echo -e "${b}[*] ${p}Mengekstrak hash file Office '${nama_file_office}' ke format John ...${r}"
			sleep 3
			hash_file_office_john=$(office2john "${nama_file_office}" 2>/dev/null)
			nama_file_hash_file_office_john="${nama_file_office}.john"
			echo "${hash_file_office_john}" > "${nama_file_hash_file_office_john}"

			# kondisi jika isi file hash file office john kosong
			if [[ -z "${nama_file_hash_file_office_john}" ]]; then
				echo -e "${m}[-] ${p}Gagal mengekstrak hash file Office '${nama_file_office}' ke format John.${r}"
				exit 1
			# kondisi jika isi file hash file office john tidak kosong
			else
				echo -e "${h}[+] ${p}Berhasil mengekstrak hash file Office '${nama_file_office}' ke format John.${r}"
			fi

			# mengekstrak hash file office ke format hashcat
			echo -e "${b}[*] ${p}Mengekstrak hash file Office '${nama_file_office}' ke format Hashcat ...${r}"
			sleep 3
			hash_file_office_hashcat=$(office2john "${nama_file_office}" 2>/dev/null | cut -d ":" -f 2 | tr -d "[:space:]")
			nama_file_hash_file_office_hashcat="${nama_file_office}.hashcat"
			echo "${hash_file_office_hashcat}" > "${nama_file_hash_file_office_hashcat}"

			# kondisi jika isi file hash file office hashcat kosong
			if [[ -z "${nama_file_hash_file_office_hashcat}" ]]; then
				echo -e "${m}[-] ${p}Gagal mengekstrak hash file Office '${nama_file_office}' ke format Hashcat.${r}"
				exit 1

			# kondisi jika isi file hash file office hashcat tidak kosong
			else
				echo -e "${h}[+] ${p}Berhasil mengekstrak hash file Office '${nama_file_office}' ke format Hashcat.${r}"
			fi
			echo ""
			read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk kembali ke menu utama.\e[0m'
			break
		done
	else
		echo -e "${m}[-] ${p}Menu '${pilih_menu}' tidak tersedia. Silahkan pilih kembali..${r}"
		echo ""
		read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk kembali ke menu utama.\e[0m'
		continue
	fi
done
