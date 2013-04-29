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
#include "qwinwidget.h"
%End

class QWinWidget : QWidget
{

%TypeHeaderCode
#include "moc_qwinwidget.h"
%End

public:
    QWinWidget( int hParentWnd, QObject *parent /TransferThis/= 0, Qt::WFlags f = 0 ) [(HWND hParentWnd, QObject *parent, Qt::WFlags f)];
%MethodCode
        Py_BEGIN_ALLOW_THREADS
        sipCpp = new sipQWinWidget((HWND)a0, a1, *a2);
        Py_END_ALLOW_THREADS
%End 
    ~QWinWidget();

    void show();
    void center();
    void showCentered();

    HWND parentWindow() const;

protected:
    void childEvent( QChildEvent *e );
    bool eventFilter( QObject *o, QEvent *e );

    bool focusNextPrevChild(bool next);
    void focusInEvent(QFocusEvent *e);

    bool winEvent(MSG *msg, long *result);

/*
private:
    void init();

    void saveFocus();
    void resetFocus();

    HWND hParent;
    HWND prevFocus;
    bool reenable_parent;
*/
};
