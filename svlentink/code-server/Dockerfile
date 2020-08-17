FROM codercom/code-server
RUN code-server --install-extension ms-python.python; \
  code-server --install-extension msjsdiag.debugger-for-chrome; \
  code-server --list-extensions; \
  mkdir -p /root/.local/share/code-server; \
  cp -r /home/coder/.local/share/code-server/extensions /root/.local/share/code-server/
