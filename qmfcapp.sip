/*
 * This file is part of PyQtWinMigrate.
 * 
 * PyQtWinMigrate is free software: you can redistribute it and/or modify
 * it under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

%ModuleCode
#include "qmfcapp.h"
%End

class QMfcApp :  QApplication
{

%TypeHeaderCode
#include "qmfcapp.h"
//#include "afxwin.h"
%End

%TypeCode
// Convert a Python argv list to a conventional C argc count and argv array.
static char **qpycore_ArgvToC(PyObject *argvlist, int &argc)
{
    char **argv;

    argc = PyList_GET_SIZE(argvlist);

    // Allocate space for two copies of the argument pointers, plus the
    // terminating NULL.
    if ((argv = (char **)sipMalloc(2 * (argc + 1) * sizeof (char *))) == NULL)
        return NULL;

    // Convert the list.
    for (int a = 0; a < argc; ++a)
    {
        char *arg;

        // Get the argument and allocate memory for it.
        if ((arg = PyString_AsString(PyList_GET_ITEM(argvlist, a))) == NULL ||
            (argv[a] = (char *)sipMalloc(strlen(arg) + 1)) == NULL)
            return NULL;

        // Copy the argument and save a pointer to it.
        strcpy(argv[a], arg);
        argv[a + argc + 1] = argv[a];
    }

    argv[argc + argc + 1] = argv[argc] = NULL;

    return argv;
}


// Remove arguments from the Python argv list that have been removed from the
// C argv array.
static void qpycore_UpdatePyArgv(PyObject *argvlist, int argc, char **argv)
{
    for (int a = 0, na = 0; a < argc; ++a)
    {
        // See if it was removed.
        if (argv[na] == argv[a + argc + 1])
            ++na;
        else
            PyList_SetSlice(argvlist, na, na + 1, NULL);
    }
}
%End


public:
    static bool pluginInstance(int plugin);
%MethodCode
        long hInstance = (long)a0;
        Py_BEGIN_ALLOW_THREADS
        sipRes = QMfcApp::pluginInstance((Qt::HANDLE)hInstance);
        Py_END_ALLOW_THREADS
%End
        

/*    
//#ifdef QTWINMIGRATE_WITHMFC
    static int run(CWinApp *mfcApp);
    static QApplication *instance(CWinApp *mfcApp);
    QMfcApp(CWinApp *mfcApp, int &argc, char **argv);
//endif
*/
    //QMfcApp(int &argc, char **argv);
    QMfcApp(SIP_PYLIST argv /DocType="list-of-str"/) /PostHook=__pyQtQAppHook__/ [(int &argc, char **argv)];
%MethodCode
        // The Python interface is a list of argument strings that is modified.
        
        int argc;
        char **argv;
        
        // Convert the list.
        if ((argv = qpycore_ArgvToC(a0, argc)) == NULL)
            sipIsErr = 1;
        else
        {
            // Create it now the arguments are right.
            static int nargc;
            nargc = argc;
        
            Py_BEGIN_ALLOW_THREADS
            sipCpp = new sipQMfcApp(nargc, argv);
            Py_END_ALLOW_THREADS
        
            // Now modify the original list.
            qpycore_UpdatePyArgv(a0, argc, argv);
        }
%End
    ~QMfcApp();

    bool winEventFilter(MSG *msg, long *result);

    static void enterModalLoop();
    static void exitModalLoop();
/*
private:
#ifdef QTWINMIGRATE_WITHMFC
    static char ** mfc_argv;
    static int mfc_argc;
    static CWinApp *mfc_app;
#endif
*/
//    int idleCount;
//    bool doIdle;
};

//#endif // QMFCAPP_H
