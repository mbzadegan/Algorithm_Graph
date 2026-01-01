/* #pragma omp parallel sections
{
    #pragma omp section
    parallel_merge_sort(arr, left, mid, depth+1);

    #pragma omp section
    parallel_merge_sort(arr, mid+1, right, depth+1);
}

gcc -fopenmp parallel_mergesort.c -o mergesort

*/

#include <stdio.h>
#include <stdlib.h>
#include <omp.h>


void merge(int arr[], int left, int mid, int right) {
    int n1 = mid - left + 1;
    int n2 = right - mid;
    int *L = malloc(n1 * sizeof(int));
    int *R = malloc(n2 * sizeof(int));

    for (int i = 0; i < n1; i++)
        L[i] = arr[left + i];
    for (int i = 0; i < n2; i++)
        R[i] = arr[mid + 1 + i];

    int i = 0, j = 0, k = left;

    while (i < n1 && j < n2) {
        if (L[i] <= R[j]) arr[k++] = L[i++];
        else arr[k++] = R[j++];
    }

    while (i < n1) arr[k++] = L[i++];
    while (j < n2) arr[k++] = R[j++];

    free(L);
    free(R);
}

void parallel_merge_sort(int arr[], int left, int right, int depth) {
    if (left < right) {
        int mid = left + (right - left) / 2;

        // Parallel sections for left and right recursion
        if (depth <= 3) {   // limit depth to avoid oversubscription
            #pragma omp parallel sections
            {
                #pragma omp section
                parallel_merge_sort(arr, left, mid, depth + 1);

                #pragma omp section
                parallel_merge_sort(arr, mid + 1, right, depth + 1);
            }
        } else {
            // Fall back to sequential recursion
            parallel_merge_sort(arr, left, mid, depth + 1);
            parallel_merge_sort(arr, mid + 1, right, depth + 1);
        }

        merge(arr, left, mid, right);
    }
}

int main() {
    int n;
    printf("Enter number of elements: ");
    scanf("%d", &n);

    int *arr = malloc(n * sizeof(int));
    printf("Enter %d integers:\n", n);
    for (int i = 0; i < n; i++)
        scanf("%d", &arr[i]);

    double start = omp_get_wtime();
    
    parallel_merge_sort(arr, 0, n - 1, 0);

    double end = omp_get_wtime();

    printf("\nSorted output:\n");
    for (int i = 0; i < n; i++)
        printf("%d ", arr[i]);
    
    printf("\n\nParallel execution time: %f seconds\n", end - start);

    free(arr);
    return 0;
}
