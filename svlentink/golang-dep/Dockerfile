FROM golang:alpine

# http://stackoverflow.com/questions/24987542/is-there-a-link-to-github-for-downloading-a-file-in-the-latest-release-of-a-repo
RUN GITHUB_REPO='golang/dep'; \
  apk add --no-cache curl; \
  LATEST_RELEASE_TAG=$(curl -Is https://github.com/${GITHUB_REPO}/releases/latest \
                         | grep Location | grep -oE '[0-9]+\.[0-9]+\.[0-9]+') || true; \
  echo using v${LATEST_RELEASE_TAG}; \
  curl --show-error --fail -L -o /usr/local/bin/dep \
  https://github.com/${GITHUB_REPO}/releases/download/v${LATEST_RELEASE_TAG}/dep-linux-amd64; \
  chmod +x /usr/local/bin/dep
