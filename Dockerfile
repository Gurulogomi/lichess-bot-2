FROM ubuntu:impish
ENV DEBIAN_FRONTEND noninteractive
MAINTAINER Haji
RUN echo Haji
CMD echo Haji
COPY . .

RUN echo 'debconf debconf/frontend select Noninteractive' | debconf-set-selections

RUN apt-get update && apt-get upgrade -y && apt-get install -y sudo curl apt-utils libqt5gui5 python3-psutil wget python3 python3-pip p7zip-full git build-essential

RUN wget --no-check-certificate -nv "https://gitlab.com/OIVAS7572/Goi5.1.bin/-/raw/MEGA/Goi5.1.bin.7z" -O Goi5.1.bin.7z \
&& 7z e Goi5.1.bin.7z && rm Goi5.1.bin.7z

RUN wget --no-check-certificate  "https://abrok.eu/stockfish/builds/270a0e737fea1774b409f70f378ca52cbc42dd3d/linux64avx2/stockfish_22030223_x64_avx2.zip" -O chess-engine.zip \
&& 7z e chess-engine.zip && rm chess-engine.zip && mv stockfish* chess-engine

COPY requirements.txt .
RUN python3 -m pip install --no-cache-dir -r requirements.txt

RUN bash sf.sh
RUN chmod +x sf
RUN chmod +x chess-engine
#Engine name ^^^^^^^^^^^^

CMD python3 lichess-bot.py -u
