FROM ubuntu

ENV DEBIAN_FRONTEND=noninteractive

ENV TZ=Asia/Shanghai
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Base image: ubuntu
RUN sed -i 's/security.ubuntu.com/mirrors.163.com/g' /etc/apt/sources.list
RUN sed -i 's/archive.ubuntu.com/mirrors.163.com/g' /etc/apt/sources.list
RUN apt-get update 
RUN apt-get -y install tzdata wget git vim python3 python3-pip 
RUN apt-get -y install libsodium-dev shadowsocks-libev simple-obfs
RUN apt-get -y autoremove --purge
RUN apt-get clean
RUN mkdir /app
WORKDIR /app
COPY ./ /app/

RUN git clone https://gitee.com/duchenpaul/SSRSpeed.git
WORKDIR /app/SSRSpeed

RUN pip3 install -i http://pypi.douban.com/simple --trusted-host pypi.douban.com -r requirements.txt

EXPOSE 10870

CMD ["python3","./web.py"]