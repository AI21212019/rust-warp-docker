FROM rust:1.57.0-alpine as builder

RUN apk add --no-cache musl-dev
WORKDIR /opt
RUN USER=root cargo new --bin rust-warp-docker
WORKDIR /opt/rust-warp-docker
COPY ./Cargo.lock ./Cargo.lock
COPY ./Cargo.toml ./Cargo.toml
RUN cargo build --release
RUN rm ./src/*.rs
RUN rm ./target/release/deps/rust_warp_docker*

ADD ./src ./src
RUN cargo build --release

FROM scratch
WORKDIR /opt/rust-warp-docker
COPY --from=builder /opt/rust-warp-docker/target/release/rust-warp-docker .

EXPOSE 5000
CMD ["/opt/rust-warp-docker/rust-warp-docker"]