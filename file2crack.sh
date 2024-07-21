#!/bin/bash
#--------------------------------------------------
# file2crack
#
# file2crack adalah sebuah program bash sederhana yang 
# dirancang untuk mengekstrak hash file ZIP, RAR, 7z, 
# PDF, Office (docx, xlsx, pptx).
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

# folder untuk menyimpan file hash
path="file_hash"

if [[ ! -d "${path}" ]]; then
        mkdir -p "${path}"
fi

# daftar menu yang tersedia
daftar_menu=(
	"Keluar"
	"Ekstrak hash file ZIP"
	"Ekstrak hash file RAR"
	"Ekstrak hash file 7z"
	"Ekstrak hash file PDF"
	"Ekstrak hash file Office (docx, xlsx, pptx)"
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
	echo -e "${p}[${h}${waktu}${p}] [${c}file2crack${p}]${r}"
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

                # cek alat zip2john
                if ! command -v zip2john >> /dev/null 2>&1; then
                        while true; do
                                read -p $'\e[1;37mMasukkan path ke jalur alat zip2john: \e[1;33m' cek_zip2john
	                        if [[ ! -f "${cek_zip2john}" ]]; then
                                        echo -e "${m}[-] ${p}Alat zip2john tidak ditemukan.${r}"
			                continue
                                else
		                        path_zip2john="${cek_zip2john}"
	                                break
                                fi
                        done
                else
                        path_zip2john="zip2john"
                fi

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
			hash_file_zip_john=$("${path_zip2john}" "${nama_file_zip}" 2>/dev/null)
                        base=$(basename "${nama_file_zip}")
			nama_file_hash_file_zip_john="${path}/${base}.john"
			echo "${hash_file_zip_john}" > "${nama_file_hash_file_zip_john}"

			if [[ -f "${nama_file_hash_file_zip_john}" ]]; then
				# kondisi jika isi file hash file zip john kosong
				if [[ -z "${nama_file_hash_file_zip_john}" ]]; then
					echo -e "${m}[-] ${p}Gagal mengekstrak hash file ZIP '${nama_file_zip}' ke format John.${r}"
					exit 1
				# kondisi jika isi file hash file zip john tidak kosong
				else
					echo -e "${h}[+] ${p}Berhasil mengekstrak hash file ZIP '${nama_file_zip}' ke format John.${r}"
				fi
			else
				echo -e "${m}[-] ${p}Gagal mengekstrak hash file ZIP '${nama_file_zip}' ke format John.${r}"
				exit 1
			fi

			# mengekstrak hash file zip ke format hashcat
			echo -e "${b}[*] ${p}Mengekstrak hash file ZIP '${nama_file_zip}' ke format Hashcat${i}${r}"
			sleep 3
			hash_file_zip_hashcat=$("${path_zip2john}" "${nama_file_zip}" 2>/dev/null | cut -d ":" -f 2 | tr -d "[:space:]")
                        base=$(basename "${nama_file_zip}")
			nama_file_hash_file_zip_hashcat="${path}/${base}.hashcat"
			echo "${hash_file_zip_hashcat}" > "${nama_file_hash_file_zip_hashcat}"

			if [[ -f "${nama_file_hash_file_zip_hashcat}" ]]; then
				# kondisi jika isi file hash file zip hashcat kosong
				if [[ -z "${nama_file_hash_file_zip_hashcat}" ]]; then
					echo -e "${m}[-] ${p}Gagal mengekstrak hash file ZIP '${nama_file_zip}' ke format Hashcat.${r}"
					exit 1
				# kondisi jika isi file hash file zip hashcat tidak kosong
				else
					echo -e "${h}[+] ${p}Berhasil mengekstrak hash file ZIP '${nama_file_zip}' ke format Hashcat.${r}"
				fi
			else
				echo -e "${m}[-] ${p}Gagal mengekstrak hash file ZIP '${nama_file_zip}' ke format Hashcat.${r}"
				exit 1
			fi

			echo ""
			read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk kembali ke menu utama.\e[0m'
			break
		done
	elif [[ "${pilih_menu}" == "2" ]]; then

                # cek alat rar2john
                if ! command -v rar2john >> /dev/null 2>&1; then
                        while true; do
                                read -p $'\e[1;37mMasukkan path ke jalur alat rar2john: \e[1;33m' cek_rar2john
	                        if [[ ! -f "${cek_rar2john}" ]]; then
                                        echo -e "${m}[-] ${p}Alat rar2john tidak ditemukan.${r}"
			                continue
                                else
		                        path_rar2john="${cek_rar2john}"
	                                break
                                fi
                        done
                else
                        path_rar2john="rar2john"
                fi

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
			hash_file_rar_john=$("${path_rar2john}" "${nama_file_rar}" 2>/dev/null)
                        base_rar_john=$(basename "${nama_file_rar}")
			nama_file_hash_file_rar_john="${path}/${base_rar_john}.john"
			echo "${hash_file_rar_john}" > "${nama_file_hash_file_rar_john}"

			if [[ -f "${nama_file_hash_file_rar_john}" ]]; then
				# kondisi jika isi file hash file rar john kosong
				if [[ -z "${nama_file_hash_file_rar_john}" ]]; then
					echo -e "${m}[-] ${p}Gagal mengekstrak hash file RAR '${nama_file_rar}' ke format John.${r}"
					exit 1
				# kondisi jika isi file hash file rar john tidak kosong
				else
					echo -e "${h}[+] ${p}Berhasil mengekstrak hash file RAR '${nama_file_rar}' ke format John.${r}"
				fi
			else
				echo -e "${m}[-] ${p}Gagal mengekstrak hash file RAR '${nama_file_rar}' ke format John.${r}"
				exit 1
			fi

			# mengekstrak hash file rar ke format hashcat
			echo -e "${b}[*] ${p}Mengekstrak hash file RAR '${nama_file_rar}' ke format Hashcat ...${r}"
			sleep 3
			hash_file_rar_hashcat=$("${path_rar2john}" "${nama_file_rar}" 2>/dev/null | cut -d ":" -f 2 | tr -d "[:space:]")
                        base_rar_hashcat=$(basename "${nama_file_rar}")
			nama_file_hash_file_rar_hashcat="${path}/${base_rar_hashcat}.hashcat"
			echo "${hash_file_rar_hashcat}" > "${nama_file_hash_file_rar_hashcat}"

			if [[ -f "${nama_file_hash_file_rar_hashcat}" ]]; then
				# kondisi jika isi file hash file rar hashcat kosong
				if [[ -z "${nama_file_hash_file_rar_hashcat}" ]]; then
					echo -e "${m}[-] ${p}Gagal mengekstrak hash file RAR '${nama_file_rar}' ke format Hashcat.${r}"
					exit 1
				# kondisi jika isi file hash file rar hashcat tidak kosong
				else
					echo -e "${h}[+] ${p}Berhasil mengekstrak hash file RAR '${nama_file_rar}' ke format Hashcat.${r}"
				fi
			else
				echo -e "${m}[-] ${p}Gagal mengekstrak hash file RAR '${nama_file_rar}' ke format Hashcat.${r}"
				exit 1
			fi

			echo ""
			read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk kembali ke menu utama.\e[0m'
			break
		done
	elif [[ "${pilih_menu}" == "3" ]]; then

                # cek alat 7z2john
                if ! command -v 7z2john >> /dev/null 2>&1; then
                        while true; do
                                read -p $'\e[1;37mMasukkan path ke jalur alat 7z2john: \e[1;33m' cek_7z2john
	                        if [[ ! -f "${cek_7z2john}" ]]; then
                                        echo -e "${m}[-] ${p}Alat 7z2john tidak ditemukan.${r}"
			                continue
                                else
		                        path_7z2john="${cek_7z2john}"
	                                break
                                fi
                        done
                else
                        path_7z2john="7z2john"
                fi

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
			hash_file_7z_john=$("${path_7z2john}" "${nama_file_7z}" 2>/dev/null)
                        base_7z_john=$(basename "${nama_file_7z}")
			nama_file_hash_file_7z_john="${path}/${base_7z_john}.john"
			echo "${hash_file_7z_john}" > "${nama_file_hash_file_7z_john}"


			if [[ -f "${nama_file_hash_file_7z_john}" ]]; then
				# kondisi jika isi file hash file 7z john kosong
				if [[ -z "${nama_file_hash_file_7z_john}" ]]; then
					echo -e "${m}[-] ${p}Gagal mengekstrak hash file 7z '${nama_file_7z}' ke format John.${r}"
					exit 1
				# kondisi jika isi file hash file 7z john tidak kosong
				else
					echo -e "${h}[+] ${p}Berhasil mengekstrak hash file 7z '${nama_file_7z}' ke format John.${r}"
				fi
			else
				echo -e "${m}[-] ${p}Gagal mengekstrak hash file 7z '${nama_file_7z}' ke format John.${r}"
				exit 1
			fi

			# mengekstrak hash file 7z ke format hashcat
			echo -e "${b}[*] ${p}Mengekstrak hash file 7z '${nama_file_7z}' ke format Hashcat ...${r}"
			sleep 3
			hash_file_7z_hashcat=$("${path_7z2john}" "${nama_file_7z}" 2>/dev/null | cut -d ":" -f 2 | tr -d "[:space:]")
	                base_7z_hashcat=$(basename "${nama_file_7z}")
			nama_file_hash_file_7z_hashcat="${path}/${base_7z_hashcat}.hashcat"
			echo "${hash_file_7z_hashcat}" > "${nama_file_hash_file_7z_hashcat}"

			if [[ -f "${nama_file_hash_file_7z_hashcat}" ]]; then
				# kondisi jika isi file hash file 7z hashcat kosong
				if [[ -z "${nama_file_hash_file_7z_hashcat}" ]]; then
					echo -e "${m}[-] ${p}Gagal mengekstrak hash file 7z '${nama_file_7z}' ke format Hashcat.${r}"
					exit 1

				# kondisi jika isi file hash file 7z hashcat tidak kosong
				else
					echo -e "${h}[+] ${p}Berhasil mengekstrak hash file 7z '${nama_file_7z}' ke format Hashcat.${r}"
				fi
			else
				echo -e "${m}[-] ${p}Gagal mengekstrak hash file 7z '${nama_file_7z}' ke format Hashcat.${r}"
                                exit 1
			fi

			echo ""
			read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk kembali ke menu utama.\e[0m'
			break
		done
	elif [[ "${pilih_menu}" == "4" ]]; then

                # cek alat pdf2john
                if ! command -v pdf2john >> /dev/null 2>&1; then
                        while true; do
                                read -p $'\e[1;37mMasukkan path ke jalur alat pdf2john: \e[1;33m' cek_pdf2john
	                        if [[ ! -f "${cek_pdf2john}" ]]; then
                                        echo -e "${m}[-] ${p}Alat pdf2john tidak ditemukan.${r}"
			                continue
                                else
		                        path_pdf2john="${cek_pdf2john}"
	                                break
                                fi
                        done
                else
                        path_pdf2john="pdf2john"
                fi

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
			hash_file_pdf_john=$("${path_pdf2john}" "${nama_file_pdf}" 2>/dev/null)
                        base_pdf_john=$(basename "${nama_file_pdf}")
			nama_file_hash_file_pdf_john="${path}/${base_pdf_john}.john"
			echo "${hash_file_pdf_john}" > "${nama_file_hash_file_pdf_john}"

			if [[ -f "${nama_file_hash_file_pdf_john}" ]]; then
				# kondisi jika isi file hash file pdf john kosong
				if [[ -z "${nama_file_hash_file_pdf_john}" ]]; then
					echo -e "${m}[-] ${p}Gagal mengekstrak hash file PDF '${nama_file_pdf}' ke format John.${r}"
					exit 1
				# kondisi jika isi file hash file pdf john tidak kosong
				else
					echo -e "${h}[+] ${p}Berhasil mengekstrak hash file PDF '${nama_file_pdf}' ke format John.${r}"
				fi
			else
				echo -e "${m}[-] ${p}Gagal mengekstrak hash file PDF '${nama_file_pdf}' ke format John.${r}"
				exit 1
			fi

			# mengekstrak hash file pdf ke format hashcat
			echo -e "${b}[*] ${p}Mengekstrak hash file PDF '${nama_file_pdf}' ke format Hashcat ...${r}"
			sleep 3
			hash_file_pdf_hashcat=$("${path_pdf2john}" "${nama_file_pdf}" 2>/dev/null | cut -d ":" -f 2 | tr -d "[:space:]")
                        base_7z_hashcat=$(basename "${nama_file_7z}")
			nama_file_hash_file_pdf_hashcat="${path}/${base_7z_hashcat}.hashcat"
			echo "${hash_file_pdf_hashcat}" > "${nama_file_hash_file_pdf_hashcat}"

			if [[ -f "${nama_file_hash_file_pdf_hashcat}" ]]; then
				# kondisi jika isi file hash file pdf hashcat kosong
				if [[ -z "${nama_file_hash_file_pdf_hashcat}" ]]; then
					echo -e "${m}[-] ${p}Gagal mengekstrak hash file PDF '${nama_file_pdf}' ke format Hashcat.${r}"
					exit 1
				# kondisi jika isi file hash file pdf hashcat tidak kosong
				else
					echo -e "${h}[+] ${p}Berhasil mengekstrak hash file PDF '${nama_file_pdf}' ke format Hashcat.${r}"
				fi
			else
				echo -e "${m}[-] ${p}Gagal mengekstrak hash file PDF '${nama_file_pdf}' ke format Hashcat.${r}"
				exit 1
			fi

			echo ""
			read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk kembali ke menu utama.\e[0m'
			break
		done
	elif [[ "${pilih_menu}" == "5" ]]; then

                # cek alat office2john
                if ! command -v office2john >> /dev/null 2>&1; then
                        while true; do
                                read -p $'\e[1;37mMasukkan path ke jalur alat office2john: \e[1;33m' cek_office2john
	                        if [[ ! -f "${cek_office2john}" ]]; then
                                        echo -e "${m}[-] ${p}Alat office2john tidak ditemukan.${r}"
			                continue
                                else
		                        path_office2john="${cek_office2john}"
	                                break
                                fi
                        done
                else
                        path_office2john="office2john"
                fi

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
			hash_file_office_john=$("${path_office2john}" "${nama_file_office}" 2>/dev/null)
                        base_office_john=$(basename "${nama_file_office}")
			nama_file_hash_file_office_john="${path}/${base_office_john}.john"
			echo "${hash_file_office_john}" > "${nama_file_hash_file_office_john}"

			if [[ -f "${nama_file_hash_file_office_john}" ]]; then
				# kondisi jika isi file hash file office john kosong
				if [[ -z "${nama_file_hash_file_office_john}" ]]; then
					echo -e "${m}[-] ${p}Gagal mengekstrak hash file Office '${nama_file_office}' ke format John.${r}"
					exit 1
				# kondisi jika isi file hash file office john tidak kosong
				else
					echo -e "${h}[+] ${p}Berhasil mengekstrak hash file Office '${nama_file_office}' ke format John.${r}"
				fi
			else
				echo -e "${m}[-] ${p}Gagal mengekstrak hash file Office '${nama_file_office}' ke format John.${r}"
				exit 1
			fi

			# mengekstrak hash file office ke format hashcat
			echo -e "${b}[*] ${p}Mengekstrak hash file Office '${nama_file_office}' ke format Hashcat ...${r}"
			sleep 3
			hash_file_office_hashcat=$("${path_office2john}" "${nama_file_office}" 2>/dev/null | cut -d ":" -f 2 | tr -d "[:space:]")
                        base_office_hashcat=$(basename "${nama_file_office}")
			nama_file_hash_file_office_hashcat="${path}/${base_office_hashcat}.hashcat"
			echo "${hash_file_office_hashcat}" > "${nama_file_hash_file_office_hashcat}"

			if [[ -f "${nama_file_hash_file_office_hashcat}" ]]; then
				# kondisi jika isi file hash file office hashcat kosong
				if [[ -z "${nama_file_hash_file_office_hashcat}" ]]; then
					echo -e "${m}[-] ${p}Gagal mengekstrak hash file Office '${nama_file_office}' ke format Hashcat.${r}"
					exit 1
				# kondisi jika isi file hash file office hashcat tidak kosong
				else
					echo -e "${h}[+] ${p}Berhasil mengekstrak hash file Office '${nama_file_office}' ke format Hashcat.${r}"
				fi
			else
				echo -e "${m}[-] ${p}Gagal mengekstrak hash file Office '${nama_file_office}' ke format Hashcat.${r}"
				exit 1
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
