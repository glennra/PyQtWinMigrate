
%ModuleCode
#include "qmfcapp.h"
%End

class QMfcApp :  QApplication
{

%TypeHeaderCode
#include "qmfcapp.h"
%End

public:
    static bool pluginInstance(Qt::HANDLE plugin = 0);

#ifdef QTWINMIGRATE_WITHMFC
    static int run(CWinApp *mfcApp);
    static QApplication *instance(CWinApp *mfcApp);
    QMfcApp(CWinApp *mfcApp, int &argc, char **argv);
#endif
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
    int idleCount;
    bool doIdle;
};

#endif // QMFCAPP_H
