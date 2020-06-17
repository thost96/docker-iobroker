FROM stefanscherer/node-windows:12.16.1

LABEL maintainer="info@thorstenreichelt.de"

#download and run iobroker.exe
RUN powershell -Command \
    wget -Uri http://iobroker.live/images/win/iobroker-latest-windows-installer.exe -OutFile iobroker.exe -UseBasicParsing ; \
    Start-Process -FilePath msiexec -ArgumentList /q, /i, iobroker.exe -Wait ; \
    Remove-Item -Path iobroker.exe

RUN npm install node-gyp@7.0.0 -g

RUN iobroker repo set latest 

USER iobroker
EXPOSE 8081/tcp
#VOLUME /opt/iobroker 
CMD ["node", "/opt/iobroker/node_modules/iobroker.js-controller/controller.js"]
#HEALTHCHECK --interval=60s --timeout=10s --start-period=60s --retries=3 CMD ["curl -f http://localhost:8081/ || exit 1"]
