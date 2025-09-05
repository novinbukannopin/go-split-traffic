# Step 1: Build stage
FROM golang:1.22 AS builder

WORKDIR /app
COPY . .

RUN go mod init app && \
    go mod tidy && \
    go build -o server .

# Step 2: Run stage
FROM gcr.io/distroless/base-debian12

WORKDIR /app
COPY --from=builder /app/server /app/server

# Cloud Run expects PORT env
ENV PORT=8080
# Default version
ENV VERSION=v1

CMD ["/app/server"]
