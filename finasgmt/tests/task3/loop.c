// This is our minimal startup code (usually in _start)
asm("li sp, 0x100000"); // SP set to 1 MB
asm("jal main");        // call main
asm("li a7, 10");       // prepare ecall exit
asm("ecall");           // now your simulator should stop

int sum(int arr[], int len)
{
	int _sum = 0;
	for(int i = 0; i < len; i++)
		_sum += arr[i];
	return _sum;
}

int main(void) 
{
	int len = 100;
	int arr[len];
	for(int i = 0; i < len; i++)
		arr[i] = i;
	return sum(arr, len);
}
