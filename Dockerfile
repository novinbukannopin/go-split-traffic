# Step 1: Build stage
FROM golang:1.24 AS builder

WORKDIR /app

COPY go.mod go.sum* ./
RUN go mod download

# Copy source code
COPY . .

# Build binary
RUN go build -o server .

# Step 2: Run stage
FROM gcr.io/distroless/base-debian12

WORKDIR /app
COPY --from=builder /app/server /app/server

# Default env for Cloud Run
ENV PORT=8080
ENV VERSION=v1

CMD ["/app/server"]
