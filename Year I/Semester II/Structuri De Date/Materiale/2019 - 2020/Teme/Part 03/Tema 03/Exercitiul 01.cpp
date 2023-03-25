#include <iostream> 
using namespace std;

void heapify(int arr[], int n, int i)
{
    int smallest = i;        // radacina
    int l = 2 * i + 1;       // stanga
    int r = 2 * i + 2;      // dreapta

    
    //daca copilul din stanga este mai mic ca radacina
    if (l < n && arr[l] < arr[smallest])
        smallest = l; //schimb radacina

    // la fel pentru dreapta
    if (r < n && arr[r] < arr[smallest])
        smallest = r;

    // daca cel mai mic nu e radacina
    int aux;
    if (smallest != i) 
    {
        
        aux = arr[i];
        arr[i] = arr[smallest];
        arr[smallest] = aux;
        
        // functie recursiva pentru subarborele modificat
        heapify(arr, n, smallest);
    }
}
void printArray(int arr[], int n) //afisare
{
    for (int i = 0; i < n; ++i)
        cout << arr[i] << " ";
    cout << "\n";
}
void insert(int arr[], int n, int item)
{
    
    if (n == 0)
        arr[n] = item;
    else
    {
        arr[n] = item;
        int aux, parent;
        parent = n / 2;
        while (arr[n] < arr[parent] && n>0)
        {
            aux = arr[n];
            arr[n] = arr[parent];
            arr[parent] = aux;

            n = parent;
            parent = n / 2;

        }
    }
}
int main()
{
    int arr[] = { 5, 6, 8, 2, 9 };
    int n = 5, i;
   /*
    int arr[100], n, i;
    cout << "dati lungime heap: ";
    cin >> n;
    cout << "dati elemente vector: "<<endl;
    
    for (i = 0; i < n; i++)
    {
        cout << "arr[" << i << "]= ";
        cin >> arr[i];
    }
    */
    // transformare vector->minheap
    for ( i = n / 2 - 1; i >= 0; i--)
        heapify(arr, n, i);

    //afisare heap 
    printArray(arr, n);

    //extragere minim (in minheap se afla pe pozitia 0):
    cout << "minimul este: " << arr[0] << endl;
    cout << "inserez elementul 3: " << endl;
    insert(arr, n, 3 );
    n++;
    printArray(arr, n);
    cout << "inserez elementul 4:" << endl;
    insert(arr, n, 4);
    n++;
    printArray(arr, n);
    cout << "inserez elementul 0:" << endl;
    insert(arr, n, 0);
    n++;
    printArray(arr, n);
    return 0;

}
