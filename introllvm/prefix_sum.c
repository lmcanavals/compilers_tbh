void prefix_sum(int* src, int* dst, int n) {
	if (0 < n) {
		int i = 0;
		do {
			int tmp = 0;
			int j = 0;
			if (j < i) {
				do {
					tmp += src[j];
					j++;
				} while (j < i);
				dst[i] = tmp;
			}
			++i;
		} while (i < n);
	}
}
