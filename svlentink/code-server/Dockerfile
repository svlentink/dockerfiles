FROM hashicorp/terraform AS tf
RUN cp `which terraform` /


FROM bitnami/kubectl AS kubectl
#RUN ( chown `id -u`:`id -g` `which kubectl` \
#      && \
#      cp `which kubectl` / ) \
#    || \
#    ( echo "using fallback here"; \
#      chown -R `id -u`:`id -g` `/opt/bitnami` \
#      && \
#      cp /opt/bitnami/kubectl/bin/kubectl / )
# https://github.com/GoogleContainerTools/kaniko/issues/1497
USER 0
RUN cp `which kubectl` /


FROM codercom/code-server
RUN code-server --install-extension ms-python.python; \
    code-server --install-extension msjsdiag.debugger-for-chrome; \
    code-server --install-extension vscodevim.vim; \
    code-server --install-extension esbenp.prettier-vscode; \
    code-server --install-extension chenxsan.vscode-standardjs; \
    code-server --list-extensions;

USER root
RUN curl -sS -o /usr/local/bin/crip \
      https://raw.githubusercontent.com/svlentink/crip/master/crip.sh; \
    chmod +x /usr/local/bin/crip; \
    mkdir -p /root/.local/share/code-server; \
    ln -s /home/coder/.local/share/code-server/extensions /root/.local/share/code-server/extensions

USER coder

COPY --from=tf /terraform /bin/terraform
COPY --from=kubectl /kubectl /bin/kubectl

