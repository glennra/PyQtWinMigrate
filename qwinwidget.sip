
%ModuleCode
#include "qwinwidget.h"
%End

class QWinWidget : QWidget
{

%TypeHeaderCode
#include "qwinwidget.h"
%End

public:
    QWinWidget( HWND hParentWnd, QObject *parent /TransferThis/= 0, Qt::WFlags f = 0 );
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
