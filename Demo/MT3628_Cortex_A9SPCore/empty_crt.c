#include <sys/types.h>
#include <sys/stat.h>
#include <unistd.h>

#ifdef __cplusplus
extern "C" {
	caddr_t _sbrk ( int incr );
}
#endif

caddr_t _sbrk ( int incr )
{
	return (caddr_t) 0;
}





#ifdef __cplusplus
extern "C" {
	int _write (int fd, char* buf, int nbytes);
}
#endif

/*
 * write -- write bytes to the serial port. Ignore fd, since
 *          stdout and stderr are the same. Since we have no filesystem,
 *          open will only return an error.
 */
int
_write (int fd, char* buf, int nbytes)

{
  return 0;
}

int _close(int fd)
{
  (void)fd;
  return (0);
}

int _fstat(int fd, struct stat *buf)
{
  (void)fd;
  buf->st_mode = S_IFCHR; /* Always pretend to be a tty */

  return (0);
}

int
_read (int fd, char* buf, int nbytes)
{
	return 0;
}

off_t _lseek(int fd, off_t offset, int whence)
{
return ((off_t)-1);
}

int _isatty(int fd)
{
  (void)fd;
  return (1);
}

