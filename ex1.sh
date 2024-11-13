
#1a
cd "$HOME"
mkdir -p "students"

# Check if the "StudentList.csv" file is already in the "students" directory
if [ ! -f "./students/StudentList.csv" ]; then
    cp "StudentList.csv" "./students"
else
    echo "StudentList.csv already exists in the students directory. Skipping copy."
fi

#1b
cd "students"
grep "PoD" "StudentList.csv" > "PoDStudents.csv"   # Students with "PoD" in their data
grep "Physics" "StudentList.csv" > "PhysicsStudents.csv" # Students with "Physics" in their data

#1c
cat "StudentList.csv" | cut -d "," -f1 | cut -c1 | sed "1d" | sort | uniq -c > "countList.csv"
# Explanation:
# - `cut -d "," -f1` extracts the first field (name) from each row in StudentList.csv.
# - `cut -c1` takes the first character of each name.
# - `sed "1d"` removes the header.
# - `sort | uniq -c` counts occurrences of each unique first character.

#1d
maxCount=0
maxLetter=""

# Loop through each line in countList.csv
while read -r count letter; do
    if [ "$count" -gt "$maxCount" ]; then
        maxCount=$count       
        maxLetter=$letter     
    fi
done < "countList.csv"

echo "Letter with the highest count: $maxLetter"
echo "Highest count: $maxCount"

#1e

input_file="StudentList.csv"

rm -f group_*.txt

line_num=1  # Start at 1 for the first student after skipping the header

tail -n +2 "$input_file" | while IFS= read -r line || [ -n "$line" ]; do
    # Calculate the group number (1-18)
    group=$((line_num % 18))
    
    if [ "$group" -eq 0 ]; then
        group=18
    fi

    # Write the line to the appropriate group file
    echo "$line" >> "group_${group}.txt"
    
    # Optional: print progress
    echo "Student $line_num assigned to group $group"
    
    # Increment line number AFTER processing the current student
    ((line_num++))
done
