const char *progname = "check_file_exists";
const char *revision = "Revision: 1.0";
const char *copyright = "2006";
const char *email = "hugo@op5.se";

#include "common.h"
#include "utils.h"

int process_arguments (int, char **);
void print_usage ();
void print_help ();
int same_arg(const char* value, const char *arg1, const char *arg2);

int
main (int argc, char **argv)
{
	int i = 0, j = 0;
	int result = STATE_UNKNOWN;
	char *filename = NULL;
	struct stat stat_buf;
	
	for (i = 1; i < argc; i++) {
		if (same_arg(argv[i], "-h", "--help")) {
			print_help();
			return STATE_OK;
		} else if (same_arg(argv[i], "-f", "--filename")) {
			i++;
			filename = argv[i];
		} else if (same_arg(argv[i], "-t", "--timeout")) {
			i++;
			timeout_interval = atoi(argv[i]);
		} else {
			print_usage();
			return STATE_UNKNOWN;
		}
	}

	if (!filename) {
		/* No filename given */
		print_usage();
		return STATE_UNKNOWN;
	}
	
	signal (SIGALRM, timeout_alarm_handler);
	alarm (timeout_interval);

	if (stat(filename, &stat_buf) == 0) {
		/* File exists. */
		printf("OK - File %s exists.\n", filename);
		return STATE_OK;
	} else {
		/* File does not exist. */
		printf("CRITICAL - File %s does not exist.\n", filename);
		return STATE_CRITICAL;
	}
	
	return result;
}

int same_arg(const char* value, const char *arg1, const char *arg2) {	
	if ((strcmp(value, arg1) == 0) || (strcmp(value, arg2) == 0))
		return 1;
	else
		return 0;
}
	
void print_usage() {
    printf("Usage: check_file_exists -f <filename> [-t <timeout>]\n");
}

void print_help() {
	    print_usage();
	    printf("\n");
	    printf("Options:\n");
	    printf("-f|--filename (string)\n");
	    printf("  set the filename to check for existance\n");
	    printf("\n");
}
