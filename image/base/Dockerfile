FROM ubuntu:15.04
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && apt-get install -y qemu-kvm dnsmasq bridge-utils iptables libguestfs-tools
#RUN update-guestfs-appliance
COPY startvm /var/lib/rancher/startvm
ENTRYPOINT ["/var/lib/rancher/startvm"]
VOLUME /image
CMD []
