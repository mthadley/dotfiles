function gw --description 'Gradle runner'
  set gradle_path (git rev-parse --show-toplevel ^/dev/null)

  if test \( -d $gradle_path \) -a \( -f "$gradle_path/gradlew" \)
    set gradle_path "$gradle_path/gradlew"
  else
    set gradle_path (which gradle)
  end

  eval $gradle_path $argv
end
