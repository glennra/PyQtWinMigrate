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
