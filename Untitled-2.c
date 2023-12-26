#include<stdio.h>
int pop(int arr[]);
void push(int num,int arr[]);
void display(int arr[]);
int top = -1;
#define SIZE 5
int main ()
{
    int arr[SIZE] = {1,2,3};
    // display(arr);
    push(2,arr);
    return 0;
}
int pop(int arr[])
{
    if(top == -1)
    {
        printf("empty\n");
    }else{
        int poped = arr[top];
        top--;
        return poped;
    }
}
void push(int num,int arr[])
{
    if(top == SIZE-1)
    {
        printf("full\n");
    }else{
        top++;
        arr[top] = num;
        display(arr);
    }
}
void display(int arr[])
{
    for(int i=0 ; i<SIZE ; i++)
    {
        printf("%d\n",arr[i]);
    }
}