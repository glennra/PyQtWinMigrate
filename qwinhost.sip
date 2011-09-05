
typedef void *HINSTANCE;

%ModuleCode
#include "qwinhost.h"
%End

class QWinHost : QWidget
{

%TypeHeaderCode
#include "qwinhost.h"
%End

public:
    QWinHost(QWidget *parent /TransferThis/= 0, Qt::WFlags f = 0);
    ~QWinHost();

    void setWindow(HWND);
    HWND window() const;

protected:
    virtual HWND createWindow(HWND parent, HINSTANCE instance);

    bool event(QEvent *e);
    void showEvent(QShowEvent *);
    void focusInEvent(QFocusEvent*);
    void resizeEvent(QResizeEvent*);

    bool winEvent(MSG *msg, long *result);

/*
private:
    void fixParent();
    friend void* getWindowProc(QWinHost*);

    void *wndproc;
    bool own_hwnd;
    HWND hwnd;
*/
};
