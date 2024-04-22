#!/bin/bash

# Function to calculate parking charge
calculateCharge() {
    local hours=$1
    local charge=0
    if (( $(echo "$hours <= 3" | bc -l) )); then
        charge=2
    else
        charge=$(echo "2 + ($hours - 3) * 0.5" | bc -l)
    fi
    # Maximum charge limit
    if (( $(echo "$charge > 10" | bc -l) )); then
        charge=10
    fi
    echo $charge
}

# Function to validate input
validateInput() {
    local input=$1
    # Check if input is a positive number
    if [[ $input =~ ^[0-9]+(\.[0-9]+)?$ && $input > 0 ]]; then
        echo 1
    else
        echo 0
    fi
}

# Initialize variables
totalReceipts=0
totalHours=0
exceededCars=""

# Initialize table
table="|Car|Hours Parked|Charge|\n|-------------------------|\n"

# Prompt user for input for each customer
for car in {1..3}; do
    read -p "Enter hours parked for Car $car: " hours

    # Validate input
    while [[ $(validateInput $hours) -eq 0 ]]; do
        read -p "Invalid input. Please enter a valid number of hours: " hours
    done

    # Check if hours exceed 24
    if (( $(echo "$hours > 24" | bc -l) )); then
        exceededCars+="Car $car, "
    fi

    # Calculate charge
    charge=$(calculateCharge $hours)
    
    # Increment total hours and receipts
    totalHours=$(echo "$totalHours + $hours" | bc -l)
    totalReceipts=$(echo "$totalReceipts + $charge" | bc -l)

    # Add row to table
    table+="|Car $car|  $hours| $charge|\n|-------------------------|\n"
done

# Print the table
echo -e "$table"

# Print total line
echo "|Total|       |   $totalHours| $totalReceipts|"

# Check if any cars exceeded 24 hours and print the statement
if [ ! -z "$exceededCars" ]; then
    echo "The following cars exceeded 24 hours and were charged more than P10.00: $exceededCars"
fi
