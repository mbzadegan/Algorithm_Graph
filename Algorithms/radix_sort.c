#include <stdio.h>
#include <stdlib.h>

// Function to find the maximum value in the array
// This is needed to know how many digits the largest number has
int getMax(int arr[], int n) {
    int max = arr[0];
    for (int i = 1; i < n; i++) {
        if (arr[i] > max)
            max = arr[i];
    }
    return max;
}

// A function to do counting sort of arr[] according to
// the digit represented by exp (1, 10, 100, etc.)
void countSort(int arr[], int n, int exp) {
    int *output = (int *)malloc(n * sizeof(int)); // Output array
    int count[10] = {0}; // Frequency array for digits 0-9
    int i;

    // Store count of occurrences in count[]
    for (i = 0; i < n; i++)
        count[(arr[i] / exp) % 10]++;

    // Change count[i] so that count[i] now contains actual
    // position of this digit in output[]
    for (i = 1; i < 10; i++)
        count[i] += count[i - 1];

    // Build the output array
    // We traverse backwards to ensure stability
    for (i = n - 1; i >= 0; i--) {
        output[count[(arr[i] / exp) % 10] - 1] = arr[i];
        count[(arr[i] / exp) % 10]--;
    }

    // Copy the output array to arr[], so that arr[] now
    // contains sorted numbers according to current digit
    for (i = 0; i < n; i++)
        arr[i] = output[i];

    free(output);
}

// The main function to that sorts arr[] of size n using Radix Sort
void radixSort(int arr[], int n) {
    // Find the maximum number to know number of digits
    int m = getMax(arr, n);

    // Do counting sort for every digit. Note that instead
    // of passing digit number, exp is passed. exp is 10^i
    // where i is current digit number
    for (int exp = 1; m / exp > 0; exp *= 10)
        countSort(arr, n, exp);
}

int main() {
    FILE *inputFile, *outputFile;
    int *arr;
    int n = 0, capacity = 10;
    int temp;

    // 1. Open Input File
    inputFile = fopen("input.txt", "r");
    if (inputFile == NULL) {
        printf("Error: Could not open input.txt\n");
        return 1;
    }

    // Allocate initial memory
    arr = (int *)malloc(capacity * sizeof(int));
    if (arr == NULL) {
        printf("Error: Memory allocation failed\n");
        return 1;
    }

    // 2. Read numbers from file
    // We resize the array dynamically if the file is large
    while (fscanf(inputFile, "%d", &temp) == 1) {
        if (n >= capacity) {
            capacity *= 2;
            int *newArr = (int *)realloc(arr, capacity * sizeof(int));
            if (newArr == NULL) {
                printf("Error: Memory reallocation failed\n");
                free(arr);
                fclose(inputFile);
                return 1;
            }
            arr = newArr;
        }
        arr[n++] = temp;
    }
    fclose(inputFile);

    if (n == 0) {
        printf("File is empty or contains no integers.\n");
        free(arr);
        return 0;
    }

    printf("Read %d numbers. Sorting...\n", n);

    // 3. Perform Radix Sort
    radixSort(arr, n);

    // 4. Write to Output File
    outputFile = fopen("output.txt", "w");
    if (outputFile == NULL) {
        printf("Error: Could not create output.txt\n");
        free(arr);
        return 1;
    }

    for (int i = 0; i < n; i++) {
        fprintf(outputFile, "%d\n", arr[i]);
    }

    printf("Sorting complete. Check output.txt\n");

    // Cleanup
    fclose(outputFile);
    free(arr);

    return 0;
}
