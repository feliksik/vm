NAME = nerdalize/nerdvm
VERSION = 14.04
BASE_IMAGE=ubuntu-14.04-amd64.img

.PHONY : all clean build

all: build tag_latest

build: 
	docker build -t $(NAME):$(VERSION) .

clean:
	rm -f $(BASE_IMAGE)

tag_latest:
	docker tag -f $(NAME):$(VERSION) $(NAME):latest

test:
	docker run -e "RANCHER_VM=true" --cap-add NET_ADMIN -it -v /tmp/ranchervm:/ranchervm --device /dev/kvm:/dev/kvm --device /dev/net/tun:/dev/net/tun \
	$(NAME):$(VERSION)
