#!/bin/bash

# Function to create a new account
create_account() {
    echo "Creating a new account..."
    read -p "Enter your name: " name
    read -p "Enter a password: " password
    # Save the account details to a file
    echo "$name:$password:0" >> accounts.txt
    echo "Account created successfully!"
}

# Function to check account details
check_account_details() {
    read -p "Enter your name: " name
    read -p "Enter your password: " password
    # Check if the account exists
    if grep -q "^$name:$password:" accounts.txt; then
        balance=$(grep "^$name:$password:" accounts.txt | cut -d ':' -f 3)
        echo "Account details:"
        echo "Name: $name"
        echo "Balance: $balance"
    else
        echo "Invalid name or password!"
    fi
}

# Function to perform a transaction
perform_transaction() {
    read -p "Enter your name: " sender_name
    read -p "Enter your password: " sender_password
    # Check if the sender account exists
    if grep -q "^$sender_name:$sender_password:" accounts.txt; then
        sender_balance=$(grep "^$sender_name:$sender_password:" accounts.txt | cut -d ':' -f 3)
        read -p "Enter the recipient's name: " recipient_name
        recipient_password=$(grep "^$recipient_name:" accounts.txt | cut -d ':' -f 2)
        read -p "Enter the amount to transfer: " amount
        # Check if the sender has sufficient balance
        if [ $amount -le $sender_balance ]; then
            # Check if the recipient account exists
            if grep -q "^$recipient_name:" accounts.txt; then
                recipient_balance=$(grep "^$recipient_name:" accounts.txt | cut -d ':' -f 3)
                sender_new_balance=$((sender_balance - amount))
                recipient_new_balance=$((recipient_balance + amount))
                # Update the sender's balance in the file
                sed -i "s/^$sender_name:$sender_password:$sender_balance$/$sender_name:$sender_password:$sender_new_balance/" accounts.txt
                # Update thse recipient's balance in the file
                # sed -i "s/^$recipient_name:$recipient_balance$/$recipient_name:$recipient_new_balance:/" accounts.txt
                # sed -i "s/^$recipient_name:[^:]*:$recipient_balance\$/$recipient_name:[^:]*:${recipient_password}:/" accounts.txt
                sed -i "s/^$recipient_name:$recipient_password:$recipient_balance$/$recipient_name:$recipient_password:$recipient_new_balance/" accounts.txt

                echo "Transaction successful!"
            else
                echo "Recipient account does not exist!"
            fi
        else
            echo "Insufficient balance!"
        fi
    else
        echo "Invalid name or password!"
    fi
}


# Function to withdraw money
withdraw_money() {
    read -p "Enter your name: " name
    read -p "Enter your password: " password
    # Check if the account exists
    if grep -q "^$name:$password:" accounts.txt; then
        balance=$(grep "^$name:$password:" accounts.txt | cut -d ':' -f 3)
        read -p "Enter the amount to withdraw: " amount
        # Check if the balance is sufficient
        if [ $amount -le $balance ]; then
            new_balance=$((balance - amount))
            # Update the balance in the file
            sed -i "s/^$name:$password:$balance$/$name:$password:$new_balance/" accounts.txt
            echo "Withdrawal successful!"
        else
            echo "Insufficient balance!"
        fi
    else
        echo "Invalid name or password!"
    fi
}

# Function to deposit money
deposit_money() {
    read -p "Enter your name: " name
    read -p "Enter your password: " password
    # Check if the account exists
    if grep -q "^$name:$password:" accounts.txt; then
        balance=$(grep "^$name:$password:" accounts.txt | cut -d ':' -f 3)
        read -p "Enter the amount to deposit: " amount
        new_balance=$((balance + amount))
        # Update the balance in the file
        sed -i "s/^$name:$password:$balance$/$name:$password:$new_balance/" accounts.txt
        echo "Deposit successful!"
    else
        echo "Invalid name or password!"
    fi
}

# Main menu
while true; do
    echo "Welcome to the Banking Management System"
    echo "1. Create Account"
    echo "2. Check Account Details"
    echo "3. Perform Transaction"
    echo "4. Withdraw Money"
    echo "5. Deposit Money"
    echo "6. Exit"
    read -p "Enter your choice: " choice

    case $choice in
        1) create_account ;;
        2) check_account_details ;;
        3) perform_transaction ;;
        4) withdraw_money ;;
        5) deposit_money ;;
        6) exit ;;
        *) echo "Invalid choice!" ;;
    esac

    echo
done
