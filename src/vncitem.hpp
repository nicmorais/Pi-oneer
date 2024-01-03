#ifndef VNCITEM_H
#define VNCITEM_H

#include <QImage>
#include <QObject>
#include <QQmlEngine>
#include <QQuickPaintedItem>
#include <rfb/rfbclient.h>
#include <thread>

class VncItem : public QQuickPaintedItem
{
	Q_OBJECT

public:
	explicit VncItem(QQuickItem* parent = nullptr);
	~VncItem();
	void paint(QPainter*) override;
	Q_PROPERTY(QString ipAddress READ ipAddress WRITE setIpAddress)
	Q_PROPERTY(int port READ port WRITE setPort)
	Q_INVOKABLE void connect();
	Q_INVOKABLE void stop();
	QString ipAddress() const;
	void setIpAddress(const QString&);
	int port() const;
	void setPort(int);

	/**
	 * @brief gotFramebufferUpdateSt static callback for interfacing with
	 * libvncserver. will call VncItem::gotFramebufferUpdate
	 */
	static void gotFramebufferUpdateSt(rfbClient*, int, int, int, int);

	void gotFramebufferUpdate(rfbClient*, int, int, int, int);

	/**
	 * @brief finishedFramebufferUpdateSt static callback for interfacing with
	 * libvncserver. will call VncItem::finishedFramebufferUpdate
	 */
	static void finishedFramebufferUpdateSt(rfbClient*);

	void finishedFramebufferUpdate(rfbClient*);

public Q_SLOTS:
	void onFrameUpdated();

Q_SIGNALS:
	void frameUpdated();

private:
	rfbClient* m_client;
	std::atomic<bool> m_enabled = true;
	QString m_ipAddress;
	int m_port;
	QImage m_frame;
	std::thread* m_vncThread;
};

#endif // VNCITEM_H
