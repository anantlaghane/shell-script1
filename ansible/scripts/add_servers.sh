#!/bin/bash
echo "env is            $1"
echo "name_of_the_server is $2"
echo "type_of_the_server is $3"
echo "action_on_server  is $4"
echo "ticket_number     is $5"
echo "count             is $6"
echo "ins               is $7"

#exit
# ------------------------------------------------------------------
# 2. Capture positional parameters
# ------------------------------------------------------------------
env=$1
name_of_the_server=$2
type_of_the_server=$3
action_on_server=$4
ticket_number=$5
item_count=$6
on_which_instances=$7

UENV=$(echo "${env}" | tr '[:lower:]' '[:upper:]')
echo "00000000000000000" $UENV
additional_config_values="512 512"
no_of_instances=1

# ------------------------------------------------------------------
# 3. Change to workspace
# ------------------------------------------------------------------
#cd //ansible

# ------------------------------------------------------------------
# 4. Part 2 – senv processing
# ------------------------------------------------------------------
cd /var/lib/jenkins/workspace/add_servers/files/$env
#cd /home/anantlaghane/myGit/shell-script1/files/$env
echo "Hello ${on_which_instances}"
>  count_of_servers_in_each_box.txt
itemCount=$6
#my_array=($(echo $on_which_instances | tr "," "\n"))

pwd
total_no_of_instances=`expr $(ls | grep $type_of_the_server | wc -l)`
echo "total" $total_no_of_instances
echo "ADD Action !!!"


echo file name $type_of_the_server".txt."${UENV}
cat  $type_of_the_server".txt."${UENV}

case $action_on_server in

        find_min_n_add)

        for (( c=1; c<=$total_no_of_instances; c++ )); do

            if [ "$env" = "prf1" ]; then
                isServerExists=$(cat "prf_int_server${c}/properties/${type_of_the_server}servername.txt.INCRHEAP.${UENV}" | grep -w "$name_of_the_server" | wc -l)
            else
                isServerExists=$(cat $type_of_the_server".txt."${UENV} | grep -w "$name_of_the_server" | wc -l)
            fi

            if [ "$isServerExists" != 0 ]; then
                if [ "$env" = "prf1" ]; then
                    echo "$name_of_the_server is already added in ${UENV} at prf_int_server${c}/properties/${type_of_the_server}servername.txt.INCRHEAP.${UENV} so exiting from script"
                else
                    echo "$name_of_the_server is already added in so exiting from script"
                fi
                exit
            fi
        done

#echo "" > count_of_servers_in_each_box.txt

count_of_files=`expr $(ls | grep $type_of_the_server | wc -l)`
pwd
echo "count_of_files $count_of_files"

for ((c=1; c<=$count_of_files; c++)); do
    if [ "$env" = "prf1" ]; then
        count_of_servers_in_each_Linux=$(cat "prf_int_server${c}/properties/${type_of_the_server}servername.txt.INCRHEAP.${UENV}" | wc -l)
        echo "prf_int_server${c}/properties/${type_of_the_server}servername.txt.INCRHEAP.${UENV} has $count_of_servers_in_each_Linux" >> count_of_servers_in_each_box.txt
    else
        count_of_servers_in_each_Linux=$(cat $type_of_the_server".txt."${UENV} | wc -l)
        echo "=====" $count_of_servers_in_each_Linux
        ls -lrt
        pwd

        echo "$type_of_the_server.txt.${UENV} has $count_of_servers_in_each_Linux" >> count_of_servers_in_each_box.txt
        #exit
        #sudo bash -c 'echo intg.txt.'${UENV}' has '$count_of_servers_in_each_Linux' >> count_of_servers_in_each_box.txt'
        echo "file display"
        cat count_of_servers_in_each_box.txt
#exit
        #>> count_of_servers_in_each_box.txt
    fi
done

cat count_of_servers_in_each_box.txt

# ------------------------------------------------------------------
# 5. Part 3 – eqal processing
# ------------------------------------------------------------------
#cd /app/laxman/my_git/SONS-26301/supply-chain-ci/ansible/SONS-26194/supply-chain-ci/sterling/95/ansible/files/sterling/eqal

my_array=($(cat count_of_servers_in_each_box.txt | awk -F" " '{ print $NF }'))

min=${my_array[0]}


echo "min value" $min
for element in "${my_array[@]}"; do
    echo "Smallest element is: $min"

    filename=$(cat count_of_servers_in_each_box.txt | grep -w "$min" | awk -F" " '{print $1}')
    echo "$filename ------ $name_of_the_server"
    #new_filename=$filename""${UENV}
    # - sudo bash -c 'echo '$name_of_the_server' >> '$new_filename''
    echo "$name_of_the_server $additional_config_values" >> "$filename"

    # git add -A
    # git commit -m "Added ${type_of_the_server} server $name_of_the_server in ${UENV}"
    # git push origin main

    break
done
;;

is_available)
               echo "laxman"
        ;;


esac