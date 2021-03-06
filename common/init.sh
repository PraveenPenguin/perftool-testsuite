#
#	init.sh
#	Author: Michael Petlan <mpetlan@redhat.com>
#
#	Description:
#
#		This file should be used for initialization of basic functions
#	for checking, reporting results etc.
#
#


. ../common/settings.sh
. ../common/patterns.sh

THIS_TEST_NAME=`basename $0 .sh`

_echo()
{
	test "$TESTLOG_VERBOSITY" -ne 0 && echo -e "$@"
}

print_results()
{
	PERF_RETVAL="$1"; shift
	CHECK_RETVAL="$1"; shift
	FAILURE_REASON=""
	TASK_COMMENT="$@"
	if [ $PERF_RETVAL -eq 0 -a $CHECK_RETVAL -eq 0 ]; then
		_echo "$MPASS-- [ PASS ] --$MEND $TEST_NAME :: $THIS_TEST_NAME :: $TASK_COMMENT"
		return 0
	else
		if [ $PERF_RETVAL -ne 0 ]; then
			FAILURE_REASON="command exitcode"
		fi
		if [ $CHECK_RETVAL -ne 0 ]; then
			test -n "$FAILURE_REASON" && FAILURE_REASON="$FAILURE_REASON + "
			FAILURE_REASON="$FAILURE_REASON""output regexp parsing"
		fi
		_echo "$MFAIL-- [ FAIL ] --$MEND $TEST_NAME :: $THIS_TEST_NAME :: $TASK_COMMENT ($FAILURE_REASON)"
		return 1
	fi
}

print_overall_results()
{
	RETVAL="$1"; shift
	if [ $RETVAL -eq 0 ]; then
		_echo "$MALLPASS## [ PASS ] ##$MEND $TEST_NAME :: $THIS_TEST_NAME SUMMARY"
	else
		_echo "$MALLFAIL## [ FAIL ] ##$MEND $TEST_NAME :: $THIS_TEST_NAME SUMMARY :: $RETVAL failures found"
	fi
	return $RETVAL
}

print_testcase_skipped()
{
	TASK_COMMENT="$@"
	_echo "$MSKIP-- [ SKIP ] --$MEND $TEST_NAME :: $THIS_TEST_NAME :: $TASK_COMMENT :: testcase skipped"
	return 0
}

print_overall_skipped()
{
	_echo "$MSKIP## [ SKIP ] ##$MEND $TEST_NAME :: $THIS_TEST_NAME :: testcase skipped"
	return 0
}

detect_baremetal()
{
	# return values:
	# 0 = bare metal
	# 1 = virtualization detected
	# 2 = unknown state
	VIRT=`systemd-detect-virt 2>/dev/null`
	test $? -eq 127 && return 2
	test "$VIRT" = "none"
}

detect_intel()
{
	# return values:
	# 0 = is Intel
	# 1 = is not Intel or unknown
	grep "vendor_id" < /proc/cpuinfo | grep -q "GenuineIntel"
}

detect_amd()
{
	# return values:
	# 0 = is AMD
	# 1 = is not AMD or unknown
	grep "vendor_id" < /proc/cpuinfo | grep -q "AMD"
}
