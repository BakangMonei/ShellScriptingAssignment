# Assignment: Parking Charges Calculator and Restaurant Reservation System

This repository contains two shell script-based assignments: one for calculating parking charges for a garage and the other for managing restaurant reservations.

## Parking Charges Calculator

### Description

The Parking Charges Calculator script calculates and prints parking charges for customers who parked their cars in the garage yesterday. The garage charges a minimum fee of P2.00 to park up to 3 hours and an additional fee of P0.50 per hour for each hour or part thereof over three hours. The maximum charge for any given 24-hour period is P10.00, and no car parks for longer than 24 hours. The script prompts the user to enter the hours parked for each customer and prints the results in a tabular format. Additionally, the script calculates and prints the total of yesterday's receipts.

### Usage

1. Clone the repository:

    ```bash
    git clone https://github.com/BakangMonei/ShellScriptingAssignment
    ```

2. Navigate to the project directory:

    ```bash
    cd Question1
    ```

3. Run the script:

    ```bash
    ./parking_charges_calculator.sh
    ```

4. Follow the on-screen prompts to enter the hours parked for each customer.
5. The script will print the results in a tabular format and calculate the total receipts for the day.

## Restaurant Reservation System

### Description

The Restaurant Reservation System script allows users to manage reservations efficiently. It includes functionalities such as displaying available tables, making reservations, canceling bookings, and printing all bookings. The script provides a user-friendly interface and prompts the user for input as required. It calculates charges for parking based on the given rules and ensures proper validation of input.

### Usage

1. Clone the repository:

    ```bash
    git clone https://github.com/BakangMonei/ShellScriptingAssignment
    ```

2. Navigate to the project directory:

    ```bash
    cd Question2
    ```

3. Run the script:

    ```bash
    ./resturant_reservation_system.sh
    ```

4. Follow the on-screen menu to make a booking, cancel a booking, print all bookings, or exit the system.
5. The script will guide you through the process and provide relevant options based on your selection.

### Notes

- Ensure proper permissions are set to execute the scripts (`parking_charges_calculator.sh` and `resturant_reservation_system.sh`).
- These scripts are provided as a demonstration and may not cover all edge cases or error scenarios.
