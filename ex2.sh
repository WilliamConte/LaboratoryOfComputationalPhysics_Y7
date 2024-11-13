#2a
sed -e "s/,/ /g" -e "/^#/d" "data.csv" > "data.txt"

#2b
evenCounter=0
while IFS= read -r line; do
    for number in $line; do
        if [ $((number % 2)) -eq 0 ]; then
            ((evenCounter++))
        else ((evenCounter+=0))
        fi
    done
done < "data.txt"
echo "there are $evenCounter even numbers in data.txt"

#2c

greaterCounter=0
lessCounter=0
threshold=$(echo 'scale=3;sqrt(3)*100/2' | bc -l)

while IFS= read -r line || [ -n "$line" ]; do
    
    squareSum=0
    numCounter=0 

    for num in $line; do
        if [ "$numCounter" -lt 3 ]; then
            ((squareSum+=num*num))
            ((numCounter++))
        else 
            break
        fi
    done
    
    squareSum=$(echo "scale=3;sqrt("$squareSum")" | bc -l)
    echo "$squareSum"
    if (( $(echo "$squareSum < $threshold" | bc -l) )); then
        ((lessCounter++))
    else ((greaterCounter++))
    fi

done < "data.txt"

echo "There are $greaterCounter number greater and $lessCounter number less than what indicated"

#2d

echo "Write the number of copies n: "
read numberCopies

for (( i=1; i<=numberCopies; i++ )); do
    while IFS= read -r line || [ -n "$line" ]; do
        output_line=""
        for number in $line; do
            output_line+="$((number / i)) "
        done
        echo "${output_line% }" >> "data_${i}.txt"
    done < "data.txt"
done
