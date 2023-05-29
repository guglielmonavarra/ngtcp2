FROM martenseemann/quic-network-simulator-endpoint:latest AS builder

# download and build your QUIC implementation
# [ DO WORK HERE ]
USER root
WORKDIR /

RUN echo "Hello"
RUN cat /etc/fstab

COPY dkr-prereq.sh .
RUN chmod +x ./dkr-prereq.sh
RUN ./dkr-prereq.sh




# Build second lean image
FROM martenseemann/quic-network-simulator-endpoint:latest
USER root
WORKDIR /


COPY --from=builder /usr/local/bin/h09server /h09server
COPY --from=builder /usr/local/bin/h09client /h09client
COPY --from=builder /usr/local/bin/client /client
COPY --from=builder /usr/local/bin/server /server
# copy run script and run it
COPY run_endpoint.sh .
RUN chmod +x run_endpoint.sh
ENTRYPOINT [ "./run_endpoint.sh" ]
