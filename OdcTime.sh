
function show_total_odc_time(){
    total_duration_seconds=$1
    total_seconds=$((total_duration_seconds%60))
    total_duration_minutes=$((total_duration_seconds/60))
    total_minutes=$((total_duration_minutes%60))
    total_hours=$((total_duration_minutes/60))

    echo "Total Odc Hours - $total_hours:$total_minutes:$total_seconds ($(( total_duration_seconds*100/(9*60*60) ))%)"
}

odc_swips=("19:40:10" "19:54:01" "19:59:51" "21:30:10")

total_duration_seconds=0
array_length=${#odc_swips[@]}

for((array_index=0; array_index<array_length; array_index+=2)); do
    in_time=$(date -d "${odc_swips[$array_index]}" '+%s')

    out_time_input=${odc_swips[$array_index+1]}
    if (( $array_index+1 >= $array_length )); then
        out_time_input=$(date '+%H:%M:%S')
    fi
    out_time=$(date -d "$out_time_input" '+%s')

    total_duration_seconds=$(($total_duration_seconds + $out_time - $in_time))
done

show_total_odc_time $total_duration_seconds