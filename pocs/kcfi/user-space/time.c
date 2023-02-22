#include "time.h"

#include <sys/time.h>

double get_time() {
	double result;
	struct timeval tv;
	if (gettimeofday(&tv, (struct timezone*) 0) == 0) {
		result = ((double) tv.tv_sec) + 0.000001 * (double) tv.tv_usec;
	} else {
		result = 0.0;
	}
    return result;
}
