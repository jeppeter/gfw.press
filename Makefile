
TOPDIR:=$(shell pwd)
GFW_SRC_DIR:=${TOPDIR}/src/press/gfw
GFW_BIN_DIR:=${TOPDIR}/bin/press/gfw

JAVAS:= Client.java ClientThread.java Config.java DeCryptForwardThread.java \
	Encrypt.java EncryptForwardThread.java PointThread.java Server.java \
	ServerThread.java Windows.java

JAVA_SRCS:=$(patsubst %.java,${GFW_SRC_DIR}/%.java,${JAVAS})

JAVA_CLASSES:=$(patsubst %.java,${GFW_BIN_DIR}/%.class,${JAVAS})

QUIET=
JAVAC:=javac
JAVAC_LIBS:= $(shell find ${TOPDIR}/lib/ -name '*.jar' | awk -v lastdir="${TOPDIR}/src/" '{if(NR>1){printf(":")} printf("%s",$$0)} END{if (NR) {printf(":");} printf("%s",lastdir);}')
JAVAC_FLAGS:= -cp ${JAVAC_LIBS} -d ${TOPDIR}/bin

all:${JAVA_CLASSES}


${GFW_BIN_DIR}/%.class:${GFW_SRC_DIR}/%.java ${GFW_BIN_DIR}
	${QUIET}${JAVAC} ${JAVAC_FLAGS} $<

${GFW_BIN_DIR}:
	${QUIET}mkdir -p $@

clean:
	${QUIET}rm -rf ${GFW_BIN_DIR}