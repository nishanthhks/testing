#include <stdio.h>
#include <stdlib.h>
#define SIZE 5
int top = -1;
int stack[SIZE];

void push(int element);
int pop();
void display();

int main() {
    int choice, element;

    do {
        printf("\nStack Operations:\n");
        printf("1. Push\n");
        printf("2. Pop\n");
        printf("3. Display\n");
        printf("4. Exit\n");
        printf("Enter your choice: ");
        scanf("%d", &choice);

        switch (choice) {
            case 1:
                printf("Enter element to push: ");
                scanf("%d", &element);
                push(element);
                break;
            case 2:
                element = pop();
                if (element != -1) {
                    printf("Popped element: %d\n", element);
                }
                break;
            case 3:
                display();
                break;
            case 4:
                printf("Exiting program.\n");
                break;
            default:
                printf("Invalid choice. Please enter a valid option.\n");
        }

    } while (choice != 4);

    return 0;
}

void push(int element) {
    if (top == SIZE - 1) {
        printf("Stack Overflow. Cannot push element %d.\n", element);
    } else {
        top++;
        stack[top] = element;
        printf("Element %d pushed onto the stack.\n", element);
    }
}

int pop() {
    if (top == -1) {
        printf("Stack Underflow. Cannot pop from an empty stack.\n");
        return -1; // indicating failure
    } else {
        int element = stack[top];
        top--;
        return element;
    }
}

void display() {
    if (top == -1) {
        printf("Stack is empty.\n");
    } else {
        printf("Stack elements: ");
        for (int i = 0; i <= top; i++) {
            printf("%d ", stack[i]);
        }
        printf("\n");
    }
}