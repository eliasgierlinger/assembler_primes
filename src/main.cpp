#include <iostream>
#define arrlen 254

extern "C" unsigned char* GetPrimes();

int main() {
	unsigned char* arr = GetPrimes();
	
	for (int i = 0; i < arrlen; i++) {
		int cur = (int)arr[i];
		if (cur != 0) {
			std::cout << cur << std::endl;
		}
	}

	return 1;
}
