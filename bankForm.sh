#!/bin/bash

# Function to create a new account
create_account() {
    dialog --backtitle "Banking Management System" --title "Create Account" --form "Enter your details:" 10 50 0 \
        "Name:" 1 1 "" 1 10 30 0 \
        "Password:" 2 1 "" 2 10 30 0 2>temp.txt

    if [ $? -eq 0 ]; then
        name=$(cat temp.txt | head -1)
        password=$(cat temp.txt | tail -1)
        # Save the account details to a file
        echo "$name:$password:0" >> accounts.txt
        dialog --backtitle "Banking Management System" --msgbox "Account created successfully!" 10 50
    else
        dialog --backtitle "Banking Management System" --msgbox "Account creation cancelled!" 10 50
    fi

    rm -f temp.txt
}

# Function to check account details
check_account_details() {
    dialog --backtitle "Banking Management System" --title "Account Details" --form "Enter your details:" 10 50 0 \
        "Name:" 1 1 "" 1 10 30 0 \
        "Password:" 2 1 "" 2 10 30 0 2>temp.txt

    if [ $? -eq 0 ]; then
        name=$(cat temp.txt | head -1)
        password=$(cat temp.txt | tail -1)
        # Check if the account exists
        if grep -q "^$name:$password:" accounts.txt; then
            balance=$(grep "^$name:$password:" accounts.txt | cut -d ':' -f 3)
            dialog --backtitle "Banking Management System" --msgbox "Account details:\n\nName: $name\nBalance: $balance" 10 50
        else
            dialog --backtitle "Banking Management System" --msgbox "Invalid name or password!" 10 50
        fi
    else
        dialog --backtitle "Banking Management System" --msgbox "Account details cancelled!" 10 50
    fi

    rm -f temp.txt
}

# Function to perform a transaction
perform_transaction() {
    dialog --backtitle "Banking Management System" --title "Perform Transaction" --form "Enter your details:" 10 50 0 \
        "Sender Name:" 1 1 "" 1 14 30 0 \
        "Sender Password:" 2 1 "" 2 18 30 0 \
        "Recipient Name:" 3 1 "" 3 16 30 0 \
        "Amount:" 4 1 "" 4 9 30 0 2>temp.txt

    if [ $? -eq 0 ]; then
        sender_name=$(cat temp.txt | head -4 | tail -3 | head -1)
        sender_password=$(cat temp.txt | head -4 | tail -3 | tail -1)
        recipient_name=$(cat temp.txt | tail -1 | head -1)
        amount=$(cat temp.txt | tail -1 | tail -1)
        # Check if the sender account exists
        if grep -q "^$sender_name:$sender_password:" accounts.txt; then
            sender_balance=$(grep "^$sender_name:$sender_password:" accounts.txt | cut -d ':' -f 3)
            # Check if the sender has sufficient balance
            if [ $amount -le $sender_balance ]; then
                # Check if the recipient account exists
                if grep -q "^$recipient_name:" accounts.txt; then
                    recipient_balance=$(grep "^$recipient_name:" accounts.txt | cut -d ':' -f 3)
                    sender_new_balance=$((sender_balance - amount))
                    recipient_new_balance=$((recipient_balance + amount))
                    # Update the sender's balance in the file
                    sed -i "s/^$sender_name:$sender_password:$sender_balance$/$sender_name:$sender_password:$sender_new_balance/" accounts.txt
                    # Update the recipient's balance in the file
                    sed -i "s/^$recipient_name:[^:]*:$recipient_balance$/$recipient_name:$recipient_password:$recipient_new_balance/" accounts.txt

                    dialog --backtitle "Banking Management System" --msgbox "Transaction successful!" 10 50
                else
                    dialog --backtitle "Banking Management System" --msgbox "Recipient account does not exist!" 10 50
                fi
            else
                dialog --backtitle "Banking Management System" --msgbox "Insufficient balance!" 10 50
            fi
        else
            dialog --backtitle "Banking Management System" --msgbox "Invalid name or password!" 10 50
        fi
    else
        dialog --backtitle "Banking Management System" --msgbox "Transaction cancelled!" 10 50
    fi

    rm -f temp.txt
}

# Function to withdraw money
withdraw_money() {
    dialog --backtitle "Banking Management System" --title "Withdraw Money" --form "Enter your details:" 10 50 0 \
        "Name:" 1 1 "" 1 10 30 0 \
        "Password:" 2 1 "" 2 10 30 0 \
        "Amount:" 3 1 "" 3 9 30 0 2>temp.txt

    if [ $? -eq 0 ]; then
        name=$(cat temp.txt | head -3 | tail -2 | head -1)
        password=$(cat temp.txt | head -3 | tail -2 | tail -1)
        amount=$(cat temp.txt | tail -1)
        # Check if the account exists
        if grep -q "^$name:$password:" accounts.txt; then
            balance=$(grep "^$name:$password:" accounts.txt | cut -d ':' -f 3)
            # Check if the balance is sufficient
            if [ $amount -le $balance ]; then
                new_balance=$((balance - amount))
                # Update the balance in the file
                sed -i "s/^$name:$password:$balance$/$name:$password:$new_balance/" accounts.txt
                dialog --backtitle "Banking Management System" --msgbox "Withdrawal successful!" 10 50
            else
                dialog --backtitle "Banking Management System" --msgbox "Insufficient balance!" 10 50
            fi
        else
            dialog --backtitle "Banking Management System" --msgbox "Invalid name or password!" 10 50
        fi
    else
        dialog --backtitle "Banking Management System" --msgbox "Withdrawal cancelled!" 10 50
    fi

    rm -f temp.txt
}

# Function to deposit money
deposit_money() {
    dialog --backtitle "Banking Management System" --title "Deposit Money" --form "Enter your details:" 10 50 0 \
        "Name:" 1 1 "" 1 10 30 0 \
        "Password:" 2 1 "" 2 10 30 0 \
        "Amount:" 3 1 "" 3 9 30 0 2>temp.txt

    if [ $? -eq 0 ]; then
        name=$(cat temp.txt | head -3 | tail -2 | head -1)
        password=$(cat temp.txt | head -3 | tail -2 | tail -1)
        amount=$(cat temp.txt | tail -1)
        # Check if the account exists
        if grep -q "^$name:$password:" accounts.txt; then
            balance=$(grep "^$name:$password:" accounts.txt | cut -d ':' -f 3)
            new_balance=$((balance + amount))
            # Update the balance in the file
            sed -i "s/^$name:$password:$balance$/$name:$password:$new_balance/" accounts.txt
            dialog --backtitle "Banking Management System" --msgbox "Deposit successful!" 10 50
        else
            dialog --backtitle "Banking Management System" --msgbox "Invalid name or password!" 10 50
        fi
    else
        dialog --backtitle "Banking Management System" --msgbox "Deposit cancelled!" 10 50
    fi

    rm -f temp.txt
}

# Main menu
while true; do
    choice=$(dialog --backtitle "Banking Management System" --title "Main Menu" --menu "Choose an option:" 15 50 7 \
        1 "Create Account" \
        2 "Check Account Details" \
        3 "Perform Transaction" \
        4 "Withdraw Money" \
        5 "Deposit Money" \
        6 "Exit" \
        2>&1 >/dev/tty)

    case $choice in
        1) create_account ;;
        2) check_account_details ;;
        3) perform_transaction ;;
        4) withdraw_money ;;
        5) deposit_money ;;
        6) exit ;;
        *) dialog --backtitle "Banking Management System" --msgbox "Invalid choice!" 10 50 ;;
    esac

    echo
done
