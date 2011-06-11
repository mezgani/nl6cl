#include <Python.h>
#include <errno.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/ioctl.h>
#include <stdio.h>
#include <stdlib.h>
#include <net/if.h>
#include <string.h>
#include <netinet/in.h>
#include <arpa/inet.h>


static PyObject* ifconfig(PyObject* self, PyObject* args)
{
    int io, sockfd;
    char address[20];
    char *interface;
    struct ifreq ifr;
    struct sockaddr_in *sin;

    if (!PyArg_ParseTuple(args, "s", &interface))
               return NULL;

    memset(&ifr, '0', sizeof(ifr));
    memset(address, '0', sizeof(address));
    snprintf(ifr.ifr_name, IFNAMSIZ, interface);

    if ((sockfd = socket(AF_INET, SOCK_DGRAM, IPPROTO_IP)) < 0){
        PyErr_SetString(PyExc_OSError, strerror(errno));
        return NULL;
    }

    io = ioctl(sockfd, SIOCGIFADDR, &ifr);
    if(io < 0){
        PyErr_SetString(PyExc_OSError, strerror(errno));
        return NULL;
    }
    close(sockfd);
    sin = (struct sockaddr_in *)&ifr.ifr_broadaddr;
    sprintf(address, "%s", inet_ntoa(sin->sin_addr));
    return PyString_FromString(address);
}

static PyMethodDef methods[] = {
    {"ifconfig", ifconfig, METH_VARARGS, "Return IP address."},
    {NULL, NULL, 0, NULL}
};
 
PyMODINIT_FUNC
initifconfig(void)
{
  (void) Py_InitModule("ifconfig", methods);

}




