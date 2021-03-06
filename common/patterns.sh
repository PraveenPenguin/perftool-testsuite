export RE_NUMBER="[0-9\.]+"
# Number
# Examples:
#    123.456


export RE_NUMBER_HEX="[0-9A-Fa-f]+"
# Hexadecimal number
# Examples:
#    1234
#    a58d
#    aBcD
#    deadbeef


export RE_PROCESS_PID="\w+\/\d+"
# A process with PID
# Example:
#    sleep/4102


export RE_EVENT_ANY="[\w\-\:\/_=,]+"
# Name of any event (universal)
# Examples:
#    cpu-cycles
#    cpu/event=12,umask=34/
#    r41e1
#    nfs:nfs_getattr_enter


export RE_EVENT="[\w\-:_]+"
# Name of an usual event
# Examples:
#    cpu-cycles


export RE_EVENT_RAW="r$RE_NUMBER_HEX"
# Specification of a raw event
# Examples:
#    r41e1
#    r1a


export RE_EVENT_CPU="cpu/(\w=""$RE_NUMBER_HEX"",?)+/p*" # FIXME
# Specification of a CPU event
# Examples:
#    cpu/event=12,umask=34/pp


export RE_EVENT_UNCORE="uncore/[\w_]+/"
# Specification of an uncore event
# Examples:
#    uncore/qhl_request_local_reads/


export RE_EVENT_SUBSYSTEM="[\w\-]+:[\w\-]+"
# Name of an event from subsystem
# Examples:
#    ext4:ext4_ordered_write_end
#    sched:sched_switch


export RE_PATH="(?:\/[\w\+\.-]+)+"
# A full filepath
# Examples:
#    /usr/lib64/somelib.so.5.4.0
#    /lib/modules/4.3.0-rc5/kernel/fs/xfs/xfs.ko
#    /usr/bin/mv


export RE_LINE_COMMENT="^#.*"
# A comment line
# Examples:
#    # Started on Thu Sep 10 11:43:00 2015


export RE_LINE_EMPTY="^\s*$"
# An empty line with possible whitespaces
# Examples:
#


export RE_LINE_RECORD1="^\[\s+perf\s+record:\s+Woken up $RE_NUMBER times? to write data\s+\].*$"
# The first line of perf-record "OK" output
# Examples:
#    [ perf record: Woken up 1 times to write data ]


export RE_LINE_RECORD2="^\[\s+perf\s+record:\s+Captured and wrote $RE_NUMBER\s*MB\s+(?:[\w\+\.-]*(?:$RE_PATH)?\/)?perf\.data(?:\.\d+)?\s*\(~?$RE_NUMBER samples\)\s+\].*$"
# The second line of perf-record "OK" output
# Examples:
#    [ perf record: Captured and wrote 0.405 MB perf.data (109 samples) ]
#    [ perf record: Captured and wrote 0.405 MB perf.data (~109 samples) ]
#    [ perf record: Captured and wrote 0.405 MB /some/temp/dir/perf.data (109 samples) ]
#    [ perf record: Captured and wrote 0.405 MB ./perf.data (109 samples) ]
#    [ perf record: Captured and wrote 0.405 MB ./perf.data.3 (109 samples) ]


export RE_LINE_TRACE="^\s*$RE_NUMBER\s*\(\s*$RE_NUMBER\s*ms\s*\):\s*$RE_PROCESS_PID\s+.*\)\s+=\s+\-?$RE_NUMBER|$RE_NUMBER_HEX.*$"
# A line of perf-trace output
# Examples:
#    0.115 ( 0.005 ms): sleep/4102 open(filename: 0xd09e2ab2, flags: CLOEXEC                             ) = 3
#    0.157 ( 0.005 ms): sleep/4102 mmap(len: 3932736, prot: EXEC|READ, flags: PRIVATE|DENYWRITE, fd: 3   ) = 0x7f89d0605000

export RE_LINE_TRACE_SUMMARY_HEADER="\s*syscall\s+calls\s+total\s+min\s+avg\s+max\s+stddev"
# A header of a perf-trace summary table
# Example:
#    syscall            calls    total       min       avg       max      stddev


export RE_LINE_TRACE_SUMMARY_CONTENT="^\s*\w+\s+(?:$RE_NUMBER\s+){5}$RE_NUMBER%"
# A line of a perf-trace summary table
# Example:
#    open                   3     0.017     0.005     0.006     0.007     10.90%


export RE_LINE_REPORT_CONTENT="^\s+$RE_NUMBER%\s+\w+\s+\S+\s+\S+\s+\S+" # FIXME
# A line from typicap perf report --stdio output
# Example:
#    100.00%  sleep    [kernel.vmlinux]  [k] syscall_return_slowpath
