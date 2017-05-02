FROM python:alpine

# http://stackoverflow.com/questions/24987542/is-there-a-link-to-github-for-downloading-a-file-in-the-latest-release-of-a-repo
#RUN GITHUB_REPO='reactiveui/ReactiveUI' \
#  && apk add --no-cache curl \
#  && LATEST_RELEASE_TAG=$(curl -Is https://github.com/${GITHUB_REPO}/releases/latest \
#                         | grep Location | grep -oE '[0-9]+\.[0-9]+\.[0-9]+') || true

# since Hasicorp does not tag their release with latest, we do it hard coded for now...
ENV CTMPL_VERSION 0.18.2

RUN apk add --no-cache wget unzip && cd /tmp && \
  wget https://releases.hashicorp.com/consul-template/${CTMPL_VERSION}/consul-template_${CTMPL_VERSION}_linux_amd64.zip && \
  unzip consul-template_${CTMPL_VERSION}_linux_amd64.zip && \
  chmod +x consul-template && \
  mv consul-template /usr/local/bin && \
  rm consul-template_${CTMPL_VERSION}_linux_amd64.zip && \
  apk del wget unzip
