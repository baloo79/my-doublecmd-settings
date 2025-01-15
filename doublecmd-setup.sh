#!/usr/bin/env bash
set -e

## Double Commander beallitoszkript - made by balage79
#
# A Double Commander telepitese
  echo
  echo ---------------------------------------------
  echo A Double Commander telepitese...
#
#
# Ellenorizzuk, hogy X11 vagy Wayland van-e
if [[ "$XDG_SESSION_TYPE" == "x11" ]]; then
    echo
    echo "X11 kornyezet van hasznalatban."
elif [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
    echo
    echo "Wayland kornyezet van hasznalatban."
else
    echo
    echo "Ismeretlen kornyezet, nem lehet meghatarozni."
    exit 1
fi
#
sleep 2
#
#
# Megnezzuk, hogy az user melyik asztali kornyezetet hasznalja
desktop_env=$(echo $XDG_CURRENT_DESKTOP | tr '[:upper:]' '[:lower:]')

if [[ "$desktop_env" == "kde" ]]; then
    suggested_name="QT-verzio"
elif [[ "$desktop_env" == "gnome" ]]; then
    suggested_name="GTK-verzio"
else
    suggested_name=""
fi

while true; do

     # Megkerdezzuk, melyik verziot szeretne telepiteni
     echo
     echo "Melyik verziot szeretned telepiteni?"
     echo
     echo "1. GTK-verzio (GNOME)"
     echo "2. QT-verzio (KDE Plasma)"
     echo

     if [[ -n "$suggested_name" ]]; then
         echo
         echo "A rendszerhez ajanlott verzio: $suggested_name"
         echo
         read -p "Nyomj Enter-t a telepiteshez, vagy valassz (1 vagy 2): " choice
     else
         read -p "Valassz (1 vagy 2): " choice
     fi

     if [[ -z "$choice" ]]; then
         choice=1  # alapertelmezett valasztas, ha Enter-t nyomtak
     fi

     # Ha a valasztas 1 vagy 2, akkor kilepunk a ciklusbol
     if [[ "$choice" -eq 1 || "$choice" -eq 2 ]]; then
         break
     else
         # Ervenytelen valasztas, ujra kerdezunk
         echo
         echo "Ervenytelen valasztas! Kerlek, valassz 1 vagy 2 kozott!"
     fi
done

# A valasztas alapjan telepitjuk a megfelelo verziot

if [[ "$choice" -eq 1 ]]; then
    echo 
    echo "A GTK-verzio telepitese..."
    yay -S libunrar zip unzip doublecmd-gtk2 --noconfirm

elif [[ "$choice" -eq 2 ]]; then
    echo
    echo "A QT-verzio telepitese..."
    yay -S libunrar zip unzip doublecmd-qt6 --noconfirm
fi
#
#
sleep 2
#
# Szukseges betutipusok egy reszenek letoltese es telepitese repobol
#
yay -S font-bh-ttf noto-fonts ttf-linux-libertine ttf-linux-libertine-g --noconfirm
#
#
# Letoltjuk a doublecmd telepiteshez szukseges cuccot zip formatumban
cd /home/$USER/
wget -O doublecmd-install.zip https://www.dropbox.com/scl/fi/shyikdkqepovktxlgmwc8/doublecmd-install.zip?rlkey=fd26sz1lvg6plopb33k6o4t62&st=zxcuovyr&dl=0
#
echo
echo "Az install csomag letoltve"
sleep 2
# Kicsomagoljuk a zipet, es belepunk a mappaba
unzip doublecmd-install.zip
echo
echo "Zip kicsomagolas OK"
sleep 2
cd /home/$USER/doublecmd-install
#
sleep 2
#
# A Play betutipust betesszuk a helyere
sudo mkdir -p /usr/share/fonts/play
sudo cp -a Play-Bold.ttf Play-Regular.ttf /usr/share/fonts/play/
# sudo chmod +x /usr/share/fonts/play/
# sudo chmod -R 644 root:root /usr/share/fonts/play/
echo
echo "Play betutipus a helyere teve"
sleep 2
#
# Ujraepitjuk a font cache-t, hogy lassa a rendszer az uj betutipusokat
sudo fc-cache -fv
echo
echo "A font cache ujraepitve"
sleep 2
#
# A helyere masoljuk a doublecmd.zip fajlt, es kicsomagoljuk, hogy a Double Commander a zip-ben levo beallitasokkal induljon, majd vegul toroljuk a zipet
#
cp -a doublecmd.zip /home/$USER/.config/
cd /home/$USER/.config/
unzip doublecmd.zip
echo
echo "A doublecmd beallitasa megtortent"
sleep 2
#
# Vegul toroljuk a mar nem kello zipeket
rm -rf /home/$USER/.config/doublecmd.zip
cd /home/$USER/
rm -rf doublecmd-install.zip
sleep 2
rm -rf doublecmd-install/
echo
echo "A folosleges cuccok eltavolitva."
echo
echo "A Double Commander telepitese es beallitasa elkeszult!"
echo