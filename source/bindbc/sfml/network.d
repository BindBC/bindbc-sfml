
//          Copyright 2020 - 2021 Michael D. Parker
// Distributed under the Boost Software License, Version 1.0.
//    (See accompanying file LICENSE_1_0.txt or copy at
//          http://www.boost.org/LICENSE_1_0.txt)

module bindbc.sfml.network;

import bindbc.sfml.config;
static if(bindSFMLNetwork):

import core.stdc.stddef : wchar_t;
import bindbc.sfml.system;

//Network/Types.h
struct sfFtpDirectoryResponse;
struct sfFtpListingResponse;
struct sfFtpResponse;
struct sfFtp;
struct sfHttpRequest;
struct sfHttpResponse;
struct sfHttp;
struct sfPacket;
struct sfSocketSelector;
struct sfTcpListener;
struct sfTcpSocket;
struct sfUdpSocket;

//Network/Ftp.h
enum sfFtpTransferMode{
	sfFtpBinary,
	sfFtpAscii,
	sfFtpEbcdic,
}
mixin(expandEnum!sfFtpTransferMode);

enum sfFtpStatus{
	sfFtpRestartMarkerReply = 110,
	sfFtpServiceReadySoon = 120,
	sfFtpDataConnectionAlreadyOpened = 125,
	sfFtpOpeningDataConnection = 150,
	sfFtpOk = 200,
	sfFtpPointlessCommand = 202,
	sfFtpSystemStatus = 211,
	sfFtpDirectoryStatus = 212,
	sfFtpFileStatus = 213,
	sfFtpHelpMessage = 214,
	sfFtpSystemType = 215,
	sfFtpServiceReady = 220,
	sfFtpClosingConnection = 221,
	sfFtpDataConnectionOpened = 225,
	sfFtpClosingDataConnection = 226,
	sfFtpEnteringPassiveMode = 227,
	sfFtpLoggedIn = 230,
	sfFtpFileActionOk = 250,
	sfFtpDirectoryOk = 257,
	sfFtpNeedPassword = 331,
	sfFtpNeedAccountToLogIn = 332,
	sfFtpNeedInformation = 350,
	sfFtpServiceUnavailable = 421,
	sfFtpDataConnectionUnavailable = 425,
	sfFtpTransferAborted = 426,
	sfFtpFileActionAborted = 450,
	sfFtpLocalError = 451,
	sfFtpInsufficientStorageSpace = 452,
	sfFtpCommandUnknown = 500,
	sfFtpParametersUnknown = 501,
	sfFtpCommandNotImplemented = 502,
	sfFtpBadCommandSequence = 503,
	sfFtpParameterNotImplemented = 504,
	sfFtpNotLoggedIn = 530,
	sfFtpNeedAccountToStore = 532,
	sfFtpFileUnavailable = 550,
	sfFtpPageTypeUnknown = 551,
	sfFtpNotEnoughMemory = 552,
	sfFtpFilenameNotAllowed = 553,
	sfFtpInvalidResponse = 1000,
	sfFtpConnectionFailed = 1001,
	sfFtpConnectionClosed = 1002,
	sfFtpInvalidFile = 1003,
}
mixin(expandEnum!sfFtpStatus);

//Network/Http.h
static if(sfmlSupport >= SFMLSupport.sfml200){
	enum sfHttpMethod{
		sfHttpGet,
		sfHttpPost,
		sfHttpHead,
		sfHttpPut,
		sfHttpDelete,
	}
}else{
	enum sfHttpMethod{
		sfHttpGet,
		sfHttpPost,
		sfHttpHead,
	}
}
mixin(expandEnum!sfHttpMethod);

enum sfHttpStatus{
	sfHttpOk = 200,
	sfHttpCreated = 201,
	sfHttpAccepted = 202,
	sfHttpNoContent = 204,
	sfHttpResetContent = 205,
	sfHttpPartialContent = 206,
	sfHttpMultipleChoices = 300,
	sfHttpMovedPermanently = 301,
	sfHttpMovedTemporarily = 302,
	sfHttpNotModified = 303,
	sfHttpBadRequest = 400,
	sfHttpUnauthorized = 401,
	sfHttpForbidden = 403,
	sfHttpNotFound = 404,
	sfHttpRangeNotSatisfiable = 407,
	sfHttpInternalServerError = 500,
	sfHttpNotImplemented = 501,
	sfHttpBadGateway = 502,
	sfHttpServiceNotAvailable = 503,
	sfHttpGatewayTimeout = 504,
	sfHttpVersionNotSupported = 505,
	sfHttpInvalidResponse = 1000,
	sfHttpConnectionFailed = 1001,
}
mixin(expandEnum!sfHttpStatus);

// Netork/IpAddress.h
struct sfIpAddress{
	char[16] address;
}

// Helper functions to replace the C constants
const(sfIpAddress) sfIpAddress_Any(){
	return sfIpAddress_fromBytes(0, 0, 0, 0);
}

const(sfIpAddress) sfIpAddress_LocalHost(){
	return sfIpAddress_fromBytes(127, 0, 0, 1);
}

const(sfIpAddress) sfIpAddress_Broadcast(){
	return sfIpAddress_fromBytes(255, 255, 255, 255);
}

//Network/SocketStatus.h
static if(sfmlSupport >= SFMLSupport.sfml230){
	enum sfSocketStatus{
		sfSocketDone,
		sfSocketNotReady,
		sfSocketPartial,
		sfSocketDisconnected,
		sfSocketError,
	}
}else{
	enum sfSocketStatus{
		sfSocketDone,
		sfSocketNotReady,
		sfSocketDisconnected,
		sfSocketError,
	}
}
mixin(expandEnum!sfSocketStatus);

