#include "vncitem.hpp"

#include <QPainter>

VncItem::VncItem(QQuickItem* parent)
{
	QObject::connect(
		this, &VncItem::frameUpdated, this, &VncItem::onFrameUpdated);
}

VncItem::~VncItem()
{
	stop();
}

void VncItem::paint(QPainter* painter)
{
	painter->drawImage(clipRect(), m_frame);
}

void VncItem::connect()
{
	m_client                      = rfbGetClient(8, 3, 4);
	m_client->format.depth        = 24;
	m_client->format.depth        = 16;
	m_client->format.bitsPerPixel = 16;
	m_client->format.redShift     = 11;
	m_client->format.greenShift   = 5;
	m_client->format.blueShift    = 0;
	m_client->format.redMax       = 0x1f;
	m_client->format.greenMax     = 0x3f;
	m_client->format.blueMax      = 0x1f;

	m_client->appData.compressLevel = 9;
	m_client->appData.qualityLevel  = 1;

	m_client->appData.encodingsString   = "ultra";
	m_client->FinishedFrameBufferUpdate = finishedFramebufferUpdateSt;
	m_client->canHandleNewFBSize        = TRUE;
	m_client->serverHost = strdup(ipAddress().toUtf8().constData());
	m_client->serverPort = port();

	rfbClientSetClientData(m_client, nullptr, this);

	if (rfbInitClient(m_client, 0, nullptr)) {
		setOpaquePainting(true);
	}
	else {
		return;
	}

	m_vncThread = new std::thread([this]() {
		while (m_enabled) {
			int i = WaitForMessage(m_client, 500);
			if (i < 0) {
				rfbClientCleanup(m_client);
				break;
			}

			if (i && !HandleRFBServerMessage(m_client)) {
				rfbClientCleanup(m_client);
				break;
			}
		};
	});
}

void VncItem::stop()
{
	m_enabled = false;
}

QString VncItem::ipAddress() const
{
	return m_ipAddress;
}

void VncItem::setIpAddress(const QString& ipAddress)
{
	m_ipAddress = ipAddress;
}
int VncItem::port() const
{
	return m_port;
}
void VncItem::setPort(int port)
{
	m_port = port;
}

void VncItem::gotFramebufferUpdateSt(rfbClient*, int, int, int, int) {}

void VncItem::gotFramebufferUpdate(rfbClient*, int, int, int, int) {}

void VncItem::finishedFramebufferUpdateSt(rfbClient* client)
{
	VncItem* vncItemPtr = (VncItem*) rfbClientGetClientData(client, nullptr);
	vncItemPtr->finishedFramebufferUpdate(client);
}

void VncItem::finishedFramebufferUpdate(rfbClient* client)
{
	m_frame = QImage(
		client->frameBuffer, client->width, client->height,
		QImage::Format_RGB16);
	Q_EMIT frameUpdated();
}

void VncItem::onFrameUpdated()
{
	update();
}
