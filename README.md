# Process Management in C (fork, wait, getpid)

Three small C programs demonstrating basic Unix/Linux process management system calls. All three codes are in `codes.txt`.

## Key Concepts

| Call | Purpose |
|------|---------|
| `fork()` | Creates a new child process by duplicating the calling (parent) process. Returns `0` in the child, the child's PID in the parent, and `-1` on failure. |
| `wait(NULL)` | Makes the parent block until a child terminates, then "reaps" it (cleans up its process table entry). Returns the terminated child's PID. |
| `getpid()` | Returns the PID (process ID) of the calling process. |
| `exit(0)` | Terminates the process with status 0 (success). |

## Program 1: Basic fork + wait

- `fork()` creates a child.
- **Child** (`p == 0`): prints "Child working..." and exits.
- **Parent**: calls `wait(NULL)`, which blocks until the child exits, then prints the reaped child's PID.
- Waiting prevents the child from becoming a **zombie process**.

**Sample output:**
```
Child working...
Child 12346 reaped successfully!
```

## Program 2: fork + wait with PIDs

An extended version that shows more detail:
- Child prints its own PID using `getpid()`, calls `sleep(0)` (no actual delay; increase the value to simulate work), then prints "Child Exiting..." and exits.
- Parent prints "Parent Waiting...", blocks on `wait(NULL)`, then prints the PID of the terminated child.

**Sample output:**
```
Parent Waiting for child to terminate...
Child Running with PID:12346
Child Exiting...
Parent Terminated Child PID:12346
```
(Line order of parent/child messages may vary due to scheduling.)

## Program 3: getpid

The simplest program: prints the PID of the current process. Each run gives a different PID.

**Sample output:**
```
Current PID:12345
```

## How to Compile and Run

```bash
gcc program1.c -o program1
./program1
```
Repeat for the other programs (save each one as its own `.c` file).

## Notes

- Works on Linux/macOS (POSIX systems), not natively on Windows.
- Without `wait()`, a finished child stays as a zombie until the parent exits or reaps it.
- `wait(NULL)` ignores the child's exit status; pass an `int*` to read it.
