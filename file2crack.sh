#!/bin/bash
#--------------------------------------------------
# file2crack
#
# file2crack adalah sebuah program bash sederhana yang 
# dirancang untuk mengcrack kata sandi file ZIP, RAR, 
# 7z, PDF, Office (docx, xlsx, pptx).
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
        "Crack kata sandi file ZIP dengan John"
	"Crack kata sandi file RAR dengan John"
        "Crack kata sandi file 7z dengan John"
	"Crack kata sandi file PDF dengan John"
        "Crack kata sandi file Office (docx, xlsx, pptx) dengan John"
	"Crack kata sandi file ZIP dengan Hashcat"
        "Crack kata sandi file RAR dengan Hashcat"
	"Crack kata sandi file 7z dengan Hashcat"
        "Crack kata sandi file PDF dengan Hashcat"
	"Crack kata sandi file Office (docx, xlsx, pptx) dengan Hashcat"
	"Tentang"
)

clear

echo -e "${b}Selamat datang di file2crack${r}"
echo -e ""
echo -e "${p}file2crack adalah sebuah program Bash sederhana yang dirancang untuk melakukan cracking${p}"
echo -e "${p}kata sandi file ZIP, RAR, 7Z, PDF, dan file office (docx, xlsx, pptx).${r}"
echo -e ""
echo -e "${k}Peringatan${p}"
echo -e ""
echo -e "${p}Program ini dibuat semata-mata hanya untuk tujuan edukasi dan pembelajaran saja. Tidak${r}"
echo -e "${p}ada maksud atau niatan mendorong kegiatan yang melanggar hukum (ilegal). Gunakan program${r}"
echo -e "${p}ini hanya pada file yang kalian miliki saja. Pembuat (bgropay) tidak bertanggung jawab atas${r}"
echo -e "${p}penyalahgunaan program ini. Terimakasih.${r}"
echo -e ""
read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk melanjutkan...\e[0m'

while true; do

	# membersihkan layar terminmal
	clear

	# waktu saat ini
	waktu=$(date +"%d-%m-%Y %H:%M:%S")

	# konter angka anggota list
	n=0

	# menampilkan waktu saat ini dan menu
	echo -e "${p}[${c}file2crack${p}] [${h}${waktu}${p}]${r}"
	echo ""
	echo -e "${k}Daftar menu yang tersedia:${r}"
	echo ""
        echo "-------------------------------------------------------------------"
	for menu in "${daftar_menu[@]}"; do
		echo -e "${p}[${k}${n}${p}] ${menu}${r}"
                if [[ "${n}" -eq 0 ]]; then
		        echo "-------------------------------------------------------------------"
                elif [[ "${n}" -eq 5 ]]; then
		        echo "-------------------------------------------------------------------"
	        elif [[ "${n}" -eq 10 ]]; then
		        echo "-------------------------------------------------------------------"
	        elif [[ "${n}" -eq 15 ]]; then
		        echo "-------------------------------------------------------------------"
	        elif [[ "${n}" -eq 16 ]]; then
		        echo "-------------------------------------------------------------------"
	        fi
		((n+=1))
	done

	read -p $'\e[1;37mPilih menu: \e[1;33m' pilih_menu
	if [[ -z "${pilih_menu}" ]]; then
		echo -e "${m}[-] ${p}Menu tidak boleh kosong. Silahkan pilih kembali..${r}"
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
			echo -e "${h}[+] ${p}File ZIP '${nama_file_zip}' ditemukan.${r}"

			# mengekstrak hash file zip ke format john
			echo -e "${b}[*] ${p}Mengekstrak hash file ZIP '${nama_file_zip}' ke format John ...${r}"
			sleep 3
			hash_file_zip_john=$(zip2john "${nama_file_zip}" 2>/dev/null)
                        base=$(basename "${nama_file_zip}")
			nama_file_hash_file_zip_john="${path}/${base}.john"
			echo "${hash_file_zip_john}" > "${nama_file_hash_file_zip_john}"

			if [[ -f "${nama_file_hash_file_zip_john}" ]]; then
				# kondisi jika isi file hash file zip john kosong
				if [[ $(cat "${nama_file_hash_file_zip_john}" | grep -o "zip" || cat "${nama_file_hash_file_zip_john}" | grep -o "pkzip") ]]; then
					echo -e "${h}[+] ${p}Berhasil mengekstrak hash file ZIP '${nama_file_zip}' ke format John.${r}"
				# kondisi jika isi file hash file zip john tidak kosong
				else
					echo -e "${m}[-] ${p}Gagal mengekstrak hash file ZIP '${nama_file_zip}' ke format John.${r}"
				fi
			else
				echo -e "${m}[-] ${p}Gagal mengekstrak hash file ZIP '${nama_file_zip}' ke format John.${r}"
			fi

			# mengekstrak hash file zip ke format hashcat
			echo -e "${b}[*] ${p}Mengekstrak hash file ZIP '${nama_file_zip}' ke format Hashcat ...${r}"
			sleep 3
			hash_file_zip_hashcat=$(zip2john "${nama_file_zip}" 2>/dev/null | cut -d ":" -f 2 | tr -d "[:space:]")
                        base=$(basename "${nama_file_zip}")
			nama_file_hash_file_zip_hashcat="${path}/${base}.hashcat"
			echo "${hash_file_zip_hashcat}" > "${nama_file_hash_file_zip_hashcat}"

			if [[ -f "${nama_file_hash_file_zip_hashcat}" ]]; then
				# kondisi jika isi file hash file zip hashcat tidak kosong
				if [[ $(cat "${nama_file_hash_file_zip_hashcat}" | grep -o "zip" || cat "${nama_file_hash_file_zip_hashcat}" | grep -o "pkzip") ]]; then
					echo -e "${h}[+] ${p}Berhasil mengekstrak hash file ZIP '${nama_file_zip}' ke format Hashcat.${r}"
				# kondisi jika isi file hash file zip hashcat kosong
				else
					echo -e "${m}[-] ${p}Gagal mengekstrak hash file ZIP '${nama_file_zip}' ke format Hashcat.${r}"
				fi
			else
				echo -e "${m}[-] ${p}Gagal mengekstrak hash file ZIP '${nama_file_zip}' ke format Hashcat.${r}"
			fi

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
			echo -e "${h}[+] ${p}File RAR '${nama_file_rar}' ditemukan.${r}"

			# mengekstrak hash file rar ke format john
			echo -e "${b}[*] ${p}Mengekstrak hash file RAR '${nama_file_rar}' ke format John ...${r}"
			sleep 3
			hash_file_rar_john=$(rar2john "${nama_file_rar}" 2>/dev/null)
                        base_rar_john=$(basename "${nama_file_rar}")
			nama_file_hash_file_rar_john="${path}/${base_rar_john}.john"
			echo "${hash_file_rar_john}" > "${nama_file_hash_file_rar_john}"

			if [[ -f "${nama_file_hash_file_rar_john}" ]]; then
				# kondisi jika isi file hash file rar john tidak kosong
				if [[ $(cat "${nama_file_hash_file_rar_john}" | grep -o "rar5") ]]; then
					echo -e "${h}[+] ${p}Berhasil mengekstrak hash file RAR '${nama_file_rar}' ke format John.${r}"
				# kondisi jika isi file hash file rar john kosong
				else
					echo -e "${m}[-] ${p}Gagal mengekstrak hash file RAR '${nama_file_rar}' ke format John.${r}"
				fi
			else
				echo -e "${m}[-] ${p}Gagal mengekstrak hash file RAR '${nama_file_rar}' ke format John.${r}"
			fi

			# mengekstrak hash file rar ke format hashcat
			echo -e "${b}[*] ${p}Mengekstrak hash file RAR '${nama_file_rar}' ke format Hashcat ...${r}"
			sleep 3
			hash_file_rar_hashcat=$(rar2john "${nama_file_rar}" 2>/dev/null | cut -d ":" -f 2 | tr -d "[:space:]")
                        base_rar_hashcat=$(basename "${nama_file_rar}")
			nama_file_hash_file_rar_hashcat="${path}/${base_rar_hashcat}.hashcat"
			echo "${hash_file_rar_hashcat}" > "${nama_file_hash_file_rar_hashcat}"

			if [[ -f "${nama_file_hash_file_rar_hashcat}" ]]; then
				# kondisi jika isi file hash file rar hashcat kosong
				if [[ $(cat "${nama_file_hash_file_rar_hashcat}" | grep -o "rar5") ]]; then
					echo -e "${h}[+] ${p}Berhasil mengekstrak hash file RAR '${nama_file_rar}' ke format Hashcat.${r}"
				# kondisi jika isi file hash file rar hashcat tidak kosong
				else
					echo -e "${m}[-] ${p}Gagal mengekstrak hash file RAR '${nama_file_rar}' ke format Hashcat.${r}"
				fi
			else
				echo -e "${m}[-] ${p}Gagal mengekstrak hash file RAR '${nama_file_rar}' ke format Hashcat.${r}"
			fi

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
			echo -e "${h}[+] ${p}File 7z '${nama_file_7z}' ditemukan.${r}"

			# mengekstrak hash file 7z ke format john
			echo -e "${b}[*] ${p}Mengekstrak hash file 7z '${nama_file_7z}' ke format John ...${r}"
			sleep 3
			hash_file_7z_john=$(7z2john "${nama_file_7z}" 2>/dev/null)
                        base_7z_john=$(basename "${nama_file_7z}")
			nama_file_hash_file_7z_john="${path}/${base_7z_john}.john"
			echo "${hash_file_7z_john}" > "${nama_file_hash_file_7z_john}"


			if [[ -f "${nama_file_hash_file_7z_john}" ]]; then
				# kondisi jika isi file hash file 7z john tidak kosong
				if [[ $(cat "${nama_file_hash_file_7z_john}" | grep -o "7z") ]]; then
					echo -e "${h}[+] ${p}Berhasil mengekstrak hash file 7z '${nama_file_7z}' ke format John.${r}"
				# kondisi jika isi file hash file 7z john kosong
				else
					echo -e "${m}[-] ${p}Gagal mengekstrak hash file 7z '${nama_file_7z}' ke format John.${r}"
				fi
			else
				echo -e "${m}[-] ${p}Gagal mengekstrak hash file 7z '${nama_file_7z}' ke format John.${r}"
			fi

			# mengekstrak hash file 7z ke format hashcat
			echo -e "${b}[*] ${p}Mengekstrak hash file 7z '${nama_file_7z}' ke format Hashcat ...${r}"
			sleep 3
			hash_file_7z_hashcat=$(7z2john "${nama_file_7z}" 2>/dev/null | cut -d ":" -f 2 | tr -d "[:space:]")
	                base_7z_hashcat=$(basename "${nama_file_7z}")
			nama_file_hash_file_7z_hashcat="${path}/${base_7z_hashcat}.hashcat"
			echo "${hash_file_7z_hashcat}" > "${nama_file_hash_file_7z_hashcat}"

			if [[ -f "${nama_file_hash_file_7z_hashcat}" ]]; then
				# kondisi jika isi file hash file 7z hashcat tidak kosong
				if [[ $(cat "${nama_file_hash_file_7z_hashcat}" | grep -o "7z") ]]; then
					echo -e "${h}[+] ${p}Berhasil mengekstrak hash file 7z '${nama_file_7z}' ke format Hashcat.${r}"

				# kondisi jika isi file hash file 7z hashcat kosong
				else
					echo -e "${m}[-] ${p}Gagal mengekstrak hash file 7z '${nama_file_7z}' ke format Hashcat.${r}"
				fi
			else
				echo -e "${m}[-] ${p}Gagal mengekstrak hash file 7z '${nama_file_7z}' ke format Hashcat.${r}"
			fi

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
			echo -e "${h}[+] ${p}File PDF '${nama_file_pdf}' ditemukan.${r}"

			# mengekstrak hash file pdf ke format john
			echo -e "${b}[*] ${p}Mengekstrak hash file PDF '${nama_file_pdf}' ke format John ...${r}"
			sleep 3
			hash_file_pdf_john=$(pdf2john "${nama_file_pdf}" 2>/dev/null)
                        base_pdf_john=$(basename "${nama_file_pdf}")
			nama_file_hash_file_pdf_john="${path}/${base_pdf_john}.john"
			echo "${hash_file_pdf_john}" > "${nama_file_hash_file_pdf_john}"

			if [[ -f "${nama_file_hash_file_pdf_john}" ]]; then
				# kondisi jika isi file hash file pdf john tidak kosong
				if [[ $(cat "${nama_file_hash_file_pdf_john}" | grep -o "pdf") ]]; then
					echo -e "${h}[+] ${p}Berhasil mengekstrak hash file PDF '${nama_file_pdf}' ke format John.${r}"
				# kondisi jika isi file hash file pdf john kosong
				else
					echo -e "${m}[-] ${p}Gagal mengekstrak hash file PDF '${nama_file_pdf}' ke format John.${r}"
				fi
			else
				echo -e "${m}[-] ${p}Gagal mengekstrak hash file PDF '${nama_file_pdf}' ke format John.${r}"
			fi

			# mengekstrak hash file pdf ke format hashcat
			echo -e "${b}[*] ${p}Mengekstrak hash file PDF '${nama_file_pdf}' ke format Hashcat ...${r}"
			sleep 3
			hash_file_pdf_hashcat=$(pdf2john "${nama_file_pdf}" 2>/dev/null | cut -d ":" -f 2 | tr -d "[:space:]")
                        base_pdf_hashcat=$(basename "${nama_file_pdf}")
			nama_file_hash_file_pdf_hashcat="${path}/${base_pdf_hashcat}.hashcat"
			echo "${hash_file_pdf_hashcat}" > "${nama_file_hash_file_pdf_hashcat}"

			if [[ -f "${nama_file_hash_file_pdf_hashcat}" ]]; then
				# kondisi jika isi file hash file pdf hashcat tidak kosong
				if [[ $(cat "${nama_file_hash_file_pdf_hashcat}" | grep -o "pdf") ]]; then
					echo -e "${h}[+] ${p}Berhasil mengekstrak hash file PDF '${nama_file_pdf}' ke format Hashcat.${r}"
				# kondisi jika isi file hash file pdf hashcat kosong
				else
					echo -e "${m}[-] ${p}Gagal mengekstrak hash file PDF '${nama_file_pdf}' ke format Hashcat.${r}"
				fi
			else
				echo -e "${m}[-] ${p}Gagal mengekstrak hash file PDF '${nama_file_pdf}' ke format Hashcat.${r}"
			fi

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
			if [[ "${nama_file_office##*.}" != "docx" && "${nama_file_office##*.}" != "xlsx" && "${nama_file_office##*.}" != "pptx" ]]; then
				echo -e "${m}[-] ${p}File '${nama_file_office}' bukan file Office.${r}"
				continue
			fi

			# kondisi jika file office ditemukan
			echo -e "${h}[+] ${p}File Office '${nama_file_office}' ditemukan.${r}"

			# mengekstrak hash file office ke format john
			echo -e "${b}[*] ${p}Mengekstrak hash file Office '${nama_file_office}' ke format John ...${r}"
			sleep 3
			hash_file_office_john=$(office2john "${nama_file_office}" 2>/dev/null)
                        base_office_john=$(basename "${nama_file_office}")
			nama_file_hash_file_office_john="${path}/${base_office_john}.john"
			echo "${hash_file_office_john}" > "${nama_file_hash_file_office_john}"

			if [[ -f "${nama_file_hash_file_office_john}" ]]; then
				# kondisi jika isi file hash file office john tidak kosong
				if [[ $(cat "${nama_file_hash_file_office_john}" | grep -o "office") ]]; then
					echo -e "${h}[+] ${p}Berhasil mengekstrak hash file Office '${nama_file_office}' ke format John.${r}"
				# kondisi jika isi file hash file office john kosong
				else
					echo -e "${m}[-] ${p}Gagal mengekstrak hash file Office '${nama_file_office}' ke format John.${r}"
				fi
			else
				echo -e "${m}[-] ${p}Gagal mengekstrak hash file Office '${nama_file_office}' ke format John.${r}"
			fi

			# mengekstrak hash file office ke format hashcat
			echo -e "${b}[*] ${p}Mengekstrak hash file Office '${nama_file_office}' ke format Hashcat ...${r}"
			sleep 3
			hash_file_office_hashcat=$(office2john "${nama_file_office}" 2>/dev/null | cut -d ":" -f 2 | tr -d "[:space:]")
                        base_office_hashcat=$(basename "${nama_file_office}")
			nama_file_hash_file_office_hashcat="${path}/${base_office_hashcat}.hashcat"
			echo "${hash_file_office_hashcat}" > "${nama_file_hash_file_office_hashcat}"

			if [[ -f "${nama_file_hash_file_office_hashcat}" ]]; then
				# kondisi jika isi file hash file office hashcat tidak kosong
				if [[ $(cat "${nama_file_hash_file_office_hashcat}" | grep -o "office") ]]; then
					echo -e "${h}[+] ${p}Berhasil mengekstrak hash file Office '${nama_file_office}' ke format Hashcat.${r}"
				# kondisi jika isi file hash file office hashcat kosong
				else
					echo -e "${m}[-] ${p}Gagal mengekstrak hash file Office '${nama_file_office}' ke format Hashcat.${r}"
				fi
			else
				echo -e "${m}[-] ${p}Gagal mengekstrak hash file Office '${nama_file_office}' ke format Hashcat.${r}"
			fi

			read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk kembali ke menu utama.\e[0m'
			break
		done
	elif [[ "${pilih_menu}" == "6" ]]; then
		target_hash_zip_john="${nama_file_hash_file_zip_john}"
		if [[ -f "${target_hash_zip_john}" ]]; then
			echo -e "${b}[*] ${p}Pada sesi ini Anda sudah memiliki file hash dari file ZIP '${nama_file_zip}' (${h}${target_hash_zip_john}${p}).${r}"
			while true; do
				read -p $'\e[1;37mApakah Anda ingin menggunakannya (iya/tidak): \e[1;33m' nanya_zip_john
				if [[ "${nanya_zip_john}" == "iya" ]]; then
					while true; do
						read -p $'\e[1;37mMasukkan nama file Wordlist: \e[1;33m' nama_file_wordlist_zip_john
						if [[ -z "${nama_file_wordlist_zip_john}" ]]; then
							echo -e "${m}[-] ${p}Nama file Wordlist tidak boleh kosong.${r}"
							continue
						else
							if [[ ! -f "${nama_file_wordlist_zip_john}" ]]; then
								echo -e "${m}[-] ${p}File Wordlist '${nama_file_wordlist_zip_john}' tidak ditemukan.${r}"
								continue
							else
								echo -e "${h}[+] ${p}File Wordlist '${nama_file_wordlist_zip_john}' ditemukan.${r}"
								pot_zip_john="pot_zip_john.txt"
								while true; do
									read -p $'\e[1;37mApakah Anda ingin menggunakan mode verbose (iya/tidak): \e[1;33m' nanya_verbose_zip_john
									if [[ "${nanya_verbose_zip_john}" == "iya" ]]; then
										read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai prosres cracking.\e[0m'
										echo -e "${b}[*] ${p}Cracking kata sandi file ZIP '${nama_file_zip}' dengan John...${r}"
										john --wordlist="${nama_file_wordlist_zip_john}" --pot="${pot_zip_john}" --verbosity=6 --progress-every=1 "${target_hash_zip_john}"
										if [[ -f "${pot_zip_john}" ]]; then
											if [[ $(cat "${pot_zip_john}" | grep -o ":") ]]; then
												kata_sandi_zip_john=$(cat "${pot_zip_john}" | cut -d ":" -f 2)
												echo -e "${h}[+] ${p}Kata sandi ditemukan.${r}"
												echo -e "${h}[+] ${p}Kata sandi: ${h}${kata_sandi_zip_john}${r}"
												rm "${pot_zip_john}"
											else
												echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
												echo -e "${m}[-] ${p}Coba gunakan Wordlist yang lain.${r}"
											fi
											break
										else
											echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
											echo -e "${m}[-] ${p}File pot John tidak ditemukan.${r}"
										fi
										break

									elif [[ "${nanya_verbose_zip_john}" == "tidak" ]]; then
										read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai prosres cracking.\e[0m'
										echo -e "${b}[*] ${p}Cracking kata sandi file ZIP '${nama_file_zip}' dengan John...${r}"
										john --wordlist="${nama_file_wordlist_zip_john}" --pot="${pot_zip_john}" "${target_hash_zip_john}" > /dev/null 2>&1
										if [[ -f "${pot_zip_john}" ]]; then
											if [[ $(cat "${pot_zip_john}" | grep -o ":") ]]; then
												kata_sandi_zip_john=$(cat "${pot_zip_john}" | cut -d ":" -f 2)
												echo -e "${h}[+] ${p}Kata sandi ditemukan.${r}"
												echo -e "${h}[+] ${p}Kata sandi: ${h}${kata_sandi_zip_john}${r}"
												rm "${pot_zip_john}"
											else
												echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
												echo -e "${m}[-] ${p}Coba gunakan Wordlist yang lain.${r}"
											fi
											break
										else
											echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
											echo -e "${m}[-] ${p}File pot John tidak ditemukan.${r}"
										fi
										break
									else
										echo -e "${m}[-] ${p}Masukkan tidak valid. Harap masukkan 'iya' atau 'tidak'.${r}"
										continue
									fi
								done
							fi
							# break testing
							break
						fi
						# break file wordlist
						break
					done
					break
				elif [[ "${nanya_zip_john}" == "tidak" ]]; then
					while true; do
						read -p $'\e[1;37mMasukkan nama file hash dari file ZIP: \e[1;33m' nama_file_hash_dari_file_zip_john
						if [[ -z "${nama_file_hash_dari_file_zip_john}" ]]; then
							echo -e "${m}[-] ${p}Nama file hash tidak boleh kosong.${r}"
							continue
						else
							if [[ ! -f "${nama_file_hash_dari_file_zip_john}" ]]; then
								echo -e "${m}[-] ${p}File hash '${nama_file_hash_dari_file_zip_john}' tidak ditemukan.${r}"
								continue
							else
								if [[ "${nama_file_hash_dari_file_zip_john##*.}" == "john" ]]; then
									if [[ $(cat "${nama_file_hash_dari_file_zip_john}" | grep -o "zip" || cat "${nama_file_hash_dari_file_zip_john}" | grep -o "pkzip") ]]; then
										echo -e "${h}[+] ${p}File hash '${nama_file_hash_dari_file_zip_john}' ditemukan.${r}"
										while true; do
											read -p $'\e[1;37mMasukkan nama file Wordlist: \e[1;33m' nama_file_wordlist_zip_john
											if [[ -z "${nama_file_wordlist_zip_john}" ]]; then
												echo -e "${m}[-] ${p}Nama file Wordlist tidak boleh kosong.${r}"
												continue
											else
												if [[ ! -f "${nama_file_wordlist_zip_john}" ]]; then
													echo -e "${m}[-] ${p}File Wordlist '${nama_file_wordlist_zip_john}' tidak ditemukan.${r}"
													continue
												else
													pot_zip_john="pot_zip_john.txt"
													echo -e "${h}[+] ${p}File Wordlist '${nama_file_wordlist_zip_john}' ditemukan.${r}"
													while true; do
														read -p $'\e[1;37mApakah Anda ingin menggunakan mode verbose (iya/tidak): \e[1;33m' nanya_verbose_zip_john
														if [[ "${nanya_verbose_zip_john}" == "iya" ]]; then
															read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai prosres cracking.\e[0m'
															echo -e "${b}[*] ${p}Cracking kata sandi file ZIP '${nama_file_zip}' dengan John...${r}"
															john --wordlist="${nama_file_wordlist_zip_john}" --pot="${pot_zip_john}" --verbosity=6 --progress-every=1 "${target_hash_zip_john}"
															if [[ -f "${pot_zip_john}" ]]; then
																if [[ $(cat "${pot_zip_john}" | grep -o ":") ]]; then
																	kata_sandi_zip_john=$(cat "${pot_zip_john}" | cut -d ":" -f 2)
																	echo -e "${h}[+] ${p}Kata sandi ditemukan.${r}"
																	echo -e "${h}[+] ${p}Kata sandi: ${h}${kata_sandi_zip_john}${r}"
																	rm "${pot_zip_john}"
																else
																	echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
																	echo -e "${m}[-] ${p}Coba gunakan Wordlist yang lain.${r}"
																fi
																break
															else
																echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
																echo -e "${m}[-] ${p}File pot John tidak ditemukan.${r}"
															fi
															break
														elif [[ "${nanya_verbose_zip_john}" == "tidak" ]]; then
															read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai prosres cracking.\e[0m'
															echo -e "${b}[*] ${p}Cracking kata sandi file ZIP '${nama_file_zip}' dengan John...${r}"
															john --wordlist="${nama_file_wordlist_zip_john}" --pot="${pot_zip_john}" "${target_hash_zip_john}" > /dev/null 2>&1
															if [[ -f "${pot_zip_john}" ]]; then
																if [[ $(cat "${pot_zip_john}" | grep -o ":") ]]; then
																	kata_sandi_zip_john=$(cat "${pot_zip_john}" | cut -d ":" -f 2)
																	echo -e "${h}[+] ${p}Kata sandi ditemukan.${r}"
																	echo -e "${h}[+] ${p}Kata sandi: ${h}${kata_sandi_zip_john}${r}"
																	rm "${pot_zip_john}"
																else
																	echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
																	echo -e "${m}[-] ${p}Coba gunakan Wordlist yang lain.${r}"
																fi
																break
															else
																echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
																echo -e "${m}[-] ${p}File pot John tidak ditemukan.${r}"
															fi
															break
														else
															echo -e "${m}[-] ${p}Masukkan tidak valid. Harap masukkan 'iya' atau 'tidak'.${r}"
															continue
														fi
													done
												fi
												break
											fi
											break
										done
									else
										echo -e "${m}[-] ${p}Format hash file hash '{nama_file_hash_dari_file_zip_john}' tidak valid.${r}"
										continue
									fi

								else
									echo -e "${m}[-] ${p}File '${nama_file_hash_dari_file_zip_john}' bukan file hash.${r}"
									continue
								fi

							fi
						fi
						break
					done
					break
				else
					echo -e "${m}[-] ${p}Masukkan tidak valid. Harap masukan 'iya' atau 'tidak'.${r}"
					continue
				fi
			done

		else

			# memasukkan nama file zip
			while true; do
				read -p $'\e[1;37mMasukkan nama file ZIP: \e[1;33m' nama_file_zip_john

				# kondisi jika nama file zip kosong
				if [[ -z "${nama_file_zip_john}" ]]; then
					echo -e "${m}[-] ${p}Nama file ZIP tidak boleh kosong.${r}"
					continue
				fi

				# kondisi jika file zip tidak ditemukan
				if [[ ! -f "${nama_file_zip_john}" ]]; then
					echo -e "${m}[-] ${p}File ZIP '${nama_file_zip_john}' tidak ditemukan.${r}"
					continue
				fi

				# kondisi jika file bukan file zip
				if [[ "${nama_file_zip_john##*.}" != "zip" ]]; then
					echo -e "${m}[-] ${p}File '${nama_file_zip_john}' bukan file ZIP.${r}"
					continue
				fi

				# kondisi jika file zip ditemukan
				echo -e "${h}[+] ${p}File ZIP '${nama_file_zip_john}' ditemukan.${r}"
				break
			done


			while true; do
				read -p $'\e[1;37mMasukkan nama file hash dari file ZIP: \e[1;33m' nama_file_hash_dari_file_zip_john
				if [[ -z "${nama_file_hash_dari_file_zip_john}" ]]; then
					echo -e "${m}[-] ${p}Nama file hash tidak boleh kosong.${r}"
					continue
				else
					if [[ ! -f "${nama_file_hash_dari_file_zip_john}" ]]; then
						echo -e "${m}[-] ${p}File hash '${nama_file_hash_dari_file_zip_john}' tidak ditemukan.${r}"
						continue
					else
						if [[ "${nama_file_hash_dari_file_zip_john##*.}" == "john" ]]; then
							if [[ $(cat "${nama_file_hash_dari_file_zip_john}" | grep -o "zip" || cat "${nama_file_hash_dari_file_zip_john}" | grep -o "pkzip") ]]; then
								echo -e "${h}[+] ${p}File hash '${nama_file_hash_dari_file_zip_john}' ditemukan.${r}"
								while true; do
									read -p $'\e[1;37mMasukkan nama file Wordlist: \e[1;33m' nama_file_wordlist_zip_john
									if [[ -z "${nama_file_wordlist_zip_john}" ]]; then
										echo -e "${m}[-] ${p}Nama file Wordlist tidak boleh kosong.${r}"
										continue
									else
										if [[ ! -f "${nama_file_wordlist_zip_john}" ]]; then
											echo -e "${m}[-] ${p}File Wordlist '${nama_file_wordlist_zip_john}' tidak ditemukan.${r}"
											continue
										else
											echo -e "${h}[+] ${p}File Wordlist '${nama_file_wordlist_zip_john}' ditemukan.${r}"
											pot_zip_john="pot_zip_john.txt"
											while true; do
												read -p $'\e[1;37mApakah Anda ingin menggunakan mode verbose (iya/tidak): \e[1;33m' nanya_verbose_zip_john
												if [[ "${nanya_verbose_zip_john}" == "iya" ]]; then
													read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai prosres cracking.\e[0m'
													echo -e "${b}[*] ${p}Cracking kata sandi file ZIP '${nama_file_zip_john}' dengan John...${r}"
													john --wordlist="${nama_file_wordlist_zip_john}" --pot="${pot_zip_john}" --verbosity=6 --progress-every=1 "${nama_file_hash_dari_file_zip_john}"
													if [[ -f "${pot_zip_john}" ]]; then
														if [[ $(cat "${pot_zip_john}" | grep -o ":") ]]; then
															kata_sandi_zip_john=$(cat "${pot_zip_john}" | cut -d ":" -f 2)
															echo -e "${h}[+] ${p}Kata sandi ditemukan.${r}"
															echo -e "${h}[+] ${p}Kata sandi: ${h}${kata_sandi_zip_john}${r}"
															rm "${pot_zip_john}"
														else
															echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
															echo -e "${m}[-] ${p}Coba gunakan Wordlist yang lain.${r}"
														fi
														break
													else
														echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
														echo -e "${m}[-] ${p}File pot John tidak ditemukan.${r}"
													fi
													break
	
												elif [[ "${nanya_verbose_zip_john}" == "tidak" ]]; then
													read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai prosres cracking.\e[0m'
													echo -e "${b}[*] ${p}Cracking kata sandi file ZIP '${nama_file_zip_john}' dengan John...${r}"
													john --wordlist="${nama_file_wordlist_zip_john}" --pot="${pot_zip_john}" "${nama_file_hash_dari_file_zip_john}" > /dev/null 2>&1
													if [[ -f "${pot_zip_john}" ]]; then
														if [[ $(cat "${pot_zip_john}" | grep -o ":") ]]; then
															kata_sandi_zip_john=$(cat "${pot_zip_john}" | cut -d ":" -f 2)
															echo -e "${h}[+] ${p}Kata sandi ditemukan.${r}"
															echo -e "${h}[+] ${p}Kata sandi: ${h}${kata_sandi_zip_john}${r}"
															rm "${pot_zip_john}"
														else
															echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
															echo -e "${m}[-] ${p}Coba gunakan Wordlist yang lain.${r}"
														fi	
														break	
													else
														echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
														echo -e "${m}[-] ${p}File pot John tidak ditemukan.${r}"
													fi
													break
												else
													echo -e "${m}[-] ${p}Masukkan tidak valid. Harap masukkan 'iya' atau 'tidak'.${r}"
													continue
												fi
											done	
										fi
										break
									fi
									break
								done
							else
								echo -e "${m}[-] ${p}Format hash file hash '${nama_file_hash_dari_file_zip_john}' tidak valid.${r}"
								continue
							fi
						else
							echo -e "${m}[-] ${p}File '${nama_file_hash_dari_file_zip_john}' bukan file hash.${r}"
							continue
						fi
					fi
				fi
				break
			done


		fi
        	read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk kembali ke menu utama.\e[0m'

	elif [[ "${pilih_menu}" == "7" ]]; then
		target_hash_rar_john="${nama_file_hash_file_rar_john}"
		if [[ -f "${target_hash_rar_john}" ]]; then
			echo -e "${b}[*] ${p}Pada sesi ini Anda sudah memiliki file hash dari file RAR '${nama_file_rar}' (${h}${target_hash_rar_john}${p}).${r}"
			while true; do
				read -p $'\e[1;37mApakah Anda ingin menggunakannya (iya/tidak): \e[1;33m' nanya_rar_john
				if [[ "${nanya_rar_john}" == "iya" ]]; then
					while true; do
						read -p $'\e[1;37mMasukkan nama file Wordlist: \e[1;33m' nama_file_wordlist_rar_john
						if [[ -z "${nama_file_wordlist_rar_john}" ]]; then
							echo -e "${m}[-] ${p}Nama file Wordlist tidak boleh kosong.${r}"
							continue
						else
							if [[ ! -f "${nama_file_wordlist_rar_john}" ]]; then
								echo -e "${m}[-] ${p}File Wordlist '${nama_file_wordlist_rar_john}' tidak ditemukan.${r}"
								continue
							else
								echo -e "${h}[+] ${p}File Wordlist '${nama_file_wordlist_rar_john}' ditemukan.${r}"
								pot_rar_john="pot_rar_john.txt"
								while true; do
									read -p $'\e[1;37mApakah Anda ingin menggunakan mode verbose (iya/tidak): \e[1;33m' nanya_verbose_rar_john
									if [[ "${nanya_verbose_rar_john}" == "iya" ]]; then
										read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai prosres cracking.\e[0m'
										echo -e "${b}[*] ${p}Cracking kata sandi file RAR '${nama_file_rar}' dengan John...${r}"
										john --wordlist="${nama_file_wordlist_rar_john}" --pot="${pot_rar_john}" --verbosity=6 --progress-every=1 "${target_hash_rar_john}"
										if [[ -f "${pot_rar_john}" ]]; then
											if [[ $(cat "${pot_rar_john}" | grep -o ":") ]]; then
												kata_sandi_rar_john=$(cat "${pot_rar_john}" | cut -d ":" -f 2)
												echo -e "${h}[+] ${p}Kata sandi ditemukan.${r}"
												echo -e "${h}[+] ${p}Kata sandi: ${h}${kata_sandi_rar_john}${r}"
												rm "${pot_rar_john}"
											else
												echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
												echo -e "${m}[-] ${p}Coba gunakan Wordlist yang lain.${r}"
											fi
											break
										else
											echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
											echo -e "${m}[-] ${p}File pot John tidak ditemukan.${r}"
										fi
										break

									elif [[ "${nanya_verbose_rar_john}" == "tidak" ]]; then
										read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai prosres cracking.\e[0m'
										echo -e "${b}[*] ${p}Cracking kata sandi file RAR '${nama_file_rar}' dengan John...${r}"
										john --wordlist="${nama_file_wordlist_rar_john}" --pot="${pot_rar_john}" "${target_hash_rar_john}" > /dev/null 2>&1
										if [[ -f "${pot_rar_john}" ]]; then
											if [[ $(cat "${pot_rar_john}" | grep -o ":") ]]; then
												kata_sandi_rar_john=$(cat "${pot_rar_john}" | cut -d ":" -f 2)
												echo -e "${h}[+] ${p}Kata sandi ditemukan.${r}"
												echo -e "${h}[+] ${p}Kata sandi: ${h}${kata_sandi_rar_john}${r}"
												rm "${pot_rar_john}"
											else
												echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
												echo -e "${m}[-] ${p}Coba gunakan Wordlist yang lain.${r}"
											fi
											break
										else
											echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
											echo -e "${m}[-] ${p}File pot John tidak ditemukan.${r}"
										fi
										break
									else
										echo -e "${m}[-] ${p}Masukkan tidak valid. Harap masukkan 'iya' atau 'tidak'.${r}"
										continue
									fi
								done
							fi
							break
						fi
						break
					done
					break
				elif [[ "${nanya_rar_john}" == "tidak" ]]; then
					while true; do
						read -p $'\e[1;37mMasukkan nama file hash dari file RAR: \e[1;33m' nama_file_hash_dari_file_rar_john
						if [[ -z "${nama_file_hash_dari_file_rar_john}" ]]; then
							echo -e "${m}[-] ${p}Nama file hash tidak boleh kosong.${r}"
							continue
						else
							if [[ ! -f "${nama_file_hash_dari_file_rar_john}" ]]; then
								echo -e "${m}[-] ${p}File hash '${nama_file_hash_dari_file_rar_john}' tidak ditemukan.${r}"
								continue
							else
								if [[ "${nama_file_hash_dari_file_rar_john##*.}" == "john" ]]; then
									if [[ $(cat "${nama_file_hash_dari_file_rar_john}" | grep -o "rar5") ]]; then
										echo -e "${h}[+] ${p}File hash '${nama_file_hash_dari_file_rar_john}' ditemukan.${r}"
										while true; do
											read -p $'\e[1;37mMasukkan nama file Wordlist: \e[1;33m' nama_file_wordlist_rar_john
											if [[ -z "${nama_file_wordlist_rar_john}" ]]; then
												echo -e "${m}[-] ${p}Nama file Wordlist tidak boleh kosong.${r}"
												continue
											else
												if [[ ! -f "${nama_file_wordlist_rar_john}" ]]; then
													echo -e "${m}[-] ${p}File Wordlist '${nama_file_wordlist_rar_john}' tidak ditemukan.${r}"
													continue
												else
   													echo -e "${h}[+] ${p}File Wordlist '${nama_file_wordlist_rar_john}' ditemukan.${r}"
													pot_rar_john="pot_rar_john.txt"
													while true; do
														read -p $'\e[1;37mApakah Anda ingin menggunakan mode verbose (iya/tidak): \e[1;33m' nanya_verbose_rar_john
														if [[ "${nanya_verbose_rar_john}" == "iya" ]]; then
															read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai prosres cracking.\e[0m'
															echo -e "${b}[*] ${p}Cracking kata sandi file RAR '${nama_file_rar}' dengan John...${r}"
															john --wordlist="${nama_file_wordlist_rar_john}" --pot="${pot_rar_john}" --verbosity=6 --progress-every=1 "${target_hash_rar_john}"
															if [[ -f "${pot_rar_john}" ]]; then
																if [[ $(cat "${pot_rar_john}" | grep -o ":") ]]; then
																	kata_sandi_rar_john=$(cat "${pot_rar_john}" | cut -d ":" -f 2)
																	echo -e "${h}[+] ${p}Kata sandi ditemukan.${r}"
																	echo -e "${h}[+] ${p}Kata sandi: ${h}${kata_sandi_rar_john}${r}"
																	rm "${pot_rar_john}"
																else
																	echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
																	echo -e "${m}[-] ${p}Coba gunakan Wordlist yang lain.${r}"
																fi
																break
															else
																echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
																echo -e "${m}[-] ${p}File pot John tidak ditemukan.${r}"
															fi
															break
	
														elif [[ "${nanya_verbose_rar_john}" == "tidak" ]]; then
															read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai prosres cracking.\e[0m'
															echo -e "${b}[*] ${p}Cracking kata sandi file RAR '${nama_file_rar}' dengan John...${r}"
															john --wordlist="${nama_file_wordlist_rar_john}" --pot="${pot_rar_john}" "${target_hash_rar_john}" > /dev/null 2>&1
															if [[ -f "${pot_rar_john}" ]]; then
																if [[ $(cat "${pot_rar_john}" | grep -o ":") ]]; then
																	kata_sandi_rar_john=$(cat "${pot_rar_john}" | cut -d ":" -f 2)
																	echo -e "${h}[+] ${p}Kata sandi ditemukan.${r}"
																	echo -e "${h}[+] ${p}Kata sandi: ${h}${kata_sandi_rar_john}${r}"
																	rm "${pot_rar_john}"
																else
																	echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
																	echo -e "${m}[-] ${p}Coba gunakan Wordlist yang lain.${r}"
																fi
																break
															else	
																echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
																echo -e "${m}[-] ${p}File pot John tidak ditemukan.${r}"
															fi
															break
														else
															echo -e "${m}[-] ${p}Masukkan tidak valid. Harap masukkan 'iya' atau 'tidak'.${r}"
															continue
														fi
													done
												fi
												break
											fi
											break
										done
									else
										echo -e "${m}[-] ${p}Format hash file hash '{nama_file_hash_dari_file_rar_john}' tidak valid.${r}"
										continue
									fi
								else
									echo -e "${m}[-] ${p}File '${nama_file_hash_dari_file_rar_john}' bukan file hash.${r}"
									continue
								fi
							fi
						fi
						break
					done
					break
				else
					echo -e "${m}[-] ${p}Masukkan tidak valid. Harap masukkan 'iya' atau 'tidak'.${r}"
					continue
				fi
			done

		else


			# memasukkan nama file rar
			while true; do
				read -p $'\e[1;37mMasukkan nama file RAR: \e[1;33m' nama_file_rar_john

				# kondisi jika nama file rar kosong
				if [[ -z "${nama_file_rar_john}" ]]; then
					echo -e "${m}[-] ${p}Nama file RAR tidak boleh kosong.${r}"
					continue
				fi

				# kondisi jika file rar tidak ditemukan
				if [[ ! -f "${nama_file_rar_john}" ]]; then
					echo -e "${m}[-] ${p}File RAR '${nama_file_rar_john}' tidak ditemukan.${r}"
					continue
				fi

				# kondisi jika file bukan file rar
				if [[ "${nama_file_rar_john##*.}" != "rar" ]]; then
					echo -e "${m}[-] ${p}File '${nama_file_rar_john}' bukan file RAR.${r}"
					continue
				fi

				# kondisi jika file rar ditemukan
				echo -e "${h}[+] ${p}File RAR '${nama_file_rar_john}' ditemukan.${r}"
				break
			done


			while true; do
				read -p $'\e[1;37mMasukkan nama file hash dari file RAR: \e[1;33m' nama_file_hash_dari_file_rar_john
				if [[ -z "${nama_file_hash_dari_file_rar_john}" ]]; then
					echo -e "${m}[-] ${p}Nama file hash tidak boleh kosong.${r}"
					continue
				else
					if [[ ! -f "${nama_file_hash_dari_file_rar_john}" ]]; then
						echo -e "${m}[-] ${p}File hash '${nama_file_hash_dari_file_rar_john}' tidak ditemukan.${r}"
						continue
					else
						if [[ "${nama_file_hash_dari_file_rar_john##*.}" == "john" ]]; then
							if [[ $(cat "${nama_file_hash_dari_file_rar_john}" | grep -o "rar5") ]]; then
								echo -e "${h}[+] ${p}File hash '${nama_file_hash_dari_file_rar_john}' ditemukan.${r}"
								while true; do
									read -p $'\e[1;37mMasukkan nama file Wordlist: \e[1;33m' nama_file_wordlist_rar_john
									if [[ -z "${nama_file_wordlist_rar_john}" ]]; then
										echo -e "${m}[-] ${p}Nama file Wordlist tidak boleh kosong.${r}"
										continue
									else
										if [[ ! -f "${nama_file_wordlist_rar_john}" ]]; then
											echo -e "${m}[-] ${p}File Wordlist '${nama_file_wordlist_rar_john}' tidak ditemukan.${r}"
											continue
										else
											echo -e "${h}[+] ${p}File Wordlist '${nama_file_wordlist_rar_john}' ditemukan.${r}"
											pot_rar_john="pot_rar_john.txt"
											while true; do
												read -p $'\e[1;37mApakah Anda ingin menggunakan mode verbose (iya/tidak): \e[1;33m' nanya_verbose_rar_john
												if [[ "${nanya_verbose_rar_john}" == "iya" ]]; then
													read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai prosres cracking.\e[0m'
													echo -e "${b}[*] ${p}Cracking kata sandi file RAR '${nama_file_rar_john}' dengan John...${r}"
													john --wordlist="${nama_file_wordlist_rar_john}" --pot="${pot_rar_john}" --verbosity=6 --progress-every=1 "${nama_file_hash_dari_file_rar_john}"
													if [[ -f "${pot_rar_john}" ]]; then
														if [[ $(cat "${pot_rar_john}" | grep -o ":") ]]; then
															kata_sandi_rar_john=$(cat "${pot_rar_john}" | cut -d ":" -f 2)
															echo -e "${h}[+] ${p}Kata sandi ditemukan.${r}"
															echo -e "${h}[+] ${p}Kata sandi: ${h}${kata_sandi_rar_john}${r}"
															rm "${pot_rar_john}"
														else
															echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
															echo -e "${m}[-] ${p}Coba gunakan Wordlist yang lain.${r}"
														fi
														break
													else
														echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
														echo -e "${m}[-] ${p}File pot John tidak ditemukan.${r}"
													fi
													break
	
												elif [[ "${nanya_verbose_rar_john}" == "tidak" ]]; then
													read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai prosres cracking.\e[0m'
													echo -e "${b}[*] ${p}Cracking kata sandi file RAR '${nama_file_rar_john}' dengan John...${r}"
													john --wordlist="${nama_file_wordlist_rar_john}" --pot="${pot_rar_john}" "${nama_file_hash_dari_file_rar_john}" > /dev/null 2>&1
													if [[ -f "${pot_rar_john}" ]]; then
														if [[ $(cat "${pot_rar_john}" | grep -o ":") ]]; then
															kata_sandi_rar_john=$(cat "${pot_rar_john}" | cut -d ":" -f 2)
															echo -e "${h}[+] ${p}Kata sandi ditemukan.${r}"
															echo -e "${h}[+] ${p}Kata sandi: ${h}${kata_sandi_rar_john}${r}"
															rm "${pot_rar_john}"
														else
															echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
															echo -e "${m}[-] ${p}Coba gunakan Wordlist yang lain.${r}"
														fi	
														break
													else
														echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
														echo -e "${m}[-] ${p}File pot John tidak ditemukan.${r}"
													fi
													break
												else
													echo -e "${m}[-] ${p}Masukkan tidak valid. Harap masukkan 'iya' atau 'tidak'.${r}"
													continue
												fi
											done	
										fi
										break
									fi
									break
								done
							else
								echo -e "${m}[-] ${p}Format hash file hash '${nama_file_hash_dari_file_rar_john}' tidak valid.${r}"
								continue
							fi
						else
							echo -e "${m}[-] ${p}File '${nama_file_hash_dari_file_rar_john}' bukan file hash.${r}"
							continue
						fi
					fi
				fi
				break
			done


		fi
        	read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk kembali ke menu utama.\e[0m'

	elif [[ "${pilih_menu}" == "8" ]]; then
		target_hash_7z_john="${nama_file_hash_file_7z_john}"
		if [[ -f "${target_hash_7z_john}" ]]; then
			echo -e "${b}[*] ${p}Pada sesi ini Anda sudah memiliki file hash dari file 7z '${nama_file_7z}' (${h}${target_hash_7z_john}${p}).${r}"
			while true; do
				read -p $'\e[1;37mApakah Anda ingin menggunakannya (iya/tidak): \e[1;33m' nanya_7z_john
				if [[ "${nanya_7z_john}" == "iya" ]]; then
					while true; do
						read -p $'\e[1;37mMasukkan nama file Wordlist: \e[1;33m' nama_file_wordlist_7z_john
						if [[ -z "${nama_file_wordlist_7z_john}" ]]; then
							echo -e "${m}[-] ${p}Nama file Wordlist tidak boleh kosong.${r}"
							continue
						else
							if [[ ! -f "${nama_file_wordlist_7z_john}" ]]; then
								echo -e "${m}[-] ${p}File Wordlist '${nama_file_wordlist_7z_john}' tidak ditemukan.${r}"
								continue
							else
								echo -e "${h}[+] ${p}File Wordlist '${nama_file_wordlist_7z_john}' ditemukan.${r}"
								pot_7z_john="pot_7z_john.txt"
								while true; do
									read -p $'\e[1;37mApakah Anda ingin menggunakan mode verbose (iya/tidak): \e[1;33m' nanya_verbose_7z_john
									if [[ "${nanya_verbose_7z_john}" == "iya" ]]; then
										read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai prosres cracking.\e[0m'
										echo -e "${b}[*] ${p}Cracking kata sandi file 7z '${nama_file_7z}' dengan John...${r}"
										john --wordlist="${nama_file_wordlist_7z_john}" --pot="${pot_7z_john}" --verbosity=6 --progress-every=1 "${target_hash_7z_john}"
										if [[ -f "${pot_7z_john}" ]]; then
											if [[ $(cat "${pot_7z_john}" | grep -o ":") ]]; then
												kata_sandi_7z_john=$(cat "${pot_7z_john}" | cut -d ":" -f 2)
												echo -e "${h}[+] ${p}Kata sandi ditemukan.${r}"
												echo -e "${h}[+] ${p}Kata sandi: ${h}${kata_sandi_7z_john}${r}"
												rm "${pot_7z_john}"
											else
												echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
												echo -e "${m}[-] ${p}Coba gunakan Wordlist yang lain.${r}"
											fi
											break
										else
											echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
											echo -e "${m}[-] ${p}File pot John tidak ditemukan.${r}"
										fi
										break

									elif [[ "${nanya_verbose_7z_john}" == "tidak" ]]; then
										read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai prosres cracking.\e[0m'
										echo -e "${b}[*] ${p}Cracking kata sandi file 7z '${nama_file_7z}' dengan John...${r}"
										john --wordlist="${nama_file_wordlist_7z_john}" --pot="${pot_7z_john}" "${target_hash_7z_john}" > /dev/null 2>&1
										if [[ -f "${pot_7z_john}" ]]; then
											if [[ $(cat "${pot_7z_john}" | grep -o ":") ]]; then
												kata_sandi_7z_john=$(cat "${pot_7z_john}" | cut -d ":" -f 2)
												echo -e "${h}[+] ${p}Kata sandi ditemukan.${r}"
												echo -e "${h}[+] ${p}Kata sandi: ${h}${kata_sandi_7z_john}${r}"
												rm "${pot_7z_john}"
											else
												echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
												echo -e "${m}[-] ${p}Coba gunakan Wordlist yang lain.${r}"
											fi
											break
										else
											echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
											echo -e "${m}[-] ${p}File pot John tidak ditemukan.${r}"
										fi
										break
									else
										echo -e "${m}[-] ${p}Masukkan tidak valid. Harap masukkan 'iya' atau 'tidak'.${r}"
										continue
									fi
								done
							fi
							break
						fi
						break
					done
					break
				elif [[ "${nanya_7z_john}" == "tidak" ]]; then
					while true; do
						read -p $'\e[1;37mMasukkan nama file hash dari file 7z: \e[1;33m' nama_file_hash_dari_file_7z_john
						if [[ -z "${nama_file_hash_dari_file_7z_john}" ]]; then
							echo -e "${m}[-] ${p}Nama file hash tidak boleh kosong.${r}"
							continue
						else
							if [[ ! -f "${nama_file_hash_dari_file_7z_john}" ]]; then
								echo -e "${m}[-] ${p}File hash '${nama_file_hash_dari_file_7z_john}' tidak ditemukan.${r}"
								continue
							else
								if [[ "${nama_file_hash_dari_file_7z_john##*.}" == "john" ]]; then
									if [[ $(cat "${nama_file_hash_dari_file_7z_john}" | grep -o "7z") ]]; then
										echo -e "${h}[+] ${p}File hash '${nama_file_hash_dari_file_7z_john}' ditemukan.${r}"
										while true; do
											read -p $'\e[1;37mMasukkan nama file Wordlist: \e[1;33m' nama_file_wordlist_7z_john
											if [[ -z "${nama_file_wordlist_7z_john}" ]]; then
												echo -e "${m}[-] ${p}Nama file Wordlist tidak boleh kosong.${r}"
												continue
											else
												if [[ ! -f "${nama_file_wordlist_7z_john}" ]]; then
													echo -e "${m}[-] ${p}File Wordlist '${nama_file_wordlist_7z_john}' tidak ditemukan.${r}"
													continue
												else
													echo -e "${h}[+] ${p}File Wordlist '${nama_file_wordlist_7z_john}' ditemukan.${r}"
													pot_7z_john="pot_7z_john.txt"
													while true; do
														read -p $'\e[1;37mApakah Anda ingin menggunakan mode verbose (iya/tidak): \e[1;33m' nanya_verbose_7z_john
														if [[ "${nanya_verbose_7z_john}" == "iya" ]]; then
															read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai prosres cracking.\e[0m'
															echo -e "${b}[*] ${p}Cracking kata sandi file 7z '${nama_file_7z}' dengan John...${r}"
															john --wordlist="${nama_file_wordlist_7z_john}" --pot="${pot_7z_john}" --verbosity=6 --progress-every=1 "${target_hash_7z_john}"
															if [[ -f "${pot_7z_john}" ]]; then
																if [[ $(cat "${pot_7z_john}" | grep -o ":") ]]; then
																	kata_sandi_7z_john=$(cat "${pot_7z_john}" | cut -d ":" -f 2)
																	echo -e "${h}[+] ${p}Kata sandi ditemukan.${r}"
																	echo -e "${h}[+] ${p}Kata sandi: ${h}${kata_sandi_7z_john}${r}"
																	rm "${pot_7z_john}"
																else
																	echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
																	echo -e "${m}[-] ${p}Coba gunakan Wordlist yang lain.${r}"
																fi
																break
															else
																echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
																echo -e "${m}[-] ${p}File pot John tidak ditemukan.${r}"
															fi
															break
	
														elif [[ "${nanya_verbose_7z_john}" == "tidak" ]]; then
															read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai prosres cracking.\e[0m'
															echo -e "${b}[*] ${p}Cracking kata sandi file 7z '${nama_file_7z}' dengan John...${r}"
															john --wordlist="${nama_file_wordlist_7z_john}" --pot="${pot_7z_john}" "${target_hash_7z_john}" > /dev/null 2>&1
															if [[ -f "${pot_7z_john}" ]]; then
																if [[ $(cat "${pot_7z_john}" | grep -o ":") ]]; then
																	kata_sandi_7z_john=$(cat "${pot_7z_john}" | cut -d ":" -f 2)
																	echo -e "${h}[+] ${p}Kata sandi ditemukan.${r}"
																	echo -e "${h}[+] ${p}Kata sandi: ${h}${kata_sandi_7z_john}${r}"
																	rm "${pot_7z_john}"
																else
																	echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
																	echo -e "${m}[-] ${p}Coba gunakan Wordlist yang lain.${r}"
																fi
																break
															else
																echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
																echo -e "${m}[-] ${p}File pot John tidak ditemukan.${r}"
															fi
															break
														else
															echo -e "${m}[-] ${p}Masukkan tidak valid. Harap masukkan 'iya' atau 'tidak'.${r}"
															continue
														fi
													done
												fi
												break
											fi
											break
										done
									else
										echo -e "${m}[-] ${p}Format hash file hash '{nama_file_hash_dari_file_7z_john}' tidak valid.${r}"
										continue
									fi
								else
									echo -e "${m}[-] ${p}File '${nama_file_hash_dari_file_7z_john}' bukan file hash.${r}"
									continue
								fi

							fi
						fi
						break
					done
					break
				else
					echo -e "${m}[-] ${p}Masukkan tidak valid. Harap masukkan 'iya' atau 'tidak'.${r}"
					continue
				fi
			done

		else


			# memasukkan nama file 7z
			while true; do
				read -p $'\e[1;37mMasukkan nama file 7z: \e[1;33m' nama_file_7z_john

				# kondisi jika nama file 7z kosong
				if [[ -z "${nama_file_7z_john}" ]]; then
					echo -e "${m}[-] ${p}Nama file 7z tidak boleh kosong.${r}"
					continue
				fi

				# kondisi jika file 7z tidak ditemukan
				if [[ ! -f "${nama_file_7z_john}" ]]; then
					echo -e "${m}[-] ${p}File 7z '${nama_file_7z_john}' tidak ditemukan.${r}"
					continue
				fi

				# kondisi jika file bukan file 7z
				if [[ "${nama_file_7z_john##*.}" != "7z" ]]; then
					echo -e "${m}[-] ${p}File '${nama_file_7z_john}' bukan file 7z.${r}"
					continue
				fi

				# kondisi jika file 7z ditemukan
				echo -e "${h}[+] ${p}File 7z '${nama_file_7z_john}' ditemukan.${r}"
				break
			done

			while true; do
				read -p $'\e[1;37mMasukkan nama file hash dari file 7z: \e[1;33m' nama_file_hash_dari_file_7z_john
				if [[ -z "${nama_file_hash_dari_file_7z_john}" ]]; then
					echo -e "${m}[-] ${p}Nama file hash tidak boleh kosong.${r}"
					continue
				else
					if [[ ! -f "${nama_file_hash_dari_file_7z_john}" ]]; then
						echo -e "${m}[-] ${p}File hash '${nama_file_hash_dari_file_7z_john}' tidak ditemukan.${r}"
						continue
					else
						if [[ "${nama_file_hash_dari_file_7z_john##*.}" == "john" ]]; then
							if [[ $(cat "${nama_file_hash_dari_file_7z_john}" | grep -o "7z") ]]; then
								echo -e "${h}[+] ${p}File hash '${nama_file_hash_dari_file_7z_john}' ditemukan.${r}"
								while true; do
									read -p $'\e[1;37mMasukkan nama file Wordlist: \e[1;33m' nama_file_wordlist_7z_john
									if [[ -z "${nama_file_wordlist_7z_john}" ]]; then
										echo -e "${m}[-] ${p}Nama file Wordlist tidak boleh kosong.${r}"
										continue
									else
										if [[ ! -f "${nama_file_wordlist_7z_john}" ]]; then
											echo -e "${m}[-] ${p}File Wordlist '${nama_file_wordlist_7z_john}' tidak ditemukan.${r}"
											continue
										else
											echo -e "${h}[+] ${p}File Wordlist '${nama_file_wordlist_7z_john}' ditemukan.${r}"
											pot_7z_john="pot_7z_john.txt"
											while true; do
												read -p $'\e[1;37mApakah Anda ingin menggunakan mode verbose (iya/tidak): \e[1;33m' nanya_verbose_7z_john
												if [[ "${nanya_verbose_7z_john}" == "iya" ]]; then
													read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai prosres cracking.\e[0m'
													echo -e "${b}[*] ${p}Cracking kata sandi file 7z '${nama_file_7z_john}' dengan John...${r}"
													john --wordlist="${nama_file_wordlist_7z_john}" --pot="${pot_7z_john}" --verbosity=6 --progress-every=1 "${nama_file_hash_dari_file_7z_john}"
													if [[ -f "${pot_7z_john}" ]]; then
														if [[ $(cat "${pot_7z_john}" | grep -o ":") ]]; then
															kata_sandi_7z_john=$(cat "${pot_7z_john}" | cut -d ":" -f 2)
															echo -e "${h}[+] ${p}Kata sandi ditemukan.${r}"
															echo -e "${h}[+] ${p}Kata sandi: ${h}${kata_sandi_7z_john}${r}"
															rm "${pot_7z_john}"
														else
															echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
															echo -e "${m}[-] ${p}Coba gunakan Wordlist yang lain.${r}"
														fi
														break
													else
														echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
														echo -e "${m}[-] ${p}File pot John tidak ditemukan.${r}"
													fi
													break
	
												elif [[ "${nanya_verbose_7z_john}" == "tidak" ]]; then
													read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai prosres cracking.\e[0m'
													echo -e "${b}[*] ${p}Cracking kata sandi file 7z '${nama_file_7z_john}' dengan John...${r}"
													john --wordlist="${nama_file_wordlist_7z_john}" --pot="${pot_7z_john}" "${nama_file_hash_dari_file_7z_john}" > /dev/null 2>&1
													if [[ -f "${pot_7z_john}" ]]; then
														if [[ $(cat "${pot_7z_john}" | grep -o ":") ]]; then
															kata_sandi_7z_john=$(cat "${pot_7z_john}" | cut -d ":" -f 2)
															echo -e "${h}[+] ${p}Kata sandi ditemukan.${r}"
															echo -e "${h}[+] ${p}Kata sandi: ${h}${kata_sandi_7z_john}${r}"
															rm "${pot_7z_john}"
														else
															echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
															echo -e "${m}[-] ${p}Coba gunakan Wordlist yang lain.${r}"
														fi
														break
													else
														echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
														echo -e "${m}[-] ${p}File pot John tidak ditemukan.${r}"
													fi
													break
												else
													echo -e "${m}[-] ${p}Masukkan tidak valid. Harap masukkan 'iya' atau 'tidak'.${r}"
													continue
												fi
											done
										fi
										break
									fi
									break
								done
							else
								echo -e "${m}[-] ${p}Format hash file hash '${nama_file_hash_dari_file_7z_john}' tidak valid.${r}"
								continue
							fi
						else
							echo -e "${m}[-] ${p}File '${nama_file_hash_dari_file_7z_john}' bukan file hash.${r}"
							continue
						fi
					fi
				fi
				break
			done


		fi
        	read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk kembali ke menu utama.\e[0m'


	elif [[ "${pilih_menu}" == "9" ]]; then
		target_hash_pdf_john="${nama_file_hash_file_pdf_john}"
		if [[ -f "${target_hash_pdf_john}" ]]; then
			echo -e "${b}[*] ${p}Pada sesi ini Anda sudah memiliki file hash dari file PDF '${nama_file_pdf}' (${h}${target_hash_pdf_john}${p}).${r}"
			while true; do
				read -p $'\e[1;37mApakah Anda ingin menggunakannya (iya/tidak): \e[1;33m' nanya_pdf_john
				if [[ "${nanya_pdf_john}" == "iya" ]]; then
					while true; do
						read -p $'\e[1;37mMasukkan nama file Wordlist: \e[1;33m' nama_file_wordlist_pdf_john
						if [[ -z "${nama_file_wordlist_pdf_john}" ]]; then
							echo -e "${m}[-] ${p}Nama file Wordlist tidak boleh kosong.${r}"
							continue
						else
							if [[ ! -f "${nama_file_wordlist_pdf_john}" ]]; then
								echo -e "${m}[-] ${p}File Wordlist '${nama_file_wordlist_pdf_john}' tidak ditemukan.${r}"
								continue
							else
								echo -e "${h}[+] ${p}File Wordlist '${nama_file_wordlist_pdf_john}' ditemukan.${r}"
								pot_pdf_john="pot_pdf_john.txt"
								while true; do
									read -p $'\e[1;37mApakah Anda ingin menggunakan mode verbose (iya/tidak): \e[1;33m' nanya_verbose_pdf_john
									if [[ "${nanya_verbose_pdf_john}" == "iya" ]]; then
										read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai prosres cracking.\e[0m'
										echo -e "${b}[*] ${p}Cracking kata sandi file PDF '${nama_file_pdf}' dengan John...${r}"
										john --wordlist="${nama_file_wordlist_pdf_john}" --pot="${pot_pdf_john}" --verbosity=6 --progress-every=1 "${target_hash_pdf_john}"
										if [[ -f "${pot_pdf_john}" ]]; then
											if [[ $(cat "${pot_pdf_john}" | grep -o ":") ]]; then
												kata_sandi_pdf_john=$(cat "${pot_pdf_john}" | cut -d ":" -f 2)
												echo -e "${h}[+] ${p}Kata sandi ditemukan.${r}"
												echo -e "${h}[+] ${p}Kata sandi: ${h}${kata_sandi_pdf_john}${r}"
												rm "${pot_pdf_john}"
											else
												echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
												echo -e "${m}[-] ${p}Coba gunakan Wordlist yang lain.${r}"
											fi
											break
										else
											echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
											echo -e "${m}[-] ${p}File pot John tidak ditemukan.${r}"
										fi
										break

									elif [[ "${nanya_verbose_pdf_john}" == "tidak" ]]; then
										read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai prosres cracking.\e[0m'
										echo -e "${b}[*] ${p}Cracking kata sandi file PDF '${nama_file_pdf}' dengan John...${r}"
										john --wordlist="${nama_file_wordlist_pdf_john}" --pot="${pot_pdf_john}" "${target_hash_pdf_john}" > /dev/null 2>&1
										if [[ -f "${pot_pdf_john}" ]]; then
											if [[ $(cat "${pot_pdf_john}" | grep -o ":") ]]; then
												kata_sandi_pdf_john=$(cat "${pot_pdf_john}" | cut -d ":" -f 2)
												echo -e "${h}[+] ${p}Kata sandi ditemukan.${r}"
												echo -e "${h}[+] ${p}Kata sandi: ${h}${kata_sandi_pdf_john}${r}"
												rm "${pot_pdf_john}"
											else
												echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
												echo -e "${m}[-] ${p}Coba gunakan Wordlist yang lain.${r}"
											fi
											break
										else
											echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
											echo -e "${m}[-] ${p}File pot John tidak ditemukan.${r}"
										fi
										break
									else
										echo -e "${m}[-] ${p}Masukkan tidak valid. Harap masukkan 'iya' atau 'tidak'.${r}"
										continue
									fi
								done
							fi
							break
						fi
						break
					done
					break
				elif [[ "${nanya_pdf_john}" == "tidak" ]]; then
					while true; do
						read -p $'\e[1;37mMasukkan nama file hash dari file PDF: \e[1;33m' nama_file_hash_dari_file_pdf_john
						if [[ -z "${nama_file_hash_dari_file_pdf_john}" ]]; then
							echo -e "${m}[-] ${p}Nama file hash tidak boleh kosong.${r}"
							continue
						else
							if [[ ! -f "${nama_file_hash_dari_file_pdf_john}" ]]; then
								echo -e "${m}[-] ${p}File hash '${nama_file_hash_dari_file_pdf_john}' tidak ditemukan.${r}"
								continue
							else
								if [[ "${nama_file_hash_dari_file_pdf_john##*.}" == "john" ]]; then
									if [[ $(cat "${nama_file_hash_dari_file_pdf_john}" | grep -o "pdf") ]]; then
										echo -e "${h}[+] ${p}File hash '${nama_file_hash_dari_file_pdf_john}' ditemukan.${r}"
										while true; do
											read -p $'\e[1;37mMasukkan nama file Wordlist: \e[1;33m' nama_file_wordlist_pdf_john
											if [[ -z "${nama_file_wordlist_pdf_john}" ]]; then
												echo -e "${m}[-] ${p}Nama file Wordlist tidak boleh kosong.${r}"
												continue
											else
												if [[ ! -f "${nama_file_wordlist_pdf_john}" ]]; then
													echo -e "${m}[-] ${p}File Wordlist '${nama_file_wordlist_pdf_john}' tidak ditemukan.${r}"
													continue
												else
													echo -e "${h}[+] ${p}File Wordlist '${nama_file_wordlist_pdf_john}' ditemukan.${r}"
													pot_pdf_john="pot_pdf_john.txt"
													while true; do
														read -p $'\e[1;37mApakah Anda ingin menggunakan mode verbose (iya/tidak): \e[1;33m' nanya_verbose_pdf_john
														if [[ "${nanya_verbose_pdf_john}" == "iya" ]]; then
															read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai prosres cracking.\e[0m'
															echo -e "${b}[*] ${p}Cracking kata sandi file PDF '${nama_file_pdf}' dengan John...${r}"
															john --wordlist="${nama_file_wordlist_pdf_john}" --pot="${pot_pdf_john}" --verbosity=6 --progress-every=1 "${target_hash_pdf_john}"
															if [[ -f "${pot_pdf_john}" ]]; then
																if [[ $(cat "${pot_pdf_john}" | grep -o ":") ]]; then
																	kata_sandi_pdf_john=$(cat "${pot_pdf_john}" | cut -d ":" -f 2)
																	echo -e "${h}[+] ${p}Kata sandi ditemukan.${r}"
																	echo -e "${h}[+] ${p}Kata sandi: ${h}${kata_sandi_pdf_john}${r}"
																	rm "${pot_pdf_john}"
																else
																	echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
																	echo -e "${m}[-] ${p}Coba gunakan Wordlist yang lain.${r}"
																fi
																break
															else
																echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
																echo -e "${m}[-] ${p}File pot John tidak ditemukan.${r}"
															fi
															break
	
														elif [[ "${nanya_verbose_pdf_john}" == "tidak" ]]; then
															read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai prosres cracking.\e[0m'
															echo -e "${b}[*] ${p}Cracking kata sandi file PDF '${nama_file_pdf}' dengan John...${r}"
															john --wordlist="${nama_file_wordlist_pdf_john}" --pot="${pot_pdf_john}" "${target_hash_pdf_john}" > /dev/null 2>&1
															if [[ -f "${pot_pdf_john}" ]]; then
																if [[ $(cat "${pot_pdf_john}" | grep -o ":") ]]; then
																	kata_sandi_pdf_john=$(cat "${pot_pdf_john}" | cut -d ":" -f 2)
																	echo -e "${h}[+] ${p}Kata sandi ditemukan.${r}"
																	echo -e "${h}[+] ${p}Kata sandi: ${h}${kata_sandi_pdf_john}${r}"
																	rm "${pot_pdf_john}"
																else
																	echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
																	echo -e "${m}[-] ${p}Coba gunakan Wordlist yang lain.${r}"
																fi
																break
															else
																echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
																echo -e "${m}[-] ${p}File pot John tidak ditemukan.${r}"
															fi
															break
														else
															echo -e "${m}[-] ${p}Masukkan tidak valid. Harap masukkan 'iya' atau 'tidak'.${r}"
															continue
														fi
													done
												fi
												break
											fi
											break
										done
									else
										echo -e "${m}[-] ${p}Format hash file hash '{nama_file_hash_dari_file_pdf_john}' tidak valid.${r}"
										continue
									fi
								else
									echo -e "${m}[-] ${p}File '${nama_file_hash_dari_file_pdf_john}' bukan file hash.${r}"
									continue
								fi

							fi
						fi
						break
					done
					break
				else
					echo -e "${m}[-] ${p}Masukkan tidak valid. Harap masukkan 'iya' atau 'tidak'.${r}"
					continue
				fi
			done

		else


			# memasukkan nama file pdf
			while true; do
				read -p $'\e[1;37mMasukkan nama file PDF: \e[1;33m' nama_file_pdf_john

				# kondisi jika nama file pdf kosong
				if [[ -z "${nama_file_pdf_john}" ]]; then
					echo -e "${m}[-] ${p}Nama file PDF tidak boleh kosong.${r}"
					continue
				fi

				# kondisi jika file pdf tidak ditemukan
				if [[ ! -f "${nama_file_pdf_john}" ]]; then
					echo -e "${m}[-] ${p}File PDF '${nama_file_pdf_john}' tidak ditemukan.${r}"
					continue
				fi

				# kondisi jika file bukan file pdf
				if [[ "${nama_file_pdf_john##*.}" != "pdf" ]]; then
					echo -e "${m}[-] ${p}File '${nama_file_pdf_john}' bukan file PDF.${r}"
					continue
				fi

				# kondisi jika file pdf ditemukan
				echo -e "${h}[+] ${p}File PDF '${nama_file_pdf_john}' ditemukan.${r}"
				break
			done


			while true; do
				read -p $'\e[1;37mMasukkan nama file hash dari file PDF: \e[1;33m' nama_file_hash_dari_file_pdf_john
				if [[ -z "${nama_file_hash_dari_file_pdf_john}" ]]; then
					echo -e "${m}[-] ${p}Nama file hash tidak boleh kosong.${r}"
					continue
				else
					if [[ ! -f "${nama_file_hash_dari_file_pdf_john}" ]]; then
						echo -e "${m}[-] ${p}File hash '${nama_file_hash_dari_file_pdf_john}' tidak ditemukan.${r}"
						continue
					else
						if [[ "${nama_file_hash_dari_file_pdf_john##*.}" == "john" ]]; then
							if [[ $(cat "${nama_file_hash_dari_file_pdf_john}" | grep -o "pdf") ]]; then
								echo -e "${h}[+] ${p}File hash '${nama_file_hash_dari_file_pdf_john}' ditemukan.${r}"
								while true; do
									read -p $'\e[1;37mMasukkan nama file Wordlist: \e[1;33m' nama_file_wordlist_pdf_john
									if [[ -z "${nama_file_wordlist_pdf_john}" ]]; then
										echo -e "${m}[-] ${p}Nama file Wordlist tidak boleh kosong.${r}"
										continue
									else
										if [[ ! -f "${nama_file_wordlist_pdf_john}" ]]; then
											echo -e "${m}[-] ${p}File Wordlist '${nama_file_wordlist_pdf_john}' tidak ditemukan.${r}"
											continue
										else
											echo -e "${h}[+] ${p}File Wordlist '${nama_file_wordlist_pdf_john}' ditemukan.${r}"
											pot_pdf_john="pot_pdf_john.txt"
											while true; do
												read -p $'\e[1;37mApakah Anda ingin menggunakan mode verbose (iya/tidak): \e[1;33m' nanya_verbose_pdf_john
												if [[ "${nanya_verbose_pdf_john}" == "iya" ]]; then
													read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai prosres cracking.\e[0m'
													echo -e "${b}[*] ${p}Cracking kata sandi file PDF '${nama_file_pdf_john}' dengan John...${r}"
													john --wordlist="${nama_file_wordlist_pdf_john}" --pot="${pot_pdf_john}" --verbosity=6 --progress-every=1 "${nama_file_hash_dari_file_pdf_john}"
													if [[ -f "${pot_pdf_john}" ]]; then
														if [[ $(cat "${pot_pdf_john}" | grep -o ":") ]]; then
															kata_sandi_pdf_john=$(cat "${pot_pdf_john}" | cut -d ":" -f 2)
															echo -e "${h}[+] ${p}Kata sandi ditemukan.${r}"
															echo -e "${h}[+] ${p}Kata sandi: ${h}${kata_sandi_pdf_john}${r}"
															rm "${pot_pdf_john}"
														else
															echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
															echo -e "${m}[-] ${p}Coba gunakan Wordlist yang lain.${r}"
														fi
														break
													else
														echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
														echo -e "${m}[-] ${p}File pot John tidak ditemukan.${r}"
													fi
													break
	
												elif [[ "${nanya_verbose_pdf_john}" == "tidak" ]]; then
													read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai prosres cracking.\e[0m'
													echo -e "${b}[*] ${p}Cracking kata sandi file PDF '${nama_file_pdf_john}' dengan John...${r}"
													john --wordlist="${nama_file_wordlist_pdf_john}" --pot="${pot_pdf_john}" "${nama_file_hash_dari_file_pdf_john}" > /dev/null 2>&1
													if [[ -f "${pot_pdf_john}" ]]; then
														if [[ $(cat "${pot_pdf_john}" | grep -o ":") ]]; then
															kata_sandi_pdf_john=$(cat "${pot_pdf_john}" | cut -d ":" -f 2)
															echo -e "${h}[+] ${p}Kata sandi ditemukan.${r}"
															echo -e "${h}[+] ${p}Kata sandi: ${h}${kata_sandi_pdf_john}${r}"
															rm "${pot_pdf_john}"
														else
															echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
															echo -e "${m}[-] ${p}Coba gunakan Wordlist yang lain.${r}"
														fi	
														break
													else
														echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
														echo -e "${m}[-] ${p}File pot John tidak ditemukan.${r}"
													fi
													break
												else
													echo -e "${m}[-] ${p}Masukkan tidak valid. Harap masukkan 'iya' atau 'tidak'.${r}"
													continue
												fi
											done	
										fi
										break
									fi
									break
								done
							else
								echo -e "${m}[-] ${p}Format hash file hash '${nama_file_hash_dari_file_pdf_john}' tidak valid.${r}"
								continue
							fi
						else
							echo -e "${m}[-] ${p}File '${nama_file_hash_dari_file_pdf_john}' bukan file hash.${r}"
							continue
						fi
					fi
				fi
				break
			done


		fi
        	read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk kembali ke menu utama.\e[0m'

	elif [[ "${pilih_menu}" == "10" ]]; then
		target_hash_office_john="${nama_file_hash_file_office_john}"
		if [[ -f "${target_hash_office_john}" ]]; then
			echo -e "${b}[*] ${p}Pada sesi ini Anda sudah memiliki file hash dari file Office '${nama_file_office}' (${h}${target_hash_office_john}${p}).${r}"
			while true; do
				read -p $'\e[1;37mApakah Anda ingin menggunakannya (iya/tidak): \e[1;33m' nanya_office_john
				if [[ "${nanya_office_john}" == "iya" ]]; then
					while true; do
						read -p $'\e[1;37mMasukkan nama file Wordlist: \e[1;33m' nama_file_wordlist_office_john
						if [[ -z "${nama_file_wordlist_office_john}" ]]; then
							echo -e "${m}[-] ${p}Nama file Wordlist tidak boleh kosong.${r}"
							continue
						else
							if [[ ! -f "${nama_file_wordlist_office_john}" ]]; then
								echo -e "${m}[-] ${p}File Wordlist '${nama_file_wordlist_office_john}' tidak ditemukan.${r}"
								continue
							else
								echo -e "${h}[+] ${p}File Wordlist '${nama_file_wordlist_office_john}' ditemukan.${r}"
								pot_office_john="pot_office_john.txt"
								while true; do
									read -p $'\e[1;37mApakah Anda ingin menggunakan mode verbose (iya/tidak): \e[1;33m' nanya_verbose_office_john
									if [[ "${nanya_verbose_office_john}" == "iya" ]]; then
										read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai prosres cracking.\e[0m'
										echo -e "${b}[*] ${p}Cracking kata sandi file Office '${nama_file_office}' dengan John...${r}"
										john --wordlist="${nama_file_wordlist_office_john}" --pot="${pot_office_john}" --verbosity=6 --progress-every=1 "${target_hash_office_john}"
										if [[ -f "${pot_office_john}" ]]; then
											if [[ $(cat "${pot_office_john}" | grep -o ":") ]]; then
												kata_sandi_office_john=$(cat "${pot_office_john}" | cut -d ":" -f 2)
												echo -e "${h}[+] ${p}Kata sandi ditemukan.${r}"
												echo -e "${h}[+] ${p}Kata sandi: ${h}${kata_sandi_office_john}${r}"
												rm "${pot_office_john}"
											else
												echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
												echo -e "${m}[-] ${p}Coba gunakan Wordlist yang lain.${r}"
											fi
											break
										else
											echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
											echo -e "${m}[-] ${p}File pot John tidak ditemukan.${r}"
										fi
										break

									elif [[ "${nanya_verbose_office_john}" == "tidak" ]]; then
										read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai prosres cracking.\e[0m'
										echo -e "${b}[*] ${p}Cracking kata sandi file Office '${nama_file_office}' dengan John...${r}"
										john --wordlist="${nama_file_wordlist_office_john}" --pot="${pot_office_john}" "${target_hash_office_john}" > /dev/null 2>&1
										if [[ -f "${pot_office_john}" ]]; then
											if [[ $(cat "${pot_office_john}" | grep -o ":") ]]; then
												kata_sandi_office_john=$(cat "${pot_office_john}" | cut -d ":" -f 2)
												echo -e "${h}[+] ${p}Kata sandi ditemukan.${r}"
												echo -e "${h}[+] ${p}Kata sandi: ${h}${kata_sandi_office_john}${r}"
												rm "${pot_office_john}"
											else
												echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
												echo -e "${m}[-] ${p}Coba gunakan Wordlist yang lain.${r}"
											fi
											break
										else
											echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
											echo -e "${m}[-] ${p}File pot John tidak ditemukan.${r}"
										fi
										break
									else
										echo -e "${m}[-] ${p}Masukkan tidak valid. Harap masukkan 'iya' atau 'tidak'.${r}"
										continue
									fi	
								done
							fi
							break
						fi
						break
					done
					break
				elif [[ "${nanya_office_john}" == "tidak" ]]; then
					while true; do
						read -p $'\e[1;37mMasukkan nama file hash dari file Office: \e[1;33m' nama_file_hash_dari_file_office_john
						if [[ -z "${nama_file_hash_dari_file_office_john}" ]]; then
							echo -e "${m}[-] ${p}Nama file hash tidak boleh kosong.${r}"
							continue
						else
							if [[ ! -f "${nama_file_hash_dari_file_office_john}" ]]; then
								echo -e "${m}[-] ${p}File hash '${nama_file_hash_dari_file_office_john}' tidak ditemukan.${r}"
								continue
							else
								if [[ "${nama_file_hash_dari_file_office_john##*.}" == "john" ]]; then
									if [[ $(cat "${nama_file_hash_dari_file_office_john}" | grep -o "office") ]]; then
										echo -e "${h}[+] ${p}File hash '${nama_file_hash_dari_file_office_john}' ditemukan.${r}"
										while true; do
											read -p $'\e[1;37mMasukkan nama file Wordlist: \e[1;33m' nama_file_wordlist_office_john
											if [[ -z "${nama_file_wordlist_office_john}" ]]; then
												echo -e "${m}[-] ${p}Nama file Wordlist tidak boleh kosong.${r}"
												continue
											else
												if [[ ! -f "${nama_file_wordlist_office_john}" ]]; then
													echo -e "${m}[-] ${p}File Wordlist '${nama_file_wordlist_office_john}' tidak ditemukan.${r}"
													continue
												else
													echo -e "${h}[+] ${p}File Wordlist '${nama_file_wordlist_office_john}' ditemukan.${r}"
													pot_office_john="pot_office_john.txt"
													while true; do
														read -p $'\e[1;37mApakah Anda ingin menggunakan mode verbose (iya/tidak): \e[1;33m' nanya_verbose_office_john
														if [[ "${nanya_verbose_office_john}" == "iya" ]]; then
															read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai prosres cracking.\e[0m'
															echo -e "${b}[*] ${p}Cracking kata sandi file Office '${nama_file_office}' dengan John...${r}"
															john --wordlist="${nama_file_wordlist_office_john}" --pot="${pot_office_john}" --verbosity=6 --progress-every=1 "${target_hash_office_john}"
															if [[ -f "${pot_office_john}" ]]; then
																if [[ $(cat "${pot_office_john}" | grep -o ":") ]]; then
																	kata_sandi_office_john=$(cat "${pot_office_john}" | cut -d ":" -f 2)
																	echo -e "${h}[+] ${p}Kata sandi ditemukan.${r}"
																	echo -e "${h}[+] ${p}Kata sandi: ${h}${kata_sandi_office_john}${r}"
																	rm "${pot_office_john}"
																else
																	echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
																	echo -e "${m}[-] ${p}Coba gunakan Wordlist yang lain.${r}"
																fi	
																break	
															else
																echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
																echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
															fi
															break
	
														elif [[ "${nanya_verbose_office_john}" == "tidak" ]]; then
															read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai prosres cracking.\e[0m'
															echo -e "${b}[*] ${p}Cracking kata sandi file Office '${nama_file_office}' dengan John...${r}"
															john --wordlist="${nama_file_wordlist_office_john}" --pot="${pot_office_john}" "${target_hash_office_john}" > /dev/null 2>&1
															if [[ -f "${pot_office_john}" ]]; then
																if [[ $(cat "${pot_office_john}" | grep -o ":") ]]; then
																	kata_sandi_office_john=$(cat "${pot_office_john}" | cut -d ":" -f 2)
																	echo -e "${h}[+] ${p}Kata sandi ditemukan.${r}"
																	echo -e "${h}[+] ${p}Kata sandi: ${h}${kata_sandi_office_john}${r}"
																	rm "${pot_office_john}"
																else
																	echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
																	echo -e "${m}[-] ${p}Coba gunakan Wordlist yang lain.${r}"
																fi
																break
															else
																echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
																echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
															fi
															break
														else
															echo -e "${m}[-] ${p}Masukkan tidak valid. Harap masukkan 'iya' atau 'tidak'.${r}"
															continue
														fi
													done
												fi
												break
											fi
											break
										done
									else
										echo -e "${m}[-] ${p}Format hash file hash '{nama_file_hash_dari_file_office_john}' tidak valid.${r}"
										continue
									fi
								else
									echo -e "${m}[-] ${p}File '${nama_file_hash_dari_file_office_john}' bukan file hash.${r}"
									continue
								fi

							fi
						fi
						break
					done
					break
				else
					echo -e "${m}[-] ${p}Masukkan tidak valid. Harap masukkan 'iya' atau 'tidak'.${r}"
					continue
				fi
			done

		else


			# memasukkan nama file office
			while true; do
				read -p $'\e[1;37mMasukkan nama file Office: \e[1;33m' nama_file_office_john

				# kondisi jika nama file office kosong
				if [[ -z "${nama_file_office_john}" ]]; then
					echo -e "${m}[-] ${p}Nama file Office tidak boleh kosong.${r}"
					continue
				fi

				# kondisi jika file office tidak ditemukan
				if [[ ! -f "${nama_file_office_john}" ]]; then
					echo -e "${m}[-] ${p}File Office '${nama_file_office_john}' tidak ditemukan.${r}"
					continue
				fi

				# kondisi jika file bukan file office
				if [[ "${nama_file_office_john##*.}" != "docx" && "${nama_file_office_john##*.}" != "xlsx" && "${nama_file_office_john##*.}" != "pptx" ]]; then
					echo -e "${m}[-] ${p}File '${nama_file_office_john}' bukan file Office.${r}"
					continue
				fi

				# kondisi jika file office ditemukan
				echo -e "${h}[+] ${p}File Office '${nama_file_office_john}' ditemukan.${r}"
				break
			done


			while true; do
				read -p $'\e[1;37mMasukkan nama file hash dari file Office: \e[1;33m' nama_file_hash_dari_file_office_john
				if [[ -z "${nama_file_hash_dari_file_office_john}" ]]; then
					echo -e "${m}[-] ${p}Nama file hash tidak boleh kosong.${r}"
					continue
				else
					if [[ ! -f "${nama_file_hash_dari_file_office_john}" ]]; then
						echo -e "${m}[-] ${p}File hash '${nama_file_hash_dari_file_office_john}' tidak ditemukan.${r}"
						continue
					else
						if [[ "${nama_file_hash_dari_file_office_john##*.}" == "john" ]]; then
							if [[ $(cat "${nama_file_hash_dari_file_office_john}" | grep -o "office") ]]; then
								echo -e "${h}[+] ${p}File hash '${nama_file_hash_dari_file_office_john}' ditemukan.${r}"
								while true; do
									read -p $'\e[1;37mMasukkan nama file Wordlist: \e[1;33m' nama_file_wordlist_office_john
									if [[ -z "${nama_file_wordlist_office_john}" ]]; then
										echo -e "${m}[-] ${p}Nama file Wordlist tidak boleh kosong.${r}"
										continue
									else
										if [[ ! -f "${nama_file_wordlist_office_john}" ]]; then
											echo -e "${m}[-] ${p}File Wordlist '${nama_file_wordlist_office_john}' tidak ditemukan.${r}"
											continue
										else
											echo -e "${h}[+] ${p}File Wordlist '${nama_file_wordlist_office_john}' ditemukan.${r}"
											pot_office_john="pot_office_john.txt"
											while true; do
												read -p $'\e[1;37mApakah Anda ingin menggunakan mode verbose (iya/tidak): \e[1;33m' nanya_verbose_office_john
												if [[ "${nanya_verbose_office_john}" == "iya" ]]; then
													read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai prosres cracking.\e[0m'
													echo -e "${b}[*] ${p}Cracking kata sandi file Office '${nama_file_office_john}' dengan John...${r}"
													john --wordlist="${nama_file_wordlist_office_john}" --pot="${pot_office_john}" --verbosity=6 --progress-every=1 "${nama_file_hash_dari_file_office_john}"
													if [[ -f "${pot_office_john}" ]]; then
														if [[ $(cat "${pot_office_john}" | grep -o ":") ]]; then
															kata_sandi_office_john=$(cat "${pot_office_john}" | cut -d ":" -f 2)
															echo -e "${h}[+] ${p}Kata sandi ditemukan.${r}"
															echo -e "${h}[+] ${p}Kata sandi: ${h}${kata_sandi_office_john}${r}"
															rm "${pot_office_john}"
														else
															echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
															echo -e "${m}[-] ${p}Coba gunakan Wordlist yang lain.${r}"
														fi
														break
													else
														echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
														echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
													fi
													break
	
												elif [[ "${nanya_verbose_office_john}" == "tidak" ]]; then
													read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk memulai prosres cracking.\e[0m'
													echo -e "${b}[*] ${p}Cracking kata sandi file Office '${nama_file_office_john}' dengan John...${r}"
													john --wordlist="${nama_file_wordlist_office_john}" --pot="${pot_office_john}" "${nama_file_hash_dari_file_office_john}" > /dev/null 2>&1
													if [[ -f "${pot_office_john}" ]]; then
														if [[ $(cat "${pot_office_john}" | grep -o ":") ]]; then
															kata_sandi_office_john=$(cat "${pot_office_john}" | cut -d ":" -f 2)
															echo -e "${h}[+] ${p}Kata sandi ditemukan.${r}"
															echo -e "${h}[+] ${p}Kata sandi: ${h}${kata_sandi_office_john}${r}"
															rm "${pot_office_john}"
														else
															echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
															echo -e "${m}[-] ${p}Coba gunakan Wordlist yang lain.${r}"
														fi
														break
													else
														echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
														echo -e "${m}[-] ${p}Kata sandi tidak ditemukan.${r}"
													fi
													break
												else
													echo -e "${m}[-] ${p}Masukkan tidak valid. Harap masukkan 'iya' atau 'tidak'.${r}"
													continue
												fi
											done	
										fi	
										break
									fi
									break
								done
							else
								echo -e "${m}[-] ${p}Format hash file hash '${nama_file_hash_dari_file_office_john}' tidak valid.${r}"
								continue
							fi
						else
							echo -e "${m}[-] ${p}File '${nama_file_hash_dari_file_office_john}' bukan file hash.${r}"
							continue
						fi
					fi
				fi
				break
			done


		fi
        	read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk kembali ke menu utama.\e[0m'

	else
		echo -e "${m}[-] ${p}Menu '${pilih_menu}' tidak tersedia. Silahkan pilih kembali..${r}"
		read -p $'\e[1;37mTekan [\e[1;32mEnter\e[1;37m] untuk kembali ke menu utama.\e[0m'
		continue
	fi
done
