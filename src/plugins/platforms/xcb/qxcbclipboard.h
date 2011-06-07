/****************************************************************************
**
** Copyright (C) 2011 Nokia Corporation and/or its subsidiary(-ies).
** All rights reserved.
** Contact: Nokia Corporation (qt-info@nokia.com)
**
** This file is part of the plugins of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:LGPL$
** No Commercial Usage
** This file contains pre-release code and may not be distributed.
** You may use this file in accordance with the terms and conditions
** contained in the Technology Preview License Agreement accompanying
** this package.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 2.1 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPL included in the
** packaging of this file.  Please review the following information to
** ensure the GNU Lesser General Public License version 2.1 requirements
** will be met: http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** In addition, as a special exception, Nokia gives you certain additional
** rights.  These rights are described in the Nokia Qt LGPL Exception
** version 1.1, included in the file LGPL_EXCEPTION.txt in this package.
**
** If you have questions regarding the use of this file, please contact
** Nokia at qt-info@nokia.com.
**
**
**
**
**
**
**
**
** $QT_END_LICENSE$
**
****************************************************************************/

#ifndef QXCBCLIPBOARD_H
#define QXCBCLIPBOARD_H

#include <QPlatformClipboard>

#include <xcb/xcb.h>

class QXcbConnection;
class QXcbScreen;

class QXcbClipboard : public QPlatformClipboard
{
public:
    QXcbClipboard(QXcbConnection *connection);

    QMimeData *mimeData(QClipboard::Mode mode);
    void setMimeData(QMimeData *data, QClipboard::Mode mode);

    bool supportsMode(QClipboard::Mode mode) const;

    QXcbConnection *connection() const { return m_connection; }
    QXcbScreen *screen() const { return m_screen; }

    xcb_window_t requestor() const;
    void setRequestor(xcb_window_t window);

    xcb_window_t owner() const;

    void handleSelectionRequest(xcb_selection_request_event_t *event);

    bool clipboardReadProperty(xcb_window_t win, xcb_atom_t property, bool deleteProperty, QByteArray *buffer, int *size, xcb_atom_t *type, int *format) const;
    QByteArray clipboardReadIncrementalProperty(xcb_window_t win, xcb_atom_t property, int nbytes, bool nullterm);

    QByteArray getDataInFormat(xcb_atom_t modeAtom, xcb_atom_t fmtatom);

    xcb_window_t getSelectionOwner(xcb_atom_t atom) const;
    QByteArray getSelection(xcb_atom_t selection, xcb_atom_t target, xcb_atom_t property);

private:
    void setOwner(xcb_window_t window);

    xcb_generic_event_t *waitForClipboardEvent(xcb_window_t win, int type, int timeout);

    xcb_atom_t sendTargetsSelection(QMimeData *d, xcb_window_t window, xcb_atom_t property);
    xcb_atom_t sendSelection(QMimeData *d, xcb_atom_t target, xcb_window_t window, xcb_atom_t property);

    QXcbConnection *m_connection;
    QXcbScreen *m_screen;

    QMimeData *m_xClipboard;
    QMimeData *m_clientClipboard;

    QMimeData *m_xSelection;
    QMimeData *m_clientSelection;

    xcb_window_t m_requestor;
    xcb_window_t m_owner;

    static const int clipboard_timeout;

};

#endif // QXCBCLIPBOARD_H
