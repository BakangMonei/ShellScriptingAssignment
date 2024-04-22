#!/bin/bash

# Function to display available tables with their seating capacity and status
display_available_tables() {
    echo "Available Tables:"
    echo "-----------------"
    while IFS=, read -r table_id capacity status booked_by; do
        if [ "$status" == "available" ]; then
            echo "Table ID: $table_id | Capacity: $capacity | Status: $status"
        fi
    done < tables.csv
    echo "-----------------"
}

# Function to prompt user to select a dining time
select_dining_time() {
    read -p "Enter desired dining time (HH:MM): " dining_time
}

# Function to prompt user to select a reservation date
select_reservation_date() {
    read -p "Enter desired reservation date (YYYY-MM-DD): " reservation_date
}

# Function to check if the selected table is available for the chosen time slot
check_table_availability() {
    local selected_table_id=$1
    local selected_dining_time=$2
    local table_available=false

    while IFS=, read -r table_id capacity status booked_by; do
        if [ "$table_id" == "$selected_table_id" ]; then
            if [ "$status" == "available" ]; then
                table_available=true
            else
                echo "Table $table_id is already booked by $booked_by."
                return 1
            fi
        fi
    done < tables.csv

    if [ "$table_available" == false ]; then
        echo "Table $selected_table_id is not available."
        return 1
    fi

    return 0
}

# Function to make a reservation
make_reservation() {
    local table_id=$1
    local name
    local phone_number
    local email
    local num_guests
    local reservation_date

    read -p "Enter your name: " name
    read -p "Enter your phone number: " phone_number
    read -p "Enter your email address: " email
    read -p "Enter number of guests: " num_guests
    select_reservation_date

    echo "$table_id,$dining_time,$reservation_date,$name,$phone_number,$email,$num_guests" >> reservation_db.txt

    # Update table status
    sed -i "s/$table_id,[0-9]*,available/$table_id,$num_guests,booked by $name/" tables.csv

    echo "Booking for $name on Table $table_id on $dining_time $reservation_date has been made, please check your email at $email"
}

# Function to cancel a booking
cancel_booking() {
    local email
    read -p "Enter your email address to cancel your booking: " email

    # Temporarily store the original reservation_db.txt content
    cp reservation_db.txt reservation_db_temp.txt

    # Remove the booking entry associated with the provided email address
    grep -v "$email" reservation_db_temp.txt > reservation_db.txt

    # Check if any lines were removed (i.e., if the email was found)
    if [ $? -eq 0 ]; then
        echo "Booking for $email has been successfully canceled."
    else
        echo "No booking found for the provided email address."
    fi

    # Remove the temporary file
    rm reservation_db_temp.txt
}


# Function to print all bookings
print_all_bookings() {
    echo "All Bookings:"
    echo "--------------"
    cat reservation_db.txt
    echo "--------------"
}

# Main function
main() {
    while true; do
        echo "Main Menu:"
        echo "1. Make a booking"
        echo "2. Cancel Booking"
        echo "3. Print all bookings"
        echo "4. Exit"

        read -p "Enter your choice: " choice

        case $choice in
            1)  display_available_tables
                select_dining_time
                echo "Selected dining time: $dining_time"
                read -p "Enter table ID to book: " selected_table_id
                if check_table_availability "$selected_table_id" "$dining_time"; then
                    make_reservation "$selected_table_id"
                fi
                ;;
            2)  cancel_booking ;;
            3)  print_all_bookings ;;
            4)  exit ;;
            *)  echo "Invalid choice. Please enter a number from 1 to 4." ;;
        esac
    done
}

main
