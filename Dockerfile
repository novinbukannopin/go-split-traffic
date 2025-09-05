# Step 1: Build stage
FROM golang:1.22 AS builder

WORKDIR /app

# Copy go.mod (aja, kalau go.sum belum ada)
COPY go.mod ./
RUN go mod tidy

# Copy source code
COPY . .

# Build binary
RUN go build -o server .

# Step 2: Run stage
FROM gcr.io/distroless/base-debian12

WORKDIR /app
COPY --from=builder /app/server /app/server

ENV PORT=8080
ENV VERSION=v1

CMD ["/app/server"]
