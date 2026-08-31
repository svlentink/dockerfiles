FROM docker.io/ollama/ollama

# https://huggingface.co/spaces/DontPlanToEnd/UGI-Leaderboard
ARG LLM="artifish/llama3.2-uncensored"
ARG LLM="krith/meta-llama-3.2-1b-instruct-uncensored:IQ3_M"

RUN echo "ollama serve & sleep 1 && ollama run ${LLM}" > /entrypoint && chmod +x /entrypoint
ENTRYPOINT /entrypoint

RUN ollama serve & (sleep 1 && ollama pull ${LLM} && pkill ollama)

