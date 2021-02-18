#!/bin/bash
#Recode Ganti Copyright ? otak lo pake 
nexmo(){
	curl=$(curl -skL --connect-timeout 20 --max-time 20 "https://rest.nexmo.com/account/get-balance?api_key=$1&api_secret=$2")
	credit=$(echo $curl | grep -Po '(?<=value":)[^},]*' | tr -d '[]"' | sed 's/\(<[^>]*>\|<\/>\|{1|}\)//g')
	autoload=$(echo $curl | grep -Po '(?<=autoReload":)[^},]*' | tr -d '[]"' | sed 's/\(<[^>]*>\|<\/>\|{1|}\)//g')
	if [[ $autoload =~ "false" ]]; then
		printf "LIVE => $1|$2 Belance : $credit/$autoload [NakoCode]\n"
		echo "LIVE => $1|$2 Belance : $credit">>live.txt
	elif [[ $autoload =~ "true" ]]; then
    printf "LIVE => $1|$2 Belance : $credit/$autoload[NakoCode]\n"
    echo "LIVE => $1|$2 Belance : $credit">>live.txt
  else
		printf "DEAD => $1|$2 [NakoCode]\n"
	fi
}
cat << "EOF"
                      .".
                     /  |
                    /  /
                   / ,"
       .-------.--- /
      "._ __.-/ o. o\
         "   (    Y  )
              )     /
             /     (
            /       Y
        .-"         |
       /  _     \    \
      /    `. ". ) /' )
     Y       )( / /(,/
    ,|      /     )
   ( |     /     /
    " \_  (__   (__        [Tatsumi Crew - NEXMO CHECKER]
        "-._,)--._,)	   
EOF
echo "List In This Directory : "
ls
read -p "Select Your List : " listna;
IFS=$'\r\n' GLOBIGNORE='*' command eval 'bacot=($(cat $listna))'
waktumulai=$(date +%s)
for (( i = 0; i <"${#bacot[@]}"; i++ )); do
	WOW="${bacot[$i]}"
	IFS='|' read -r -a array <<< "$WOW"
	key=${array[0]}
	secret=${array[1]}
	((cthread=cthread%5)); ((cthread++==0)) && wait
	nexmo ${key} ${secret} &
done
wait