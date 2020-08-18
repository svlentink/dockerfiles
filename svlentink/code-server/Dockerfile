FROM codercom/code-server
RUN code-server --install-extension ms-python.python; \
    code-server --install-extension msjsdiag.debugger-for-chrome; \
    code-server --install-extension vscodevim.vim; \
    code-server --install-extension esbenp.prettier-vscode; \
    code-server --install-extension chenxsan.vscode-standardjs; \
    code-server --list-extensions;
USER root
RUN mkdir -p /root/.local/share/code-server; \
  ln -s /home/coder/.local/share/code-server/extensions /root/.local/share/code-server/extensions
USER coder
