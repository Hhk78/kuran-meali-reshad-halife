#!/bin/bash

# Kuran dosyalarının bulunduğu dizin
kuran_dir="/home/$USER/.local/reşad/kuran-meali-reşad-halife"

# Sure adlarını ve dosya adlarını tanımlayalım
sures=("Fatiha" "Bakara" "Al-i Imran" "Nisa" "Mâide" "En'am" "A'raf" "Enfal" "Tevbe" "Yunus" "Hûd" "Yusuf" "Rad" "İbrahim" "Hicr" "Nahl" "İsra" "Kehf" "Meryem" "Taha" "Enbiya" "Hac" "Mü'minun" "Nûr" "Furkan" "Şu'ara" "Neml" "Kasas" "Ankebut" "Rum" "Lokman" "Secde" "Ahzab" "Sebe" "Fâtır" "Yâsîn" "Sâffât" "Sad" "Zümer" "Mü'min" "Fussilet" "Şûrâ" "Zuhruf" "Duhân" "Câsiye" "Ahkâf" "Muhammed" "Fetih" "Hucurât" "Kaf" "Zâriyât" "Tur" "Necm" "Kamer" "Rahman" "Vâkıa" "Hadid" "Mücadele" "Haşr" "Mümtehine" "Saf" "Cuma" "Münafikun" "Tegabun" "Talak" "Tahrim" "Mülk" "Kalem" "Hakka" "Mearic" "Nuh" "Cinn" "Müzzemmil" "Müddessir" "Kıyamet" "İnsan" "Mürselât" "Nebe" "Naziat" "Abese" "Tekvir" "İnfitar" "Mutaffifin" "İnşikak" "Buruc" "Târık" "Alâ" "Gasiye" "Fecr" "Beled" "Şems" "Leyl" "Duhâ" "İnşirah" "Tin" "Alak" "Kadir" "Beyyine" "Zilzal" "Adiyat" "Karia" "Tekasur" "Asr" "Hümeze" "Fil" "Kureyş" "Maun" "Kevser" "Kâfirun" "Nasr" "Leheb" "İhlas" "Felak" "Nas")

# Seçeneklerin listesini oluştur
select_option() {
  local options=()
  local index=1
  for sure in "${sures[@]}"; do
    options+=("$index-$sure")
    ((index++))
  done
  PS3="Hangi sureyi görmek istersiniz? (Çıkış için 0): "
  select opt in "${options[@]}"; do
    if [ "$REPLY" -eq 0 ]; then
      echo "Çıkış yapılıyor..."
      break
    elif [ "$REPLY" -ge 1 ] && [ "$REPLY" -le "${#sures[@]}" ]; then
      sure_index=$((REPLY - 1))
      sure_file="${sures[$sure_index]}"
      sure_file="${sure_file,,}" # Sure adını küçük harfe dönüştür
      file_path="$kuran_dir/$((sure_index + 1))"
      if [ -f "$file_path" ]; then
        show_ayet "$file_path" "$((sure_index + 1))"
      else
        echo "Seçtiğiniz dosya bulunamadı."
      fi
    else
      echo "Geçersiz seçenek, tekrar deneyin."
    fi
  done
}

# Ayetleri göster
show_ayet() {
  local file_path="$1"
  local sure_no="$2"
  local ayet_sayisi=$(grep -c "^\\[$sure_no:" "$file_path")
  PS3="Hangi ayeti görmek istersiniz? (Çıkış için 0): "
  select ayet_num in $(seq "$ayet_sayisi"); do
    if [ "$REPLY" -eq 0 ]; then
      echo "Çıkış yapılıyor..."
      break
    elif [ "$REPLY" -ge 1 ] && [ "$REPLY" -le "$ayet_sayisi" ]; then
      ayet_index=$((REPLY - 1))
      echo "------------------------"
      echo "[$sure_no:$((ayet_index + 1))]"
      grep "^\\[$sure_no:$((ayet_index + 1))\]" "$file_path"
      echo "------------------------"
    else
      echo "Geçersiz seçenek, tekrar deneyin."
    fi
  done
}

# Betiği çalıştır
select_option
