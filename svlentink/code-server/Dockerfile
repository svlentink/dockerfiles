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
    code-server --install-extension esbenp.prettier-vscode; \
    code-server --install-extension chenxsan.vscode-standardjs; \
    code-server --list-extensions;
#    code-server --install-extension vscodevim.vim; \

USER root
# https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=script
RUN curl -L https://aka.ms/InstallAzureCli | bash; \
    curl -sS -o /usr/local/bin/crip \
      https://raw.githubusercontent.com/svlentink/crip/master/crip.sh; \
    chmod +x /usr/local/bin/crip; \
    mkdir -p /root/.local/share/code-server; \
    ln -s /home/coder/.local/share/code-server/extensions /root/.local/share/code-server/extensions; \
    ln -s /home/coder/.kube /root/.kube; # for kubectl config.yml

USER coder

COPY --from=tf /terraform /bin/terraform
COPY --from=kubectl /kubectl /bin/kubectl

