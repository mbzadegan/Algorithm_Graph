// QuickSort with Empirical Complexity Estimation
// Description: Reads numbers, sorts them using QuickSort,
// counts comparisons and swaps, and prints empirical complexity.

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

long long comparisons = 0; // global counter for comparisons
long long swaps = 0;       // global counter for swaps

// Swap two elements
void swap(int *a, int *b) {
    int temp = *a;
    *a = *b;
    *b = temp;
    swaps++;
}

// Partition function (Lomuto partition scheme)
int partition(int arr[], int low, int high) {
    int pivot = arr[high];
    int i = low - 1;
    for (int j = low; j < high; j++) {
        comparisons++;
        if (arr[j] <= pivot) {
            i++;
            swap(&arr[i], &arr[j]);
        }
    }
    swap(&arr[i + 1], &arr[high]);
    return i + 1;
}

// Recursive QuickSort
void quickSort(int arr[], int low, int high) {
    if (low < high) {
        int pi = partition(arr, low, high);
        quickSort(arr, low, pi - 1);
        quickSort(arr, pi + 1, high);
    }
}

// Function to print array
void printArray(int arr[], int n) {
    for (int i = 0; i < n; i++)
        printf("%d ", arr[i]);
    printf("\n");
}

int main() {
    int n;
    printf("Enter number of elements: ");
    scanf("%d", &n);

    int *arr = (int *)malloc(n * sizeof(int));
    if (!arr) {
        printf("Memory allocation failed.\n");
        return 1;
    }

    printf("Enter %d integers:\n", n);
    for (int i = 0; i < n; i++)
        scanf("%d", &arr[i]);

    clock_t start = clock();
    quickSort(arr, 0, n - 1);
    clock_t end = clock();

    double time_taken = ((double)(end - start)) / CLOCKS_PER_SEC;

    printf("\nSorted array:\n");
    printArray(arr, n);

    printf("\n=== QuickSort Complexity Report ===\n");
    printf("Number of elements (n): %d\n", n);
    printf("Comparisons: %lld\n", comparisons);
    printf("Swaps: %lld\n", swaps);
    printf("Execution time: %.6f seconds\n", time_taken);
    printf("Estimated O(n log n): %.2f\n", n * (log(n) / log(2)));
    printf("Empirical ratio (comparisons / n log n): %.2f\n",
           comparisons / (n * (log(n) / log(2))));

    free(arr);
    return 0;
}
