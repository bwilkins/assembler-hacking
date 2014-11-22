char some_func() {
	return 'Y';
}

void main() {
	char* video_memory = 0xb8000;

	*video_memory = some_func();
}
