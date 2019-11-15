function elm_clean --description "Clean out all relevant elm directories"
  set elm_files (find -not -path "*node_modules*" -name elm-stuff -type d)

  for file in $elm_files ~/.elm
    echo -n "Removing $file... "
    if rm -fr $file
      echo "💀"
    else
      echo "❌"
    end
  end
  echo -e "\nDone!"
end
