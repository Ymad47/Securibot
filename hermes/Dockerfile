FROM nousresearch/hermes-agent:latest

# Install security scanning tools
RUN apt-get update && apt-get install -y \
    nmap \
    nikto \
    sslscan \
    curl \
    jq \
    && rm -rf /var/lib/apt/lists/*

# Install Python security tools
RUN pip install --no-cache-dir \
    ssh-audit \
    python-nvd3

# Create reports directory
RUN mkdir -p /root/.hermes/reports

# Default command
CMD ["hermes", "agent"]
