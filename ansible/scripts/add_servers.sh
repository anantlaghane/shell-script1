#!/bin/sh
# ------------------------------------------------------------------
# 1. Echo incoming parameters
# ------------------------------------------------------------------
echo "env is            $1"
echo "name_of_the_server is $2"
echo "type_of_the_server is $3"
echo "action_on_server  is $4"
echo "ticket_number     is $5"
echo "count             is $6"
echo "ins               is $7"

exit
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
additional_config_values="512 512"
no_of_instances=1

# ------------------------------------------------------------------
# 3. Change to workspace
# ------------------------------------------------------------------
cd //ansible

# ------------------------------------------------------------------
# 4. Part 2 – senv processing
# ------------------------------------------------------------------
cd sterling/95/ansible/files/sterling/senv/

echo "Hello ${Son_which_instances}"

itemCount=$6
my_array($(echo on_which_instances | tr "," "\n"))

pwd
total_no_of_instances='expr $(ls | grep int | wc -l) - 1'

find_min_n_add
echo "ADD Action !!!"

case $action_on_server in
    # Exit if server is already present in Env
    *)
        for ((c = 1; c <= $total_no_of_instances; c++)); do
            if [ "$env" = "prf1" ]; then
                isServerExists=$(cat "prf_int_server${c}/properties/${type_of_the_server}servername.txt.INCRHEAP.${UENV}" | grep -w "$name_of_the_server" | wc -l)
            else
                isServerExists=$(cat "${env}_int_server${c}/properties/${type_of_the_server}servername.txt.INCRHEAP.${UENV}" | grep -w "$name_of_the_server" | wc -l)
            fi

            if [ "$isServerExists" != 0 ]; then
                if [ "$env" = "prf1" ]; then
                    echo "$name_of_the_server is already added in ${UENV} at prf_int_server${c}/properties/${type_of_the_server}servername.txt.INCRHEAP.${UENV} so exiting from script"
                else
                    echo "$name_of_the_server is already added in ${UENV} at ${env}_int_server${c}/properties/${type_of_the_server}servername.txt.INCRHEAP.${UENV} so exiting from script"
                fi
                exit
            fi
        done
        ;;
esac

echo "" > count_of_servers_in_each_box.txt

count_of_files='expr $(ls | grep int | wc -l)'
echo "count_of_files $count_of_files"

for ((c = 1; c <= $count_of_files; c++)); do
    if [ "$env" = "prf1" ]; then
        count_of_servers_in_each_Linux=$(cat "prf_int_server${c}/properties/${type_of_the_server}servername.txt.INCRHEAP.${UENV}" | wc -l)
        echo "prf_int_server${c}/properties/${type_of_the_server}servername.txt.INCRHEAP.${UENV} has $count_of_servers_in_each_Linux" >> count_of_servers_in_each_box.txt
    else
        count_of_servers_in_each_Linux=$(cat "${env}_int_server${c}/properties/${type_of_the_server}servername.txt.INCRHEAP.${UENV}" | wc -l)
        echo "${env}_int_server${c}/properties/${type_of_the_server}servername.txt.INCRHEAP.${UENV} has $count_of_servers_in_each_Linux" >> count_of_servers_in_each_box.txt
    fi
done

cat count_of_servers_in_each_box.txt

# ------------------------------------------------------------------
# 5. Part 3 – eqal processing
# ------------------------------------------------------------------
cd /app/laxman/my_git/SONS-26301/supply-chain-ci/ansible/SONS-26194/supply-chain-ci/sterling/95/ansible/files/sterling/eqal

my_array($(cat count_of_servers_in_each_box.txt | awk -F" " '{ print $NF }'))

min=${my_array[0]}

for element in "${my_array[@]}"; do
    echo "Smallest element is: $min"

    filename=$(cat count_of_servers_in_each_box.txt | grep -w "$min" | awk -F" " '{print $1}')
    echo "$filename"

    echo "$name_of_the_server $additional_config_values" >> "$filename"
    echo "$name_of_the_server $additional_config_values" >> "$filename"

    git add -A
    git commit -m "sticket_number: Added ${type_of_the_server} server $name_of_the_server in ${UENV}"
    git push origin feature/sticket_number

    break
done