static if(staticSFML){
	extern(C) @nogc nothrow{
		//Network/Ftp.h
		void sfFtpListingResponse_destroy(sfFtpListingResponse* ftpListingResponse);
		sfBool sfFtpListingResponse_isOk(const(sfFtpListingResponse)* ftpListingResponse);
		sfFtpStatus sfFtpListingResponse_getStatus(const(sfFtpListingResponse)* ftpListingResponse);
		const(char)* sfFtpListingResponse_getMessage(const(sfFtpListingResponse)* ftpListingResponse);
		size_t sfFtpListingResponse_getCount(const(sfFtpListingResponse)* ftpListingResponse);
		const(char)* sfFtpListingResponse_getName(const(sfFtpListingResponse)* ftpListingResponse, size_t index);
		void sfFtpDirectoryResponse_destroy(sfFtpDirectoryResponse* ftpDirectoryResponse);
		sfBool sfFtpDirectoryResponse_isOk(const(sfFtpDirectoryResponse)* ftpDirectoryResponse);
		sfFtpStatus sfFtpDirectoryResponse_getStatus(const(sfFtpDirectoryResponse)* ftpDirectoryResponse);
		const(char)* sfFtpDirectoryResponse_getMessage(const(sfFtpDirectoryResponse)* ftpDirectoryResponse);
		const(char)* sfFtpDirectoryResponse_getDirectory(const(sfFtpDirectoryResponse)* ftpDirectoryResponse);
		void sfFtpResponse_destroy(sfFtpResponse* ftpResponse);
		sfBool sfFtpResponse_isOk(const(sfFtpResponse)* ftpResponse);
		sfFtpStatus sfFtpResponse_getStatus(const(sfFtpResponse)* ftpResponse);
		const(char)* sfFtpResponse_getMessage(const(sfFtpResponse)* ftpResponse);
		sfFtp* sfFtp_create();
		void sfFtp_destroy(sfFtp* ftp);
		sfFtpResponse* sfFtp_connect(sfFtp* ftp, sfIpAddress server, ushort port, sfTime timeout);
		sfFtpResponse* sfFtp_loginAnonymous(sfFtp* ftp);
		sfFtpResponse* sfFtp_login(sfFtp* ftp, const(char)* name, const(char)* password);
		sfFtpResponse* sfFtp_disconnect(sfFtp* ftp);
		sfFtpResponse* sfFtp_keepAlive(sfFtp* ftp);
		sfFtpDirectoryResponse* sfFtp_getWorkingDirectory(sfFtp* ftp);
		sfFtpListingResponse* sfFtp_getDirectoryListing(sfFtp* ftp, const(char)* directory);
		sfFtpResponse* sfFtp_changeDirectory(sfFtp* ftp, const(char)* directory);
		sfFtpResponse* sfFtp_parentDirectory(sfFtp* ftp);
		sfFtpResponse* sfFtp_createDirectory(sfFtp* ftp, const(char)* name);
		sfFtpResponse* sfFtp_deleteDirectory(sfFtp* ftp, const(char)* name);
		sfFtpResponse* sfFtp_renameFile(sfFtp* ftp, const(char)* file, const(char)* newName);
		sfFtpResponse* sfFtp_deleteFile(sfFtp* ftp, const(char)* name);
		sfFtpResponse* sfFtp_download(sfFtp* ftp, const(char)* remoteFile, const(char)* destPath, sfFtpTransferMode mode);
		
		static if(sfmlSupport >= SFMLSupport.sfml250){
			sfFtpResponse* sfFtp_upload(sfFtp* ftp, const(char)* localFile, const(char)* destPath, sfFtpTransferMode mode, sfBool append);
		}else{
			sfFtpResponse* sfFtp_upload(sfFtp* ftp, const(char)* localFile, const(char)* destPath, sfFtpTransferMode mode);
		}
		
		//Network/Http.h
		sfHttpRequest* sfHttpRequest_create();
		void sfHttpRequest_destroy(sfHttpRequest* httpRequest);
		void sfHttpRequest_setField(sfHttpRequest* httpRequest, const(char)* field, const(char)* value);
		void sfHttpRequest_setMethod(sfHttpRequest* httpRequest, sfHttpMethod method);
		void sfHttpRequest_setUri(sfHttpRequest* httpRequest, const(char)* uri);
		void sfHttpRequest_setHttpVersion(sfHttpRequest* httpRequest, uint major, uint minor);
		void sfHttpRequest_setBody(sfHttpRequest* httpRequest, const(char)* body);
		void sfHttpResponse_destroy(sfHttpResponse* httpResponse);
		const(char)* sfHttpResponse_getField(const(sfHttpResponse)* httpResponse, const(char)* field);
		sfHttpStatus sfHttpResponse_getStatus(const(sfHttpResponse)* httpResponse);
		uint sfHttpResponse_getMajorVersion(const(sfHttpResponse)* httpResponse);
		uint sfHttpResponse_getMinorVersion(const(sfHttpResponse)* httpResponse);
		const(char)* sfHttpResponse_getBody(const(sfHttpResponse)* httpResponse);
		sfHttp* sfHttp_create();
		void sfHttp_destroy(sfHttp* http);
		void sfHttp_setHost(sfHttp* http, const(char)* host, ushort port);
		sfHttpResponse* sfHttp_sendRequest(sfHttp* http, const(sfHttpRequest)* request, sfTime timeout);
		
		//Network/IpAddress.h
		sfIpAddress sfIpAddress_fromString(const(char)* address);
		sfIpAddress sfIpAddress_fromBytes(sfUint8 byte0, sfUint8 byte1, sfUint8 byte2, sfUint8 byte3);
		sfIpAddress sfIpAddress_fromInteger(sfUint32 address);
		void sfIpAddress_toString(sfIpAddress address, char* string);
		sfUint32 sfIpAddress_toInteger(sfIpAddress address);
		sfIpAddress sfIpAddress_getLocalAddress();
		sfIpAddress sfIpAddress_getPublicAddress(sfTime timeout);
		
		//Network/Packet.h
		sfPacket* sfPacket_create();
		sfPacket* sfPacket_copy(const(sfPacket)* packet);
		void sfPacket_destroy(sfPacket* packet);
		void sfPacket_append(sfPacket* packet, const(void)* data, size_t sizeInBytes);
		void sfPacket_clear(sfPacket* packet);
		const(void)* sfPacket_getData(const(sfPacket)* packet);
		size_t sfPacket_getDataSize(const(sfPacket)* packet);
		sfBool sfPacket_endOfPacket(const(sfPacket)* packet);
		sfBool sfPacket_canRead(const(sfPacket)* packet);
		sfBool sfPacket_readBool(sfPacket* packet);
		sfInt8 sfPacket_readInt8(sfPacket* packet);
		sfUint8 sfPacket_readUint8(sfPacket* packet);
		sfInt16 sfPacket_readInt16(sfPacket* packet);
		sfUint16 sfPacket_readUint16(sfPacket* packet);
		sfInt32 sfPacket_readInt32(sfPacket* packet);
		sfUint32 sfPacket_readUint32(sfPacket* packet);
		float sfPacket_readFloat(sfPacket* packet);
		double sfPacket_readDouble(sfPacket* packet);
		void sfPacket_readString(sfPacket* packet, char* string_);
		void sfPacket_readWideString(sfPacket* packet, wchar_t* string_);
		void sfPacket_writeBool(sfPacket* packet, sfBool);
		void sfPacket_writeInt8(sfPacket* packet, sfInt8);
		void sfPacket_writeUint8(sfPacket* packet, sfUint8);
		void sfPacket_writeInt16(sfPacket* packet, sfInt16);
		void sfPacket_writeUint16(sfPacket* packet, sfUint16);
		void sfPacket_writeInt32(sfPacket* packet, sfInt32);
		void sfPacket_writeUint32(sfPacket* packet, sfUint32);
		void sfPacket_writeFloat(sfPacket* packet, float);
		void sfPacket_writeDouble(sfPacket* packet, double);
		void sfPacket_writeString(sfPacket* packet, const(char)* string_);
		void sfPacket_writeWideString(sfPacket* packet, const(wchar_t)* string_);
		
		//Network/SocketSelector.h
		sfSocketSelector* sfSocketSelector_create();
		sfSocketSelector* sfSocketSelector_copy(const(sfSocketSelector)* selector);
		void sfSocketSelector_destroy(sfSocketSelector* selector);
		void sfSocketSelector_addTcpListener(sfSocketSelector* selector, sfTcpListener* socket);
		void sfSocketSelector_addTcpSocket(sfSocketSelector* selector, sfTcpSocket* socket);
		void sfSocketSelector_addUdpSocket(sfSocketSelector* selector, sfUdpSocket* socket);
		void sfSocketSelector_removeTcpListener(sfSocketSelector* selector, sfTcpListener* socket);
		void sfSocketSelector_removeTcpSocket(sfSocketSelector* selector, sfTcpSocket* socket);
		void sfSocketSelector_removeUdpSocket(sfSocketSelector* selector, sfUdpSocket* socket);
		void sfSocketSelector_clear(sfSocketSelector* selector);
		sfBool sfSocketSelector_wait(sfSocketSelector* selector, sfTime timeout);
		sfBool sfSocketSelector_isTcpListenerReady(const(sfSocketSelector)* selector, sfTcpListener* socket);
		sfBool sfSocketSelector_isTcpSocketReady(const(sfSocketSelector)* selector, sfTcpSocket* socket);
		sfBool sfSocketSelector_isUdpSocketReady(const(sfSocketSelector)* selector, sfUdpSocket* socket);
		
		//Network/TcpListener.h
		sfTcpListener* sfTcpListener_create();
		void sfTcpListener_destroy(sfTcpListener* listener);
		void sfTcpListener_setBlocking(sfTcpListener* listener, sfBool blocking);
		sfBool sfTcpListener_isBlocking(const(sfTcpListener)* listener);
		ushort sfTcpListener_getLocalPort(const(sfTcpListener)* listener);
		sfSocketStatus sfTcpListener_accept(sfTcpListener* listener, sfTcpSocket** connected);
		
		static if(sfmlSupport >= SFMLSupport.sfml240){
			sfSocketStatus sfTcpListener_listen(sfTcpListener* listener, ushort port, sfIpAddress address);
		}else{
			sfSocketStatus sfTcpListener_listen(sfTcpListener* listener, ushort port);
		}
		
		//Network/TcpSocket.h
		sfTcpSocket* sfTcpSocket_create();
		void sfTcpSocket_destroy(sfTcpSocket* socket);
		void sfTcpSocket_setBlocking(sfTcpSocket* socket, sfBool blocking);
		sfBool sfTcpSocket_isBlocking(const(sfTcpSocket)* socket);
		ushort sfTcpSocket_getLocalPort(const(sfTcpSocket)* socket);
		sfIpAddress sfTcpSocket_getRemoteAddress(const(sfTcpSocket)* socket);
		ushort sfTcpSocket_getRemotePort(const(sfTcpSocket)* socket);
		sfSocketStatus sfTcpSocket_connect(sfTcpSocket* socket, sfIpAddress remoteAddress, ushort remotePort, sfTime timeout);
		void sfTcpSocket_disconnect(sfTcpSocket* socket);
		sfSocketStatus sfTcpSocket_send(sfTcpSocket* socket, const(void)* data, size_t size);
		sfSocketStatus sfTcpSocket_receive(sfTcpSocket* socket, void* data, size_t size, size_t* received);
		sfSocketStatus sfTcpSocket_sendPacket(sfTcpSocket* socket, sfPacket* packet);
		sfSocketStatus sfTcpSocket_receivePacket(sfTcpSocket* socket, sfPacket* packet);

		//Network/UdpSocket.h
		sfUdpSocket* sfUdpSocket_create();
		void sfUdpSocket_destroy(sfUdpSocket* socket);
		void sfUdpSocket_setBlocking(sfUdpSocket* socket, sfBool blocking);
		sfBool sfUdpSocket_isBlocking(const(sfUdpSocket)* socket);
		ushort sfUdpSocket_getLocalPort(const(sfUdpSocket)* socket);
		void sfUdpSocket_unbind(sfUdpSocket* socket);
		sfSocketStatus sfUdpSocket_send(sfUdpSocket* socket, const(void)* data, size_t size, sfIpAddress remoteAddress, ushort remotePort);
		sfSocketStatus sfUdpSocket_receive(sfUdpSocket* socket, void* data, size_t size, size_t* received, sfIpAddress* remoteAddress, ushort* remotePort);
		sfSocketStatus sfUdpSocket_sendPacket(sfUdpSocket* socket, sfPacket* packet, sfIpAddress remoteAddress, ushort remotePort);
		sfSocketStatus sfUdpSocket_receivePacket(sfUdpSocket* socket, sfPacket* packet, sfIpAddress* remoteAddress, ushort* remotePort);
		uint sfUdpSocket_maxDatagramSize();
		
		static if(sfmlSupport >= SFMLSupport.sfml240){
			sfSocketStatus sfUdpSocket_bind(sfUdpSocket* socket, ushort port, sfIpAddress address);
		}else{
			sfSocketStatus sfUdpSocket_bind(sfUdpSocket* socket, ushort port);
		}
		
		//New functions
		static if(sfmlSupport >= SFMLSupport.sfml230){
			//Network/TcpSocket.h
			sfSocketStatus sfTcpSocket_sendPartial(sfTcpSocket* socket, const(void)* data, size_t size, size_t* sent);
		}
		static if(sfmlSupport >= SFMLSupport.sfml240){
			//Network/Ftp.h
			sfFtpResponse* sfFtp_sendCommand(sfFtp* ftp, const(char)* command, const(char)* parameter);
		}
	}
}else{
	import bindbc.loader;
	
	extern(C) @nogc nothrow{
		//Network/Ftp.h
		alias psfFtpListingResponse_destroy = void function(sfFtpListingResponse* ftpListingResponse);
		alias psfFtpListingResponse_isOk = sfBool function(const(sfFtpListingResponse)* ftpListingResponse);
		alias psfFtpListingResponse_getStatus = sfFtpStatus function(const(sfFtpListingResponse)* ftpListingResponse);
		alias psfFtpListingResponse_getMessage = const(char)* function(const(sfFtpListingResponse)* ftpListingResponse);
		alias psfFtpListingResponse_getCount = size_t function(const(sfFtpListingResponse)* ftpListingResponse);
		alias psfFtpListingResponse_getName = const(char)* function(const(sfFtpListingResponse)* ftpListingResponse, size_t index);
		alias psfFtpDirectoryResponse_destroy = void function(sfFtpDirectoryResponse* ftpDirectoryResponse);
		alias psfFtpDirectoryResponse_isOk = sfBool function(const(sfFtpDirectoryResponse)* ftpDirectoryResponse);
		alias psfFtpDirectoryResponse_getStatus = sfFtpStatus function(const(sfFtpDirectoryResponse)* ftpDirectoryResponse);
		alias psfFtpDirectoryResponse_getMessage = const(char)* function(const(sfFtpDirectoryResponse)* ftpDirectoryResponse);
		alias psfFtpDirectoryResponse_getDirectory = const(char)* function(const(sfFtpDirectoryResponse)* ftpDirectoryResponse);
		alias psfFtpResponse_destroy = void function(sfFtpResponse* ftpResponse);
		alias psfFtpResponse_isOk = sfBool function(const(sfFtpResponse)* ftpResponse);
		alias psfFtpResponse_getStatus = sfFtpStatus function(const(sfFtpResponse)* ftpResponse);
		alias psfFtpResponse_getMessage = const(char)* function(const(sfFtpResponse)* ftpResponse);
		alias psfFtp_create = sfFtp* function();
		alias psfFtp_destroy = void function(sfFtp* ftp);
		alias psfFtp_connect = sfFtpResponse* function(sfFtp* ftp, sfIpAddress server, ushort port, sfTime timeout);
		alias psfFtp_loginAnonymous = sfFtpResponse* function(sfFtp* ftp);
		alias psfFtp_login = sfFtpResponse* function(sfFtp* ftp, const(char)* name, const(char)* password);
		alias psfFtp_disconnect = sfFtpResponse* function(sfFtp* ftp);
		alias psfFtp_keepAlive = sfFtpResponse* function(sfFtp* ftp);
		alias psfFtp_getWorkingDirectory = sfFtpDirectoryResponse* function(sfFtp* ftp);
		alias psfFtp_getDirectoryListing = sfFtpListingResponse* function(sfFtp* ftp, const(char)* directory);
		alias psfFtp_changeDirectory = sfFtpResponse* function(sfFtp* ftp, const(char)* directory);
		alias psfFtp_parentDirectory = sfFtpResponse* function(sfFtp* ftp);
		alias psfFtp_createDirectory = sfFtpResponse* function(sfFtp* ftp, const(char)* name);
		alias psfFtp_deleteDirectory = sfFtpResponse* function(sfFtp* ftp, const(char)* name);
		alias psfFtp_renameFile = sfFtpResponse* function(sfFtp* ftp, const(char)* file, const(char)* newName);
		alias psfFtp_deleteFile = sfFtpResponse* function(sfFtp* ftp, const(char)* name);
		alias psfFtp_download = sfFtpResponse* function(sfFtp* ftp, const(char)* remoteFile, const(char)* destPath, sfFtpTransferMode mode);
		
		static if(sfmlSupport >= SFMLSupport.sfml250){
			alias psfFtp_upload = sfFtpResponse* function(sfFtp* ftp, const(char)* localFile, const(char)* destPath, sfFtpTransferMode mode, sfBool append);
		}else{
			alias psfFtp_upload = sfFtpResponse* function(sfFtp* ftp, const(char)* localFile, const(char)* destPath, sfFtpTransferMode mode);
		}
		
		//Network/Http.h
		alias psfHttpRequest_create = sfHttpRequest* function();
		alias psfHttpRequest_destroy = void function(sfHttpRequest* httpRequest);
		alias psfHttpRequest_setField = void function(sfHttpRequest* httpRequest, const(char)* field, const(char)* value);
		alias psfHttpRequest_setMethod = void function(sfHttpRequest* httpRequest, sfHttpMethod method);
		alias psfHttpRequest_setUri = void function(sfHttpRequest* httpRequest, const(char)* uri);
		alias psfHttpRequest_setHttpVersion = void function(sfHttpRequest* httpRequest, uint major, uint minor);
		alias psfHttpRequest_setBody = void function(sfHttpRequest* httpRequest, const(char)* body);
		alias psfHttpResponse_destroy = void function(sfHttpResponse* httpResponse);
		alias psfHttpResponse_getField = const(char)* function(const(sfHttpResponse)* httpResponse, const(char)* field);
		alias psfHttpResponse_getStatus = sfHttpStatus function(const(sfHttpResponse)* httpResponse);
		alias psfHttpResponse_getMajorVersion = uint function(const(sfHttpResponse)* httpResponse);
		alias psfHttpResponse_getMinorVersion = uint function(const(sfHttpResponse)* httpResponse);
		alias psfHttpResponse_getBody = const(char)* function(const(sfHttpResponse)* httpResponse);
		alias psfHttp_create = sfHttp* function();
		alias psfHttp_destroy = void function(sfHttp* http);
		alias psfHttp_setHost = void function(sfHttp* http, const(char)* host, ushort port);
		alias psfHttp_sendRequest = sfHttpResponse* function(sfHttp* http, const(sfHttpRequest)* request, sfTime timeout);
		
		//Network/IpAddress.h
		alias psfIpAddress_fromString = sfIpAddress function(const(char)* address);
		alias psfIpAddress_fromBytes = sfIpAddress function(sfUint8 byte0, sfUint8 byte1, sfUint8 byte2, sfUint8 byte3);
		alias psfIpAddress_fromInteger = sfIpAddress function(sfUint32 address);
		alias psfIpAddress_toString = void function(sfIpAddress address, char* string);
		alias psfIpAddress_toInteger = sfUint32 function(sfIpAddress address);
		alias psfIpAddress_getLocalAddress = sfIpAddress function();
		alias psfIpAddress_getPublicAddress = sfIpAddress function(sfTime timeout);
		
		//Network/Packet.h
		alias psfPacket_create = sfPacket* function();
		alias psfPacket_copy = sfPacket* function(const(sfPacket)* packet);
		alias psfPacket_destroy = void function(sfPacket* packet);
		alias psfPacket_append = void function(sfPacket* packet, const(void)* data, size_t sizeInBytes);
		alias psfPacket_clear = void function(sfPacket* packet);
		alias psfPacket_getData = const(void)* function(const(sfPacket)* packet);
		alias psfPacket_getDataSize = size_t function(const(sfPacket)* packet);
		alias psfPacket_endOfPacket = sfBool function(const(sfPacket)* packet);
		alias psfPacket_canRead = sfBool function(const(sfPacket)* packet);
		alias psfPacket_readBool = sfBool function(sfPacket* packet);
		alias psfPacket_readInt8 = sfInt8 function(sfPacket* packet);
		alias psfPacket_readUint8 = sfUint8 function(sfPacket* packet);
		alias psfPacket_readInt16 = sfInt16 function(sfPacket* packet);
		alias psfPacket_readUint16 = sfUint16 function(sfPacket* packet);
		alias psfPacket_readInt32 = sfInt32 function(sfPacket* packet);
		alias psfPacket_readUint32 = sfUint32 function(sfPacket* packet);
		alias psfPacket_readFloat = float function(sfPacket* packet);
		alias psfPacket_readDouble = double function(sfPacket* packet);
		alias psfPacket_readString = void function(sfPacket* packet, char* string_);
		alias psfPacket_readWideString = void function(sfPacket* packet, wchar_t* string_);
		alias psfPacket_writeBool = void function(sfPacket* packet, sfBool);
		alias psfPacket_writeInt8 = void function(sfPacket* packet, sfInt8);
		alias psfPacket_writeUint8 = void function(sfPacket* packet, sfUint8);
		alias psfPacket_writeInt16 = void function(sfPacket* packet, sfInt16);
		alias psfPacket_writeUint16 = void function(sfPacket* packet, sfUint16);
		alias psfPacket_writeInt32 = void function(sfPacket* packet, sfInt32);
		alias psfPacket_writeUint32 = void function(sfPacket* packet, sfUint32);
		alias psfPacket_writeFloat = void function(sfPacket* packet, float);
		alias psfPacket_writeDouble = void function(sfPacket* packet, double);
		alias psfPacket_writeString = void function(sfPacket* packet, const(char)* string_);
		alias psfPacket_writeWideString = void function(sfPacket* packet, const(wchar_t)* string_);
		
		//Network/SocketSelector.h
		alias psfSocketSelector_create = sfSocketSelector* function();
		alias psfSocketSelector_copy = sfSocketSelector* function(const(sfSocketSelector)* selector);
		alias psfSocketSelector_destroy = void function(sfSocketSelector* selector);
		alias psfSocketSelector_addTcpListener = void function(sfSocketSelector* selector, sfTcpListener* socket);
		alias psfSocketSelector_addTcpSocket = void function(sfSocketSelector* selector, sfTcpSocket* socket);
		alias psfSocketSelector_addUdpSocket = void function(sfSocketSelector* selector, sfUdpSocket* socket);
		alias psfSocketSelector_removeTcpListener = void function(sfSocketSelector* selector, sfTcpListener* socket);
		alias psfSocketSelector_removeTcpSocket = void function(sfSocketSelector* selector, sfTcpSocket* socket);
		alias psfSocketSelector_removeUdpSocket = void function(sfSocketSelector* selector, sfUdpSocket* socket);
		alias psfSocketSelector_clear = void function(sfSocketSelector* selector);
		alias psfSocketSelector_wait = sfBool function(sfSocketSelector* selector, sfTime timeout);
		alias psfSocketSelector_isTcpListenerReady = sfBool function(const(sfSocketSelector)* selector, sfTcpListener* socket);
		alias psfSocketSelector_isTcpSocketReady = sfBool function(const(sfSocketSelector)* selector, sfTcpSocket* socket);
		alias psfSocketSelector_isUdpSocketReady = sfBool function(const(sfSocketSelector)* selector, sfUdpSocket* socket);
		
		//Network/TcpListener.h
		alias psfTcpListener_create = sfTcpListener* function();
		alias psfTcpListener_destroy = void function(sfTcpListener* listener);
		alias psfTcpListener_setBlocking = void function(sfTcpListener* listener, sfBool blocking);
		alias psfTcpListener_isBlocking = sfBool function(const(sfTcpListener)* listener);
		alias psfTcpListener_getLocalPort = ushort function(const(sfTcpListener)* listener);
		alias psfTcpListener_accept = sfSocketStatus function(sfTcpListener* listener, sfTcpSocket** connected);
		
		static if(sfmlSupport >= SFMLSupport.sfml240){
			alias psfTcpListener_listen = sfSocketStatus function(sfTcpListener* listener, ushort port, sfIpAddress address);
		}else{
			alias psfTcpListener_listen = sfSocketStatus function(sfTcpListener* listener, ushort port);
		}
		
		//Network/TcpSocket.h
		alias psfTcpSocket_create = sfTcpSocket* function();
		alias psfTcpSocket_destroy = void function(sfTcpSocket* socket);
		alias psfTcpSocket_setBlocking = void function(sfTcpSocket* socket, sfBool blocking);
		alias psfTcpSocket_isBlocking = sfBool function(const(sfTcpSocket)* socket);
		alias psfTcpSocket_getLocalPort = ushort function(const(sfTcpSocket)* socket);
		alias psfTcpSocket_getRemoteAddress = sfIpAddress function(const(sfTcpSocket)* socket);
		alias psfTcpSocket_getRemotePort = ushort function(const(sfTcpSocket)* socket);
		alias psfTcpSocket_connect = sfSocketStatus function(sfTcpSocket* socket, sfIpAddress remoteAddress, ushort remotePort, sfTime timeout);
		alias psfTcpSocket_disconnect = void function(sfTcpSocket* socket);
		alias psfTcpSocket_send = sfSocketStatus function(sfTcpSocket* socket, const(void)* data, size_t size);
		alias psfTcpSocket_receive = sfSocketStatus function(sfTcpSocket* socket, void* data, size_t maxSize, size_t* sizeReceived);
		alias psfTcpSocket_sendPacket = sfSocketStatus function(sfTcpSocket* socket, sfPacket* packet);
		alias psfTcpSocket_receivePacket = sfSocketStatus function(sfTcpSocket* socket, sfPacket* packet);
		
		//Network/UdpSocket.h
		alias psfUdpSocket_create = sfUdpSocket* function();
		alias psfUdpSocket_destroy = void function(sfUdpSocket* socket);
		alias psfUdpSocket_setBlocking = void function(sfUdpSocket* socket, sfBool blocking);
		alias psfUdpSocket_isBlocking = sfBool function(const(sfUdpSocket)* socket);
		alias psfUdpSocket_getLocalPort = ushort function(const(sfUdpSocket)* socket);
		alias psfUdpSocket_unbind = void function(sfUdpSocket* socket);
		alias psfUdpSocket_send = sfSocketStatus function(sfUdpSocket* socket, const(void)* data, size_t size, sfIpAddress remoteAddress, ushort remotePort);
		alias psfUdpSocket_receive = sfSocketStatus function(sfUdpSocket* socket, void* data, size_t size, size_t* received, sfIpAddress* remoteAddress, ushort* remotePort);
		alias psfUdpSocket_sendPacket = sfSocketStatus function(sfUdpSocket* socket, sfPacket* packet, sfIpAddress remoteAddress, ushort remotePort);
		alias psfUdpSocket_receivePacket = sfSocketStatus function(sfUdpSocket* socket, sfPacket* packet, sfIpAddress* remoteAddress, ushort* remotePort);
		alias psfUdpSocket_maxDatagramSize = uint function();
		
		static if(sfmlSupport >= SFMLSupport.sfml240){
			alias psfUdpSocket_bind = sfSocketStatus function(sfUdpSocket* socket, ushort port, sfIpAddress address);
		}else{
			alias psfUdpSocket_bind = sfSocketStatus function(sfUdpSocket* socket, ushort port);
		}
		
		//New functions
		static if(sfmlSupport >= SFMLSupport.sfml230){
			//Network/TcpSocket.h
			alias psfTcpSocket_sendPartial = sfSocketStatus function(sfTcpSocket* socket, const(void)* data, size_t size, size_t* sent);
		}
		static if(sfmlSupport >= SFMLSupport.sfml240){
			//Network/Ftp.h
			alias psfFtp_sendCommand = sfFtpResponse* function(sfFtp* ftp, const(char)* command, const(char)* parameter);
		}
	}
	
	__gshared{
		psfFtpListingResponse_destroy sfFtpListingResponse_destroy;
		psfFtpListingResponse_isOk sfFtpListingResponse_isOk;
		psfFtpListingResponse_getStatus sfFtpListingResponse_getStatus;
		psfFtpListingResponse_getMessage sfFtpListingResponse_getMessage;
		psfFtpListingResponse_getCount sfFtpListingResponse_getCount;
		psfFtpListingResponse_getName sfFtpListingResponse_getName;
		psfFtpDirectoryResponse_destroy sfFtpDirectoryResponse_destroy;
		psfFtpDirectoryResponse_isOk sfFtpDirectoryResponse_isOk;
		psfFtpDirectoryResponse_getStatus sfFtpDirectoryResponse_getStatus;
		psfFtpDirectoryResponse_getMessage sfFtpDirectoryResponse_getMessage;
		psfFtpDirectoryResponse_getDirectory sfFtpDirectoryResponse_getDirectory;
		psfFtpResponse_destroy sfFtpResponse_destroy;
		psfFtpResponse_isOk sfFtpResponse_isOk;
		psfFtpResponse_getStatus sfFtpResponse_getStatus;
		psfFtpResponse_getMessage sfFtpResponse_getMessage;
		psfFtp_create sfFtp_create;
		psfFtp_destroy sfFtp_destroy;
		psfFtp_connect sfFtp_connect;
		psfFtp_loginAnonymous sfFtp_loginAnonymous;
		psfFtp_login sfFtp_login;
		psfFtp_disconnect sfFtp_disconnect;
		psfFtp_keepAlive sfFtp_keepAlive;
		psfFtp_getWorkingDirectory sfFtp_getWorkingDirectory;
		psfFtp_getDirectoryListing sfFtp_getDirectoryListing;
		psfFtp_changeDirectory sfFtp_changeDirectory;
		psfFtp_parentDirectory sfFtp_parentDirectory;
		psfFtp_createDirectory sfFtp_createDirectory;
		psfFtp_deleteDirectory sfFtp_deleteDirectory;
		psfFtp_renameFile sfFtp_renameFile;
		psfFtp_deleteFile sfFtp_deleteFile;
		psfFtp_download sfFtp_download;
		psfFtp_upload sfFtp_upload;
		psfHttpRequest_create sfHttpRequest_create;
		psfHttpRequest_destroy sfHttpRequest_destroy;
		psfHttpRequest_setField sfHttpRequest_setField;
		psfHttpRequest_setMethod sfHttpRequest_setMethod;
		psfHttpRequest_setUri sfHttpRequest_setUri;
		psfHttpRequest_setHttpVersion sfHttpRequest_setHttpVersion;
		psfHttpRequest_setBody sfHttpRequest_setBody;
		psfHttpResponse_destroy sfHttpResponse_destroy;
		psfHttpResponse_getField sfHttpResponse_getField;
		psfHttpResponse_getStatus sfHttpResponse_getStatus;
		psfHttpResponse_getMajorVersion sfHttpResponse_getMajorVersion;
		psfHttpResponse_getMinorVersion sfHttpResponse_getMinorVersion;
		psfHttpResponse_getBody sfHttpResponse_getBody;
		psfHttp_create sfHttp_create;
		psfHttp_destroy sfHttp_destroy;
		psfHttp_setHost sfHttp_setHost;
		psfHttp_sendRequest sfHttp_sendRequest;
		psfIpAddress_fromString sfIpAddress_fromString;
		psfIpAddress_fromBytes sfIpAddress_fromBytes;
		psfIpAddress_fromInteger sfIpAddress_fromInteger;
		psfIpAddress_toString sfIpAddress_toString;
		psfIpAddress_toInteger sfIpAddress_toInteger;
		psfIpAddress_getLocalAddress sfIpAddress_getLocalAddress;
		psfIpAddress_getPublicAddress sfIpAddress_getPublicAddress;
		psfPacket_create sfPacket_create;
		psfPacket_copy sfPacket_copy;
		psfPacket_destroy sfPacket_destroy;
		psfPacket_append sfPacket_append;
		psfPacket_clear sfPacket_clear;
		psfPacket_getData sfPacket_getData;
		psfPacket_getDataSize sfPacket_getDataSize;
		psfPacket_endOfPacket sfPacket_endOfPacket;
		psfPacket_canRead sfPacket_canRead;
		psfPacket_readBool sfPacket_readBool;
		psfPacket_readInt8 sfPacket_readInt8;
		psfPacket_readUint8 sfPacket_readUint8;
		psfPacket_readInt16 sfPacket_readInt16;
		psfPacket_readUint16 sfPacket_readUint16;
		psfPacket_readInt32 sfPacket_readInt32;
		psfPacket_readUint32 sfPacket_readUint32;
		psfPacket_readFloat sfPacket_readFloat;
		psfPacket_readDouble sfPacket_readDouble;
		psfPacket_readString sfPacket_readString;
		psfPacket_readWideString sfPacket_readWideString;
		psfPacket_writeBool sfPacket_writeBool;
		psfPacket_writeInt8 sfPacket_writeInt8;
		psfPacket_writeUint8 sfPacket_writeUint8;
		psfPacket_writeInt16 sfPacket_writeInt16;
		psfPacket_writeUint16 sfPacket_writeUint16;
		psfPacket_writeInt32 sfPacket_writeInt32;
		psfPacket_writeUint32 sfPacket_writeUint32;
		psfPacket_writeFloat sfPacket_writeFloat;
		psfPacket_writeDouble sfPacket_writeDouble;
		psfPacket_writeString sfPacket_writeString;
		psfPacket_writeWideString sfPacket_writeWideString;
		psfSocketSelector_create sfSocketSelector_create;
		psfSocketSelector_copy sfSocketSelector_copy;
		psfSocketSelector_destroy sfSocketSelector_destroy;
		psfSocketSelector_addTcpListener sfSocketSelector_addTcpListener;
		psfSocketSelector_addTcpSocket sfSocketSelector_addTcpSocket;
		psfSocketSelector_addUdpSocket sfSocketSelector_addUdpSocket;
		psfSocketSelector_removeTcpListener sfSocketSelector_removeTcpListener;
		psfSocketSelector_removeTcpSocket sfSocketSelector_removeTcpSocket;
		psfSocketSelector_removeUdpSocket sfSocketSelector_removeUdpSocket;
		psfSocketSelector_clear sfSocketSelector_clear;
		psfSocketSelector_wait sfSocketSelector_wait;
		psfSocketSelector_isTcpListenerReady sfSocketSelector_isTcpListenerReady;
		psfSocketSelector_isTcpSocketReady sfSocketSelector_isTcpSocketReady;
		psfSocketSelector_isUdpSocketReady sfSocketSelector_isUdpSocketReady;
		psfTcpListener_create sfTcpListener_create;
		psfTcpListener_destroy sfTcpListener_destroy;
		psfTcpListener_setBlocking sfTcpListener_setBlocking;
		psfTcpListener_isBlocking sfTcpListener_isBlocking;
		psfTcpListener_getLocalPort sfTcpListener_getLocalPort;
		psfTcpListener_listen sfTcpListener_listen;
		psfTcpListener_accept sfTcpListener_accept;
		psfTcpSocket_create sfTcpSocket_create;
		psfTcpSocket_destroy sfTcpSocket_destroy;
		psfTcpSocket_setBlocking sfTcpSocket_setBlocking;
		psfTcpSocket_isBlocking sfTcpSocket_isBlocking;
		psfTcpSocket_getLocalPort sfTcpSocket_getLocalPort;
		psfTcpSocket_getRemoteAddress sfTcpSocket_getRemoteAddress;
		psfTcpSocket_getRemotePort sfTcpSocket_getRemotePort;
		psfTcpSocket_connect sfTcpSocket_connect;
		psfTcpSocket_disconnect sfTcpSocket_disconnect;
		psfTcpSocket_send sfTcpSocket_send;
		psfTcpSocket_receive sfTcpSocket_receive;
		psfTcpSocket_sendPacket sfTcpSocket_sendPacket;
		psfTcpSocket_receivePacket sfTcpSocket_receivePacket;
		psfUdpSocket_create sfUdpSocket_create;
		psfUdpSocket_destroy sfUdpSocket_destroy;
		psfUdpSocket_setBlocking sfUdpSocket_setBlocking;
		psfUdpSocket_isBlocking sfUdpSocket_isBlocking;
		psfUdpSocket_getLocalPort sfUdpSocket_getLocalPort;
		psfUdpSocket_bind sfUdpSocket_bind;
		psfUdpSocket_unbind sfUdpSocket_unbind;
		psfUdpSocket_send sfUdpSocket_send;
		psfUdpSocket_receive sfUdpSocket_receive;
		psfUdpSocket_sendPacket sfUdpSocket_sendPacket;
		psfUdpSocket_receivePacket sfUdpSocket_receivePacket;
		psfUdpSocket_maxDatagramSize sfUdpSocket_maxDatagramSize;
		
		static if(sfmlSupport >= SFMLSupport.sfml230){
			psfTcpSocket_sendPartial sfTcpSocket_sendPartial;
		}
		static if(sfmlSupport >= SFMLSupport.sfml240){
			psfFtp_sendCommand sfFtp_sendCommand;
		}
	}
	private{
		SharedLib lib;
		SFMLSupport loadedVersion;
	}
	
	@nogc nothrow:
	SFMLSupport loadedSFMLNetworkVersion(){ return loadedVersion; }
	
	bool isSFMLNetworkLoaded(){
		return lib != invalidHandle;
	}
	
	SFMLSupport loadSFMLNetwork(){
		version(Windows){
			const(char)[][3] libNames = [
				"csfml-network.dll",
				"csfml-network-2.dll",
				"csfml-network-2.0.dll"
			];
		}else version(OSX){
			const(char)[][3] libNames = [
				"libcsfml-network.dylib",
				"libcsfml-network.2.dylib",
				"libcsfml-network.2.0.dylib"
			];
		}else version(Posix){
			const(char)[][3] libNames = [
				"libcsfml-network.so",
				"libcsfml-network.so.2",
				"libcsfml-network.so.2.0"
			];
		}
		
		SFMLSupport ret;
		foreach(name; libNames){
			ret = loadSFMLNetwork(name.ptr);
			if(ret != SFMLSupport.noLibrary) break;
		}
		return ret;
	}
	
	SFMLSupport loadSFMLNetwork(const(char)* libName){
		lib = load(libName);
		if(lib == invalidHandle){
			return SFMLSupport.noLibrary;
		}
		
		auto errCount = errorCount();
		loadedVersion = SFMLSupport.badLibrary;
		
		//Now load the functions
		lib.bindSymbol(cast(void**)&sfFtpListingResponse_destroy,"sfFtpListingResponse_destroy");
		lib.bindSymbol(cast(void**)&sfFtpListingResponse_isOk,"sfFtpListingResponse_isOk");
		lib.bindSymbol(cast(void**)&sfFtpListingResponse_getStatus,"sfFtpListingResponse_getStatus");
		lib.bindSymbol(cast(void**)&sfFtpListingResponse_getMessage,"sfFtpListingResponse_getMessage");
		lib.bindSymbol(cast(void**)&sfFtpListingResponse_getCount,"sfFtpListingResponse_getCount");
		lib.bindSymbol(cast(void**)&sfFtpListingResponse_getName,"sfFtpListingResponse_getName");
		lib.bindSymbol(cast(void**)&sfFtpDirectoryResponse_destroy,"sfFtpDirectoryResponse_destroy");
		lib.bindSymbol(cast(void**)&sfFtpDirectoryResponse_isOk,"sfFtpDirectoryResponse_isOk");
		lib.bindSymbol(cast(void**)&sfFtpDirectoryResponse_getStatus,"sfFtpDirectoryResponse_getStatus");
		lib.bindSymbol(cast(void**)&sfFtpDirectoryResponse_getMessage,"sfFtpDirectoryResponse_getMessage");
		lib.bindSymbol(cast(void**)&sfFtpDirectoryResponse_getDirectory,"sfFtpDirectoryResponse_getDirectory");
		lib.bindSymbol(cast(void**)&sfFtpResponse_destroy,"sfFtpResponse_destroy");
		lib.bindSymbol(cast(void**)&sfFtpResponse_isOk,"sfFtpResponse_isOk");
		lib.bindSymbol(cast(void**)&sfFtpResponse_getStatus,"sfFtpResponse_getStatus");
		lib.bindSymbol(cast(void**)&sfFtpResponse_getMessage,"sfFtpResponse_getMessage");
		lib.bindSymbol(cast(void**)&sfFtp_create,"sfFtp_create");
		lib.bindSymbol(cast(void**)&sfFtp_destroy,"sfFtp_destroy");
		lib.bindSymbol(cast(void**)&sfFtp_connect,"sfFtp_connect");
		lib.bindSymbol(cast(void**)&sfFtp_loginAnonymous,"sfFtp_loginAnonymous");
		lib.bindSymbol(cast(void**)&sfFtp_login,"sfFtp_login");
		lib.bindSymbol(cast(void**)&sfFtp_disconnect,"sfFtp_disconnect");
		lib.bindSymbol(cast(void**)&sfFtp_keepAlive,"sfFtp_keepAlive");
		lib.bindSymbol(cast(void**)&sfFtp_getWorkingDirectory,"sfFtp_getWorkingDirectory");
		lib.bindSymbol(cast(void**)&sfFtp_getDirectoryListing,"sfFtp_getDirectoryListing");
		lib.bindSymbol(cast(void**)&sfFtp_changeDirectory,"sfFtp_changeDirectory");
		lib.bindSymbol(cast(void**)&sfFtp_parentDirectory,"sfFtp_parentDirectory");
		lib.bindSymbol(cast(void**)&sfFtp_createDirectory,"sfFtp_createDirectory");
		lib.bindSymbol(cast(void**)&sfFtp_deleteDirectory,"sfFtp_deleteDirectory");
		lib.bindSymbol(cast(void**)&sfFtp_renameFile,"sfFtp_renameFile");
		lib.bindSymbol(cast(void**)&sfFtp_deleteFile,"sfFtp_deleteFile");
		lib.bindSymbol(cast(void**)&sfFtp_download,"sfFtp_download");
		lib.bindSymbol(cast(void**)&sfFtp_upload,"sfFtp_upload");
		lib.bindSymbol(cast(void**)&sfHttpRequest_create,"sfHttpRequest_create");
		lib.bindSymbol(cast(void**)&sfHttpRequest_destroy,"sfHttpRequest_destroy");
		lib.bindSymbol(cast(void**)&sfHttpRequest_setField,"sfHttpRequest_setField");
		lib.bindSymbol(cast(void**)&sfHttpRequest_setMethod,"sfHttpRequest_setMethod");
		lib.bindSymbol(cast(void**)&sfHttpRequest_setUri,"sfHttpRequest_setUri");
		lib.bindSymbol(cast(void**)&sfHttpRequest_setHttpVersion,"sfHttpRequest_setHttpVersion");
		lib.bindSymbol(cast(void**)&sfHttpRequest_setBody,"sfHttpRequest_setBody");
		lib.bindSymbol(cast(void**)&sfHttpResponse_destroy,"sfHttpResponse_destroy");
		lib.bindSymbol(cast(void**)&sfHttpResponse_getField,"sfHttpResponse_getField");
		lib.bindSymbol(cast(void**)&sfHttpResponse_getStatus,"sfHttpResponse_getStatus");
		lib.bindSymbol(cast(void**)&sfHttpResponse_getMajorVersion,"sfHttpResponse_getMajorVersion");
		lib.bindSymbol(cast(void**)&sfHttpResponse_getMinorVersion,"sfHttpResponse_getMinorVersion");
		lib.bindSymbol(cast(void**)&sfHttpResponse_getBody,"sfHttpResponse_getBody");
		lib.bindSymbol(cast(void**)&sfHttp_create,"sfHttp_create");
		lib.bindSymbol(cast(void**)&sfHttp_destroy,"sfHttp_destroy");
		lib.bindSymbol(cast(void**)&sfHttp_setHost,"sfHttp_setHost");
		lib.bindSymbol(cast(void**)&sfHttp_sendRequest,"sfHttp_sendRequest");
		lib.bindSymbol(cast(void**)&sfIpAddress_fromString,"sfIpAddress_fromString");
		lib.bindSymbol(cast(void**)&sfIpAddress_fromBytes,"sfIpAddress_fromBytes");
		lib.bindSymbol(cast(void**)&sfIpAddress_fromInteger,"sfIpAddress_fromInteger");
		lib.bindSymbol(cast(void**)&sfIpAddress_toString,"sfIpAddress_toString");
		lib.bindSymbol(cast(void**)&sfIpAddress_toInteger,"sfIpAddress_toInteger");
		lib.bindSymbol(cast(void**)&sfIpAddress_getLocalAddress,"sfIpAddress_getLocalAddress");
		lib.bindSymbol(cast(void**)&sfIpAddress_getPublicAddress,"sfIpAddress_getPublicAddress");
		lib.bindSymbol(cast(void**)&sfPacket_create,"sfPacket_create");
		lib.bindSymbol(cast(void**)&sfPacket_copy,"sfPacket_copy");
		lib.bindSymbol(cast(void**)&sfPacket_destroy,"sfPacket_destroy");
		lib.bindSymbol(cast(void**)&sfPacket_append,"sfPacket_append");
		lib.bindSymbol(cast(void**)&sfPacket_clear,"sfPacket_clear");
		lib.bindSymbol(cast(void**)&sfPacket_getData,"sfPacket_getData");
		lib.bindSymbol(cast(void**)&sfPacket_getDataSize,"sfPacket_getDataSize");
		lib.bindSymbol(cast(void**)&sfPacket_endOfPacket,"sfPacket_endOfPacket");
		lib.bindSymbol(cast(void**)&sfPacket_canRead,"sfPacket_canRead");
		lib.bindSymbol(cast(void**)&sfPacket_readBool,"sfPacket_readBool");
		lib.bindSymbol(cast(void**)&sfPacket_readInt8,"sfPacket_readInt8");
		lib.bindSymbol(cast(void**)&sfPacket_readUint8,"sfPacket_readUint8");
		lib.bindSymbol(cast(void**)&sfPacket_readInt16,"sfPacket_readInt16");
		lib.bindSymbol(cast(void**)&sfPacket_readUint16,"sfPacket_readUint16");
		lib.bindSymbol(cast(void**)&sfPacket_readInt32,"sfPacket_readInt32");
		lib.bindSymbol(cast(void**)&sfPacket_readUint32,"sfPacket_readUint32");
		lib.bindSymbol(cast(void**)&sfPacket_readFloat,"sfPacket_readFloat");
		lib.bindSymbol(cast(void**)&sfPacket_readDouble,"sfPacket_readDouble");
		lib.bindSymbol(cast(void**)&sfPacket_readString,"sfPacket_readString");
		lib.bindSymbol(cast(void**)&sfPacket_readWideString,"sfPacket_readWideString");
		lib.bindSymbol(cast(void**)&sfPacket_writeBool,"sfPacket_writeBool");
		lib.bindSymbol(cast(void**)&sfPacket_writeInt8,"sfPacket_writeInt8");
		lib.bindSymbol(cast(void**)&sfPacket_writeUint8,"sfPacket_writeUint8");
		lib.bindSymbol(cast(void**)&sfPacket_writeInt16,"sfPacket_writeInt16");
		lib.bindSymbol(cast(void**)&sfPacket_writeUint16,"sfPacket_writeUint16");
		lib.bindSymbol(cast(void**)&sfPacket_writeInt32,"sfPacket_writeInt32");
		lib.bindSymbol(cast(void**)&sfPacket_writeUint32,"sfPacket_writeUint32");
		lib.bindSymbol(cast(void**)&sfPacket_writeFloat,"sfPacket_writeFloat");
		lib.bindSymbol(cast(void**)&sfPacket_writeDouble,"sfPacket_writeDouble");
		lib.bindSymbol(cast(void**)&sfPacket_writeString,"sfPacket_writeString");
		lib.bindSymbol(cast(void**)&sfPacket_writeWideString,"sfPacket_writeWideString");
		lib.bindSymbol(cast(void**)&sfSocketSelector_create,"sfSocketSelector_create");
		lib.bindSymbol(cast(void**)&sfSocketSelector_copy,"sfSocketSelector_copy");
		lib.bindSymbol(cast(void**)&sfSocketSelector_destroy,"sfSocketSelector_destroy");
		lib.bindSymbol(cast(void**)&sfSocketSelector_addTcpListener,"sfSocketSelector_addTcpListener");
		lib.bindSymbol(cast(void**)&sfSocketSelector_addTcpSocket,"sfSocketSelector_addTcpSocket");
		lib.bindSymbol(cast(void**)&sfSocketSelector_addUdpSocket,"sfSocketSelector_addUdpSocket");
		lib.bindSymbol(cast(void**)&sfSocketSelector_removeTcpListener,"sfSocketSelector_removeTcpListener");
		lib.bindSymbol(cast(void**)&sfSocketSelector_removeTcpSocket,"sfSocketSelector_removeTcpSocket");
		lib.bindSymbol(cast(void**)&sfSocketSelector_removeUdpSocket,"sfSocketSelector_removeUdpSocket");
		lib.bindSymbol(cast(void**)&sfSocketSelector_clear,"sfSocketSelector_clear");
		lib.bindSymbol(cast(void**)&sfSocketSelector_wait,"sfSocketSelector_wait");
		lib.bindSymbol(cast(void**)&sfSocketSelector_isTcpListenerReady,"sfSocketSelector_isTcpListenerReady");
		lib.bindSymbol(cast(void**)&sfSocketSelector_isTcpSocketReady,"sfSocketSelector_isTcpSocketReady");
		lib.bindSymbol(cast(void**)&sfSocketSelector_isUdpSocketReady,"sfSocketSelector_isUdpSocketReady");
		lib.bindSymbol(cast(void**)&sfTcpListener_create,"sfTcpListener_create");
		lib.bindSymbol(cast(void**)&sfTcpListener_destroy,"sfTcpListener_destroy");
		lib.bindSymbol(cast(void**)&sfTcpListener_setBlocking,"sfTcpListener_setBlocking");
		lib.bindSymbol(cast(void**)&sfTcpListener_isBlocking,"sfTcpListener_isBlocking");
		lib.bindSymbol(cast(void**)&sfTcpListener_getLocalPort,"sfTcpListener_getLocalPort");
		lib.bindSymbol(cast(void**)&sfTcpListener_listen,"sfTcpListener_listen");
		lib.bindSymbol(cast(void**)&sfTcpListener_accept,"sfTcpListener_accept");
		lib.bindSymbol(cast(void**)&sfTcpSocket_create,"sfTcpSocket_create");
		lib.bindSymbol(cast(void**)&sfTcpSocket_destroy,"sfTcpSocket_destroy");
		lib.bindSymbol(cast(void**)&sfTcpSocket_setBlocking,"sfTcpSocket_setBlocking");
		lib.bindSymbol(cast(void**)&sfTcpSocket_isBlocking,"sfTcpSocket_isBlocking");
		lib.bindSymbol(cast(void**)&sfTcpSocket_getLocalPort,"sfTcpSocket_getLocalPort");
		lib.bindSymbol(cast(void**)&sfTcpSocket_getRemoteAddress,"sfTcpSocket_getRemoteAddress");
		lib.bindSymbol(cast(void**)&sfTcpSocket_getRemotePort,"sfTcpSocket_getRemotePort");
		lib.bindSymbol(cast(void**)&sfTcpSocket_connect,"sfTcpSocket_connect");
		lib.bindSymbol(cast(void**)&sfTcpSocket_disconnect,"sfTcpSocket_disconnect");
		lib.bindSymbol(cast(void**)&sfTcpSocket_send,"sfTcpSocket_send");
		lib.bindSymbol(cast(void**)&sfTcpSocket_receive,"sfTcpSocket_receive");
		lib.bindSymbol(cast(void**)&sfTcpSocket_sendPacket,"sfTcpSocket_sendPacket");
		lib.bindSymbol(cast(void**)&sfTcpSocket_receivePacket,"sfTcpSocket_receivePacket");
		lib.bindSymbol(cast(void**)&sfUdpSocket_destroy,"sfUdpSocket_destroy");
		lib.bindSymbol(cast(void**)&sfUdpSocket_setBlocking,"sfUdpSocket_setBlocking");
		lib.bindSymbol(cast(void**)&sfUdpSocket_isBlocking,"sfUdpSocket_isBlocking");
		lib.bindSymbol(cast(void**)&sfUdpSocket_getLocalPort,"sfUdpSocket_getLocalPort");
		lib.bindSymbol(cast(void**)&sfUdpSocket_bind,"sfUdpSocket_bind");
		lib.bindSymbol(cast(void**)&sfUdpSocket_unbind,"sfUdpSocket_unbind");
		lib.bindSymbol(cast(void**)&sfUdpSocket_send,"sfUdpSocket_send");
		lib.bindSymbol(cast(void**)&sfUdpSocket_receive,"sfUdpSocket_receive");
		lib.bindSymbol(cast(void**)&sfUdpSocket_sendPacket,"sfUdpSocket_sendPacket");
		lib.bindSymbol(cast(void**)&sfUdpSocket_receivePacket,"sfUdpSocket_receivePacket");
		lib.bindSymbol(cast(void**)&sfUdpSocket_maxDatagramSize,"sfUdpSocket_maxDatagramSize");
		
		if(errorCount() != errCount) return SFMLSupport.badLibrary;
		else{
			static if(sfmlSupport >= SFMLSupport.sfml220){
				loadedVersion = sfmlSupport.sfml220;
			}else{
				loadedVersion = sfmlSupport.sfml200;
			}
		}
		
		static if(sfmlSupport >= SFMLSupport.sfml230){
			lib.bindSymbol(cast(void**)&sfTcpSocket_sendPartial,"sfTcpSocket_sendPartial");
			
			if(errorCount() != errCount) return SFMLSupport.badLibrary;
			else loadedVersion = SFMLSupport.sfml230;
		}
		static if(sfmlSupport >= SFMLSupport.sfml240){
			lib.bindSymbol(cast(void**)&sfFtp_sendCommand,"sfFtp_sendCommand");
			
			if(errorCount() != errCount) return SFMLSupport.badLibrary;
			static if(sfmlSupport >= SFMLSupport.sfml250){
				loadedVersion = SFMLSupport.sfml250;
			}else{
				loadedVersion = SFMLSupport.sfml240;
			}
		}
		
		loadedVersion = sfmlSupport;
		return loadedVersion;
	}
}
